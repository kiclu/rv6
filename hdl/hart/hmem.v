/* Copyright (C) 2024  Nikola Lukić <lukicn@protonmail.com>
 * This source describes Open Hardware and is licensed under the CERN-OHL-S v2
 *
 * You may redistribute and modify this documentation and make products
 * using it under the terms of the CERN-OHL-S v2 (https:/cern.ch/cern-ohl).
 * This documentation is distributed WITHOUT ANY EXPRESS OR IMPLIED
 * WARRANTY, INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY
 * AND FITNESS FOR A PARTICULAR PURPOSE. Please see the CERN-OHL-S v2
 * for applicable conditions.
 *
 * Source location: https://www.github.com/kiclu/rv6
 *
 * As per CERN-OHL-S v2 section 4.1, should You produce hardware based on
 * these sources, You must maintain the Source Location visible on the
 * external case of any product you make using this documentation. */

/*
 * Configurable, write-allocated L2 hart cache with write-through policy
 */

`include "../config.v"

`define hmem_read_valid_delay 4'd2

module hmem(
    // internal instruction bus
    input                [63:0] b_addr_i,
    output     [`imem_line-1:0] b_data_i,
    input                       b_rd_i,
    output                      b_dv_i,

    // internal data bus
    input                [63:0] b_addr_d,

    output     [`dmem_line-1:0] b_data_in_d,
    input                       b_rd_d,
    output                      b_dv_d,

    input      [`dmem_line-1:0] b_data_out_d,
    input                       b_wr_d,

    // external bus
    output reg           [63:0] h_addr,

    input      [`hmem_line-1:0] h_data_in,
    output reg                  h_rd,
    input                       h_dv,

    output reg [`hmem_line-1:0] h_data_out,
    output reg                  h_wr,

    // control signals
    input                [63:0] inv_addr,
    input                       inv,

    output                      stall_hmem,
    input                       rst_n,
    input                       clk
);

    wire [ `hmem_tag_len-1:0] addr_tag_i  = b_addr_i[63:64-`hmem_tag_len];
    wire [ `hmem_set_len-1:0] addr_set_i  = b_addr_i[`hmem_set_len+`hmem_offs_len-1:`hmem_offs_len];
    wire [`hmem_offs_len-1:0] addr_offs_i = b_addr_i[`hmem_offs_len-1:0];

    wire [ `hmem_tag_len-1:0] addr_tag_d  = b_addr_d[63:64-`hmem_tag_len];
    wire [ `hmem_set_len-1:0] addr_set_d  = b_addr_d[`hmem_set_len+`hmem_offs_len-1:`hmem_offs_len];
    wire [`hmem_offs_len-1:0] addr_offs_d = b_addr_d[`hmem_offs_len-1:0];

    localparam hmem_size = `hmem_sets * `hmem_ways;

    (* ram_style = "block" *)
    reg  [    `hmem_line-1:0] data [0: hmem_size-1];
    reg  [ `hmem_tag_len-1:0] tag  [0:`hmem_sets-1][0:`hmem_ways-1];
    reg                       v    [0:`hmem_sets-1][0:`hmem_ways-1];

    // replacement entry
    reg [`hmem_way_len-1:0] re [0:`hmem_sets-1];

    reg hit_qi;
    reg hit_qd;

    reg [`hmem_line-1:0] cache_line_in;
    reg [`hmem_line-1:0] cache_line_out_i;
    reg [`hmem_line-1:0] cache_line_out_d;

    wire imem_op = b_rd_i;
    wire dmem_op = b_rd_d || b_wr_d;
    wire op = imem_op || dmem_op;

    /* READ BUFFER */

    reg [`hmem_tag_len-1:0] ri_tag;
    reg [`hmem_set_len-1:0] ri_set;
    reg [   `hmem_line-1:0] ri_data;

    wire ri_hit = ri_tag == addr_tag_i && ri_set == addr_set_i;

    assign b_data_i = ri_data[8*addr_offs_i +: `imem_line];
    assign b_dv_i = ri_hit && b_rd_i;

    reg [`hmem_tag_len-1:0] rd_tag;
    reg [`hmem_set_len-1:0] rd_set;
    reg [   `hmem_line-1:0] rd_data;

    wire rd_hit = rd_tag == addr_tag_d && rd_set == addr_set_d;

    assign b_data_in_d = rd_hit ? rd_data[8*addr_offs_d +: `dmem_line] : 'bZ;
    assign b_dv_d = rd_hit && b_rd_d;

    reg [`hmem_tag_len-1:0] f_tag;

    /* CACHE DATA READ */

    reg [`hmem_set_len-1:0] set_qi;
    reg [`hmem_way_len-1:0] way_qi;

    reg rde_i;
    always @(posedge clk) if(rde_i) cache_line_out_i <= data[`hmem_ways*set_qi + way_qi];

    reg [`hmem_set_len-1:0] set_qd;
    reg [`hmem_way_len-1:0] way_qd;

    reg rde_d;
    always @(posedge clk) if(rde_d) cache_line_out_d <= data[`hmem_ways*set_qd + way_qd];

    /* WRITE BUFFER */

    reg [ `hmem_tag_len-1:0] w_tag;
    reg [ `hmem_set_len-1:0] w_set;
    reg [ `hmem_way_len-1:0] w_way;
    reg [`hmem_offs_len-1:0] w_offs;
    reg [    `dmem_line-1:0] w_data;

    reg wr_pend;

    always @(posedge clk) begin
        if(b_wr_d) begin
            w_tag  <= addr_tag_d;
            w_set  <= addr_set_d;
            w_way  <= hit_qd ? way_qd : re[addr_set_d];
            w_offs <= addr_offs_d;
            w_data <= b_data_out_d;
        end
    end

    /* CACHE DATA WRITE */

    reg [`hmem_set_len-1:0] set_d;
    reg [`hmem_way_len-1:0] way_d;

    reg wre;
    always @(posedge clk) if(wre) data[`dmem_ways*set_d + way_d] <= cache_line_in;

    reg [`hmem_line-1:0] cache_line_in_w;
    always @(*) begin
        cache_line_in_w = rd_data;
        if(wr_pend) cache_line_in_w[8*w_offs +: `dmem_line] = w_data;
    end

    /* FSM */

    reg h_dv_d;
    always @(posedge clk) h_dv_d <= h_dv;

    reg [2:0] hmem_fsm;
    reg [2:0] hmem_fsm_next;

    reg [3:0] ld_cnt;

    always @(*) begin
        h_data_out = 'bZ;
        h_rd = 0;
        h_wr = 0;

        cache_line_in = 'bZ;

        set_d = 'bZ;
        way_d = 'bZ;

        rde_i = 0;
        rde_d = 0;

        rde_i = 0;
        rde_d = 0;
        wre   = 0;

        f_tag = 0;

        hmem_fsm_next = hmem_fsm;
        case(hmem_fsm)
            // READY
            3'd0: begin
                if(b_rd_d && !hit_qd) hmem_fsm_next = 3'd3;
                if(b_rd_d &&  hit_qd) hmem_fsm_next = 3'd4;
                if(b_rd_d &&  rd_hit) hmem_fsm_next = 3'd0;
                if(b_wr_d && !hit_qd) hmem_fsm_next = 3'd3;
                if(b_wr_d &&  hit_qd) hmem_fsm_next = 3'd4;
                if(b_wr_d &&  rd_hit) hmem_fsm_next = 3'd5;
                if(b_rd_i && !hit_qi) hmem_fsm_next = 3'd1;
                if(b_rd_i &&  hit_qi) hmem_fsm_next = 3'd2;
                if(b_rd_i &&  ri_hit) hmem_fsm_next = 3'd0;
            end
            // FETCH_I
            3'd1: begin
                h_rd = 1;

                cache_line_in = h_data_in;
                set_d = addr_set_i;
                way_d = re[set_d];
                wre = h_dv;

                f_tag = addr_tag_i;

                if(h_dv_d) hmem_fsm_next = 3'd0;
            end
            // LOAD_I
            3'd2: begin
                rde_i = ld_cnt == `hmem_read_valid_delay;
                set_qi = addr_set_i;

                if(ld_cnt == 2'd0) hmem_fsm_next = 3'd0;
            end
            // FETCH_D
            3'd3: begin
                h_rd = 1;

                cache_line_in = h_data_in;
                set_d = wr_pend ? w_set : addr_set_d;
                way_d = re[set_d];
                wre   = h_dv && !wr_pend;

                f_tag = addr_tag_i;

                if(h_dv_d && b_rd_d)  hmem_fsm_next = 3'd0;
                if(h_dv_d && wr_pend) hmem_fsm_next = 3'd5;
            end
            // LOAD_D
            3'd4: begin
                rde_d = ld_cnt == `hmem_read_valid_delay;

                if(ld_cnt == 3'd0 && b_rd_d)  hmem_fsm_next = 3'd0;
                if(ld_cnt == 3'd0 && wr_pend) hmem_fsm_next = 3'd5;
            end
            // WRITE
            3'd5: begin
                cache_line_in = cache_line_in_w;
                wre = 1;
                set_d = w_set;
                way_d = w_way;

                h_data_out = cache_line_in_w;
                h_wr = 1;

                hmem_fsm_next = 3'd0;
            end
        endcase
    end

    always @(posedge clk) begin
        if(!rst_n) begin
            wr_pend <= 0;
            ld_cnt <= `hmem_read_valid_delay;

            ri_tag <= 0;
            ri_set <= 0;

            rd_tag <= 0;
            ri_set <= 0;

            hmem_fsm <= 3'd0;
        end
        else begin
            case(hmem_fsm)
                // READY
                3'd0: begin
                    if(dmem_op) h_addr <= {b_addr_d[63:`hmem_offs_len], {`hmem_offs_len{1'b0}}};
                    if(imem_op) h_addr <= {b_addr_i[63:`hmem_offs_len], {`hmem_offs_len{1'b0}}};
                    wr_pend <= b_wr_d;

                    hmem_fsm <= hmem_fsm_next;
                end
                // FETCH_I
                3'd1: begin
                    if(h_dv) begin
                        ri_tag  <= addr_tag_i;
                        ri_set  <= addr_set_i;
                        ri_data <= h_data_in;
                    end

                    hmem_fsm <= hmem_fsm_next;
                end
                // LOAD_I
                3'd2: begin
                    if(ld_cnt == 3'd0) begin
                        ri_tag  <= addr_tag_i;
                        ri_set  <= addr_set_i;
                        ri_data <= cache_line_out_i;
                        ld_cnt  <= `hmem_read_valid_delay;
                    end

                    if(ld_cnt) ld_cnt <= ld_cnt - 1;

                    hmem_fsm <= hmem_fsm_next;
                end
                // FETCH_D
                3'd3: begin
                    if(h_dv) begin
                        rd_tag  <= wr_pend ? w_tag : addr_tag_d;
                        rd_set  <= wr_pend ? w_set : addr_set_d;
                        rd_data <= h_data_in;
                    end

                    hmem_fsm <= hmem_fsm_next;
                end
                // LOAD_D
                3'd4: begin
                    if(ld_cnt == 3'd0) begin
                        rd_tag  <= wr_pend ? w_tag : addr_tag_d;
                        rd_set  <= wr_pend ? w_set : addr_set_d;
                        rd_data <= cache_line_out_d;
                        ld_cnt  <= `hmem_read_valid_delay;
                    end

                    if(ld_cnt) ld_cnt <= ld_cnt - 1;

                    hmem_fsm <= hmem_fsm_next;
                end
                // WRITE
                3'd5: begin
                    rd_data <= cache_line_in;
                    wr_pend <= 0;

                    hmem_fsm <= hmem_fsm_next;
                end
            endcase
        end
    end

    assign stall_hmem = (imem_op && !ri_hit) || (dmem_op && !rd_hit) || (wr_pend && op);

    /* HIT DETECTION */

    always @(*) begin : hmem_cache_hit_qi_check
        integer i;
        hit_qi = 0; way_qi = 0;
        for(i = 0; i < `hmem_ways; i = i + 1) begin
            if(tag[addr_set_i][i] == addr_tag_i && v[addr_set_i][i]) begin
                hit_qi = 1; way_qi = i;
            end
        end
    end

    always @(*) begin : hmem_cache_hit_qd_check
        integer i;
        hit_qd = 0; way_qd = 0;
        for(i = 0; i < `hmem_ways; i = i + 1) begin
            if(tag[addr_set_d][i] == addr_tag_d && v[addr_set_d][i]) begin
                hit_qd = 1; way_qd = i;
            end
        end
    end

    /* CACHE METADATA UPDATE */

    wire [`hmem_tag_len-1:0] inv_tag = inv_addr[63:64-`hmem_tag_len];
    wire [`hmem_set_len-1:0] inv_set = inv_addr[`hmem_set_len+`hmem_offs_len-1:`hmem_offs_len];

    always @(posedge clk) begin
        if(!rst_n) begin : hmem_clr_v
            integer s, w;
            for(s = 0; s < `hmem_sets; s = s + 1) begin
                for(w = 0; w < `hmem_ways; w = w + 1) begin
                    v[s][w] <= 0;
                end
            end
        end
        else if(wre) begin
            v  [set_d][way_d] <= 1'b1;
            tag[set_d][way_d] <= wr_pend ? w_tag : f_tag;
        end
    end

    /* REPLACEMENT POLICY */

    // LRU tree
    localparam lru_size = `hmem_ways - 1;
    reg [lru_size-1:0] lru_tree [0:`hmem_sets-1];

    wire lru_update = hmem_fsm == 3'd0 && hmem_fsm_next != 3'd0;
    wire re_update  = hmem_fsm != 3'd0 && hmem_fsm_next == 3'd0;

    // find replacement entry and update LRU tree
    always @(posedge clk) begin
        if(!rst_n) begin : hmem_clr_lru
            integer i;
            for(i = 0; i < `hmem_sets; i = i + 1) lru_tree[i] <= 'b1;
        end
        else begin
            // update LRU tree
            if(lru_update) begin : hmem_lru_update
                integer i, l, i_parent;
                if(b_rd_i) begin
                    i = (hit_qi ? way_qi : re[addr_set_i]) + lru_size;
                    for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                        i_parent = (i[0] ? i-1 : i-2) >> 1;
                        lru_tree[addr_set_i][i_parent] = !i[0];
                        i = i_parent;
                    end
                end
                else begin
                    i = (hit_qd ? way_qd : re[addr_set_d]) + lru_size;
                    for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                        i_parent = (i[0] ? i-1 : i-2) >> 1;
                        lru_tree[addr_set_d][i_parent] = !i[0];
                        i = i_parent;
                    end
                end
            end
        end
    end

    always @(posedge clk) begin
        if(!rst_n) begin : hmem_clr_re
            integer i;
            for(i = 0; i < `hmem_sets; i = i + 1) re[i] = 'b0;
        end
        else if(re_update) begin : hmem_re_update
            integer i, l;
            if(b_rd_i) begin
                i = 0;
                for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                    i = lru_tree[addr_set_i][i] ? (i<<1) + 1 : (i<<1) + 2;
                end
                re[addr_set_i] = i - `hmem_ways + 1;
            end
            else begin
                i = 0;
                for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                    i = lru_tree[wr_pend ? w_set : addr_set_d][i] ? (i<<1) + 1 : (i<<1) + 2;
                end
                re[addr_set_d] = i - `hmem_ways + 1;
            end
        end
    end

endmodule
