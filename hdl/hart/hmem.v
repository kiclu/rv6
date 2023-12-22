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
 * Configurable, write-allocated L2 hart cache with write-through policy
 */

`include "../config.v"

`define hmem_read_valid_delay 4'd10

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
    output               [63:0] h_addr,

    input      [`hmem_line-1:0] h_data_in,
    output                      h_rd,
    input                       h_dv,

    output     [`hmem_line-1:0] h_data_out,
    output                      h_wr,

    // control signals
    input                [63:0] inv_addr,
    input                       inv,

    output                      stall,
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

    reg [`hmem_line-1:0] cache_line_in;
    reg [`hmem_line-1:0] cache_line_out_i;
    reg [`hmem_line-1:0] cache_line_out_d;

    /* HIT DETECTION */

    reg [`hmem_way_len-1:0] way_qi;
    reg                     hit_i;
    always @(*) begin : hmem_cache_hit_check_i
        integer i;
        hit_i = 0; way_qi = 0;
        for(i = 0; i < `hmem_ways; i = i + 1) begin
            if(tag[addr_set_i][i] == addr_tag_i && v[addr_set_i][i]) begin
                way_qi = i; hit_i = 1;
            end
        end
    end

    reg [`hmem_way_len-1:0] way_qd;
    reg                     hit_d;
    always @(*) begin : hmem_cache_hit_check_d
        integer i;
        hit_d = 0; way_qd = 0;
        for(i = 0; i < `hmem_ways; i = i + 1) begin
            if(tag[addr_set_d][i] == addr_tag_d && v[addr_set_d][i]) begin
                way_qd = i; hit_d = 1;
            end
        end
    end

    /* REPLACEMENT POLICY */

    // LRU tree
    localparam lru_size = `hmem_ways - 1;
    reg [lru_size-1:0] lru_tree [0:`hmem_sets-1];

    // replacement entry
    reg [`hmem_way_len-1:0] re [0:`hmem_sets-1];

    // hmem operation rising edge
    wire hmem_op = b_rd_i || b_rd_d || b_wr_d;
    reg  hmem_op_d;

    wire lru_update = !hmem_op_d &&  hmem_op;
    reg  lru_update_d;

    wire re_update  =  hmem_op_d && !hmem_op;

    always @(posedge clk) begin
        if(!rst_n) begin
            hmem_op_d <= 0;
            lru_update_d <= 0;
        end
        else begin
            hmem_op_d <= hmem_op;
            lru_update_d <= lru_update;
        end
    end

    // find replacement entry and update LRU tree
    always @(posedge clk) begin
        if(!rst_n) begin : hmem_clr_lru
            integer i;
            for(i = 0; i < `hmem_sets; i = i + 1) begin
                lru_tree[i] <= {lru_size{1'b1}};
                re[i] <= {`hmem_way_len{1'b0}};
            end
        end
        else begin
            // update LRU tree
            if(lru_update_d) begin : hmem_lru_update
                integer i, l, i_parent;
                // write update
                if(b_wr_d) begin
                    i = 0;
                    for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                        if(lru_tree[addr_set_d][i]) begin
                            lru_tree[addr_set_d][i] = 1'b0;
                            i = (i<<1) + 1;
                        end
                        else begin
                            lru_tree[addr_set_d][i] = 1'b1;
                            i = (i<<1) + 2;
                        end
                    end
                end
                // read update
                else if(b_rd_i || b_rd_d) begin
                    if(b_rd_i) begin
                        i = (hit_i ? way_qi : re[addr_set_i]) + lru_size;
                        for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                            i_parent = (i[0] ? i-1 : i-2) >> 1;
                            lru_tree[addr_set_i][i_parent] = !i[0];
                            i = i_parent;
                        end
                    end
                    else begin
                        i = (hit_d ? way_qd : re[addr_set_d]) + lru_size;
                        for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                            i_parent = (i[0] ? i-1 : i-2) >> 1;
                            lru_tree[addr_set_d][i_parent] = !i[0];
                            i = i_parent;
                        end
                    end
                end
            end
            // update replacement entry
            if(re_update) begin : hmem_re_update
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
                        i = lru_tree[addr_set_d][i] ? (i<<1) + 1 : (i<<1) + 2;
                    end
                    re[addr_set_d] = i - `hmem_ways + 1;
                end
            end
        end
    end

    /* WRITE ADDRESS BUFFERING */

    reg wr_pend;
    reg [ `hmem_tag_len-1:0] tag_bd;
    reg [ `hmem_set_len-1:0] set_bd;
    reg [ `hmem_way_len-1:0] way_bd;
    reg [`hmem_offs_len-1:0] offs_bd;
    reg [    `dmem_line-1:0] data_bd;

    always @(posedge clk) begin
        if(b_wr_d) begin
            tag_bd  <= addr_tag_d;
            set_bd  <= addr_set_d;
            way_bd  <= hit_d ? way_qd : re[addr_set_d];
            offs_bd <= addr_offs_d;
            data_bd <= b_data_out_d;
        end
    end

    /* CACHE DATA WRITE */

    wire op_i = b_rd_i;
    wire op_d = b_rd_d || b_wr_d;

    wire rd   = b_rd_i || b_rd_d;
    wire wr   = b_wr_d;

    wire [`hmem_set_len-1:0] set_f = op_d ? addr_set_d : addr_set_i;
    wire [`hmem_way_len-1:0] way_f = op_d ? way_qd : way_qi;

    reg  [   `hmem_line-1:0] buf_in;
    reg                      s_mux_in;

    reg  [`hmem_set_len-1:0] set_dd;
    reg  [`hmem_way_len-1:0] way_dd;
    reg                      wre;
    always @(posedge clk) if(wre) data[`hmem_sets * set_dd + way_dd] <= cache_line_in;

    always @(*) begin
        cache_line_in = s_mux_in ? buf_in : cache_line_out_d;
        if(wr_pend) cache_line_in[8*offs_bd +: `dmem_line] = data_bd;
    end

    /* CACHE DATA READ */

    reg rde_i;
    always @(posedge clk) if(rde_i) cache_line_out_i <= data[`hmem_sets*addr_set_i + way_qi];

    reg rde_d;
    always @(posedge clk) if(rde_d) cache_line_out_d <= data[`hmem_sets*wr_pend ? set_bd : addr_set_d + wr_pend ? way_bd : way_qd];

    /* FSM */

    reg [2:0] hmem_fsm;
    reg [2:0] hmem_fsm_next;

    reg [3:0] ld_cnt;

    reg fetch_d;

    reg h_dv_d;
    reg h_dv_dd;
    always @(posedge clk) begin
        h_dv_d  <= h_dv;
        h_dv_dd <= h_dv_d;
    end

    always @(*) begin
        way_dd = 0;

        rde_i = 0;
        rde_d = 0;
        wre   = 0;

        hmem_fsm_next = hmem_fsm;
        case(hmem_fsm)
            // IDLE
            3'd0: begin
                if( hit_i && op_i) hmem_fsm_next = 3'd1;
                if(!hit_i && op_i) hmem_fsm_next = 3'd3;
                if( hit_d && op_d) hmem_fsm_next = 3'd2;
                if(!hit_d && op_d) hmem_fsm_next = 3'd3;
            end
            // LOAD_I
            3'd1: begin
                rde_i = 1;

                if(ld_cnt == 4'd0) hmem_fsm_next = 3'd0;
            end
            // LOAD_D
            3'd2: begin
                rde_d = 1;

                if(wr_pend && ld_cnt == 4'd0) hmem_fsm_next = 3'd4;
                else if(b_rd_d && ld_cnt == 4'd0) hmem_fsm_next = 3'd0;
            end
            // FETCH
            3'd3: begin
                if(op_i) begin
                    set_dd = addr_set_i;
                    way_dd = re[addr_set_i];
                end
                if(op_d) begin
                    set_dd = wr_pend ? set_bd : addr_set_d;
                    way_dd = wr_pend ? way_bd : re[addr_set_d];
                end
                wre = rd && h_dv_dd;

                if(wr_pend && h_dv_dd) hmem_fsm_next = 3'd4;
                else begin
                    if(b_rd_i  && h_dv_dd) hmem_fsm_next = 3'd0;
                    if(b_rd_d  && h_dv_dd) hmem_fsm_next = 3'd0;
                end
            end
            // WRITE
            3'd4: begin
                set_dd = set_bd;
                way_dd = way_bd;
                wre = 1;

                hmem_fsm_next = 3'd0;
            end
        endcase
    end

    always @(posedge clk) begin
        if(!rst_n) begin
            s_mux_in <= 0;
            hmem_fsm <= 3'd0;
        end
        else begin
            case(hmem_fsm)
                // IDLE
                2'd0: begin
                    ld_cnt  <= `hmem_read_valid_delay;
                    fetch_d <= op_d;

                    hmem_fsm <= hmem_fsm_next;
                end
                // LOAD_I
                3'd1: begin
                    if(ld_cnt) ld_cnt <= ld_cnt - 1;

                    hmem_fsm <= hmem_fsm_next;
                end
                // LOAD_D
                3'd2: begin
                    if(ld_cnt) ld_cnt <= ld_cnt - 1;
                    s_mux_in <= 0;

                    hmem_fsm <= hmem_fsm_next;
                end
                // FETCH
                3'd3: begin
                    if(h_dv) buf_in <= h_data_in;
                    s_mux_in <= 1;

                    hmem_fsm <= hmem_fsm_next;
                end
                // WRITE
                3'd4: begin
                    hmem_fsm <= hmem_fsm_next;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if(!rst_n) wr_pend <= 0;
        else begin
            if(b_wr_d) wr_pend <= 1;
            else if(hmem_fsm == 3'd4) wr_pend <= 0;
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
        else begin
            // data cache miss, load into cache line on valid external data bus
            if(!hit_d && h_dv && (b_rd_d || b_wr_d || wr_pend)) begin : hmem_cache_miss_d
                // load data into cache
                v  [wr_pend ? set_bd : addr_set_d][re[wr_pend ? set_bd : addr_set_d]] <= 1'b1;
                tag[wr_pend ? set_bd : addr_set_d][re[wr_pend ? set_bd : addr_set_d]] <= wr_pend ? tag_bd : addr_tag_d;
            end
            // instruction cache miss, load into cache on valid external data bus
            else if(!hit_i && h_dv && b_rd_i) begin : hmem_cache_miss_i
                // load data into cache
                v  [addr_set_i][re[addr_set_i]] <= 1'b1;
                tag[addr_set_i][re[addr_set_i]] <= addr_tag_i;
            end
        end
    end

    /* BUS CONTROL SIGNALS */

    assign b_data_i    = hmem_fsm == 3'd3 ? buf_in[8*addr_offs_i +: `imem_line] : cache_line_out_i[8*addr_offs_i +: `imem_line];
    assign b_dv_i      = ((hmem_fsm == 3'd3 && h_dv_dd && !fetch_d) || (hmem_fsm == 3'd1 && ld_cnt == 4'd0 && !fetch_d)) && b_rd_i;

    assign b_data_in_d = hmem_fsm == 3'd3 ? buf_in[8*addr_offs_d +: `dmem_line] : cache_line_out_d[8*addr_offs_d +: `dmem_line];
    assign b_dv_d      = ((hmem_fsm == 3'd3 && h_dv_dd &&  fetch_d) || (hmem_fsm == 3'd2 && ld_cnt == 4'd0 &&  fetch_d)) && b_rd_d;

    assign h_addr = {fetch_d ? b_addr_d[63:`hmem_offs_len] : b_addr_i[63:`hmem_offs_len], {`hmem_offs_len{1'b0}}};

    assign h_data_out = cache_line_in;

    assign h_rd = hmem_fsm == 3'd3 && !h_dv_dd;
    assign h_wr = hmem_fsm == 3'd4;

    assign stall = (!wr_pend && hmem_fsm != 3'd0) || (wr_pend && (op_d || op_i));

endmodule
