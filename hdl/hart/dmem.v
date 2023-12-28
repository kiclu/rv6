/*
 * Copyright (C) 2023  Nikola Lukic <lukicn@protonmail.com>
 * This source describes Open Hardware and is licensed under the CERN-OHL-W v2
 *
 * You may redistribute and modify this documentation and make products
 * using it under the terms of the CERN-OHL-W v2 (https:/cern.ch/cern-ohl).
 * This documentation is distributed WITHOUT ANY EXPRESS OR IMPLIED
 * WARRANTY, INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY
 * AND FITNESS FOR A PARTICULAR PURPOSE. Please see the CERN-OHL-W v2
 * for applicable conditions.
 *
 * Source location: https://www.github.com/kiclu/rv6
 *
 * As per CERN-OHL-W v2 section 4.1, should You produce hardware based on
 * these sources, You must maintain the Source Location visible on the
 * external case of any product you make using this documentation.
 */

/*
 * Configurable, write-allocated L1 data cache with write-through policy
 */

`include "../config.v"

`define dmem_read_valid_delay 3'd2

module dmem(
    input                [63:0] addr,
    input                [ 2:0] len,

    output               [63:0] data_out,
    input                       rd,

    input                [63:0] data_in,
    input                       wr,

    // misaligned access
    output                      ld_ma,
    output                      st_ma,

    // external bus signals
    output reg           [63:0] b_addr_d,

    input      [`dmem_line-1:0] b_data_in_d,
    output reg                  b_rd_d,
    input                       b_dv_d,

    output reg [`dmem_line-1:0] b_data_out_d,
    output reg                  b_wr_d,

    // cache invalidaton
    input                [63:0] inv_addr,
    input                       inv,

    // control signals
    output                      stall_dmem,
    input                       rst_n,
    input                       clk
);

    wire dmem_op = rd || wr;

    wire [ `dmem_tag_len-1:0] addr_tag  = addr[63:64-`dmem_tag_len];
    wire [ `dmem_set_len-1:0] addr_set  = addr[`dmem_set_len+`dmem_offs_len-1:`dmem_offs_len];
    wire [`dmem_offs_len-1:0] addr_offs = addr[`dmem_offs_len-1:0];

    localparam dmem_size = `dmem_sets * `dmem_ways;

    (* ram_style = "block" *)
    reg  [    `dmem_line-1:0] data [0: dmem_size-1];
    reg  [ `dmem_tag_len-1:0] tag  [0:`dmem_sets-1][0:`dmem_ways-1];
    reg                       v    [0:`dmem_sets-1][0:`dmem_ways-1];

    // replacement entry
    reg [`dmem_way_len-1:0] re [0:`dmem_sets-1];

    reg hit_q;

    reg [`dmem_line-1:0] cache_line_out;
    reg [`dmem_line-1:0] cache_line_in;

    /* READ BUFFER */

    reg [`dmem_tag_len-1:0] r_tag;
    reg [`dmem_set_len-1:0] r_set;
    reg [   `dmem_line-1:0] r_data;

    wire r_hit_q = r_tag == addr_tag && r_set == addr_set;

    /* CACHE DATA READ */

    reg [`dmem_set_len-1:0] set_q;
    reg [`dmem_way_len-1:0] way_q;

    reg rde;
    always @(posedge clk) if(rde) cache_line_out <= data[`dmem_ways*set_q + way_q];

    /* WRITE BUFFER */

    reg                [1:0] w_len;
    reg [ `dmem_tag_len-1:0] w_tag;
    reg [ `dmem_set_len-1:0] w_set;
    reg [ `dmem_way_len-1:0] w_way;
    reg [`dmem_offs_len-1:0] w_offs;
    reg               [63:0] w_data;

    reg wr_pend;

    always @(posedge clk) begin
        if(wr) begin
            w_len  <= len[1:0];
            w_tag  <= addr_tag;
            w_set  <= addr_set;
            w_way  <= hit_q ? way_q : re[addr_set];
            w_offs <= addr_offs;
            w_data <= data_in;
        end
    end

    /* CACHE DATA WRITE */

    reg [`dmem_set_len-1:0] set_d;
    reg [`dmem_way_len-1:0] way_d;

    reg wre;
    always @(posedge clk) if(wre) data[`dmem_ways*set_d + way_d] <= cache_line_in;

    reg [`dmem_line-1:0] cache_line_in_w;
    always @(*) begin
        cache_line_in_w = r_data;
        case(w_len[1:0])
            2'b00: cache_line_in_w[8*w_offs +:  8] = w_data[ 7:0];
            2'b01: cache_line_in_w[8*w_offs +: 16] = w_data[15:0];
            2'b10: cache_line_in_w[8*w_offs +: 32] = w_data[31:0];
            2'b11: cache_line_in_w[8*w_offs +: 64] = w_data[63:0];
        endcase
    end

    /* FSM */

    reg [1:0] dmem_fsm;
    reg [1:0] dmem_fsm_next;

    reg [2:0] ld_cnt;

    always @(*) begin
        cache_line_in = {`dmem_line{1'bZ}};
        rde = 0;
        wre = 0;
        set_d = w_set;
        way_d = re[w_set];
        set_q = addr_set;

        b_data_out_d = {`dmem_line{1'bZ}};
        b_rd_d = 0;
        b_wr_d = 0;

        dmem_fsm_next = dmem_fsm;
        case(dmem_fsm)
            // READY
            2'd0: begin
                if(dmem_op && !hit_q) dmem_fsm_next = 2'd1;
                if(dmem_op &&  hit_q) dmem_fsm_next = 2'd2;
                if(wr && r_hit_q) dmem_fsm_next = 2'd3;
                if(rd && r_hit_q) dmem_fsm_next = 2'd0;
            end
            // FETCH
            2'd1: begin
                b_rd_d = 1;

                cache_line_in = b_data_in_d;
                set_d = wr_pend ? w_set : addr_set;
                way_d = re[set_d];
                wre   = b_dv_d && !wr_pend;

                if(b_dv_d && rd)      dmem_fsm_next = 2'd0;
                if(b_dv_d && wr_pend) dmem_fsm_next = 2'd3;
            end
            // LOAD
            2'd2: begin
                rde = ld_cnt == `dmem_read_valid_delay;

                if(ld_cnt == 2'd0 && rd)      dmem_fsm_next = 2'd0;
                if(ld_cnt == 2'd0 && wr_pend) dmem_fsm_next = 2'd3;
            end
            // WRITE
            2'd3: begin
                cache_line_in = cache_line_in_w;
                wre = 1;
                set_d = w_set;
                way_d = w_way;

                b_data_out_d = cache_line_in_w;
                b_wr_d = 1;

                dmem_fsm_next = 2'd0;
            end
        endcase
    end

    always @(posedge clk) begin
        if(!rst_n) begin
            wr_pend  <= 0;
            ld_cnt   <= `dmem_read_valid_delay;
            dmem_fsm <= 2'd0;
            r_tag <= 0;
            r_set <= 0;
        end
        else begin
            case(dmem_fsm)
                // READY
                2'd0: begin
                    if(dmem_op) b_addr_d <= {addr[63:`dmem_offs_len], {`dmem_offs_len{1'b0}}};
                    wr_pend <= wr;

                    dmem_fsm <= dmem_fsm_next;
                end
                // FETCH
                2'd1: begin
                    if(b_dv_d) begin
                        r_tag  <= wr_pend ? w_tag : addr_tag;
                        r_set  <= wr_pend ? w_set : addr_set;
                        r_data <= b_data_in_d;
                    end

                    dmem_fsm <= dmem_fsm_next;
                end
                // LOAD
                2'd2: begin
                    if(ld_cnt == 2'd0) begin
                        r_tag  <= wr_pend ? w_tag : addr_tag;
                        r_set  <= wr_pend ? w_set : addr_set;
                        r_data <= cache_line_out;
                        ld_cnt <= `dmem_read_valid_delay;
                    end

                    if(ld_cnt) ld_cnt <= ld_cnt - 1;

                    dmem_fsm <= dmem_fsm_next;
                end
                // WRITE
                2'd3: begin
                    r_data  <= cache_line_in;
                    wr_pend <= 0;

                    dmem_fsm <= dmem_fsm_next;
                end
            endcase
        end
    end

    assign stall_dmem = (rd && !r_hit_q) || (wr_pend && dmem_op);

    /* OUTPUT MUX */

    wire [63:0] data_mux [0:6];
    assign data_mux[0] =   $signed(r_data[8*addr_offs +:  8]);  // signed byte
    assign data_mux[1] =   $signed(r_data[8*addr_offs +: 16]);  // signed half word
    assign data_mux[2] =   $signed(r_data[8*addr_offs +: 32]);  // signed word
    assign data_mux[3] =           r_data[8*addr_offs +: 64];   // double word
    assign data_mux[4] = $unsigned(r_data[8*addr_offs +:  8]);  // unsigned byte
    assign data_mux[5] = $unsigned(r_data[8*addr_offs +: 16]);  // unsigned half word
    assign data_mux[6] = $unsigned(r_data[8*addr_offs +: 32]);  // unsigned word
    assign data_out = data_mux[len];

    /* CACHE METADATA UPDATE */

    wire [`dmem_tag_len-1:0] inv_tag = inv_addr[63:64-`dmem_tag_len];
    wire [`dmem_set_len-1:0] inv_set = inv_addr[`dmem_set_len+`dmem_offs_len-1:`dmem_offs_len];

    always @(posedge clk) begin
        if(!rst_n) begin : dmem_rst
            integer s, w;
            for(s = 0; s < `dmem_sets; s = s + 1) begin
                for(w = 0; w < `dmem_ways; w = w + 1) begin
                    v[s][w] <= 0;
                end
            end
        end
        else begin
            if(wre) begin
                v  [set_d][way_d] <= 1'b1;
                tag[set_d][way_d] <= w_tag;
            end

            // cache invalidation
            if(inv) begin : dmem_inv
                integer i;
                for(i = 0; i < `dmem_ways; i = i + 1) begin
                    if(inv_tag == tag[inv_set][i]) v[inv_set][i] <= 0;
                end
            end
        end
    end

    /* HIT DETECTION */

    always @(*) begin : dmem_cache_hit_q_check
        integer i;
        hit_q = 0; way_q = 0;
        for(i = 0; i < `dmem_ways; i = i + 1) begin
            if(tag[addr_set][i] == addr_tag && v[addr_set][i]) begin
                hit_q = 1; way_q = i;
            end
        end
    end

    /* MISALIGNED ACCESS DETECTION */

    reg [63:0] addr_2;
    always @(*) begin
        case(len[1:0])
            2'b00: addr_2 = addr + 64'd0;
            2'b01: addr_2 = addr + 64'd1;
            2'b10: addr_2 = addr + 64'd3;
            2'b11: addr_2 = addr + 64'd7;
        endcase
    end
    assign ld_ma = rd && (addr_2[63:`dmem_offs_len] != addr[63:`dmem_offs_len]);
    assign st_ma = wr && (addr_2[63:`dmem_offs_len] != addr[63:`dmem_offs_len]);

    /* REPLACEMENT POLICY */

    // LRU tree
    localparam lru_size = `dmem_ways - 1;
    reg [lru_size-1:0] lru_tree [0:`dmem_sets-1];

    wire lru_update = dmem_fsm == 2'd0 && dmem_fsm_next != 2'd0;
    wire re_update  = dmem_fsm != 2'd0 && dmem_fsm_next == 2'd0;

    // update LRU tree
    always @(posedge clk) begin
        if(!rst_n) begin : dmem_clr_lru
            integer i;
            for(i = 0; i < `dmem_sets; i = i + 1) lru_tree[i] = {lru_size{1'b1}};
        end
        else if(lru_update) begin : dmem_lru_update
            integer i, l, i_parent;
            i = (hit_q ? way_q : re[addr_set]) + lru_size;
            for(l = 0; l < $clog2(`dmem_ways); l = l + 1) begin
                i_parent = (i[0] ? i-1 : i-2) >> 1;
                lru_tree[addr_set][i_parent] = !i[0];
                i = i_parent;
            end
        end
    end

    // update replacement entry
    always @(posedge clk) begin
        if(!rst_n) begin : dmem_clr_re
            integer i;
            for(i = 0; i < `dmem_sets; i = i + 1) re[i] = 0;
        end
        else if(re_update) begin : dmem_re_update
            integer i, l;
            i = 0;
            for(l = 0; l < $clog2(`dmem_ways); l = l + 1) begin
                i = lru_tree[addr_set][i] ? (i<<1) + 1 : (i<<1) + 2;
            end
            re[addr_set] = i - `dmem_ways + 1;
        end
    end

endmodule
