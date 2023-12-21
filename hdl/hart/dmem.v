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

`define dmem_read_valid_delay 1

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
    output               [63:0] b_addr_d,

    input      [`dmem_line-1:0] b_data_in_d,
    output                      b_rd_d,
    input                       b_dv_d,

    output     [`dmem_line-1:0] b_data_out_d,
    output                      b_wr_d,

    // cache invalidaton
    input                [63:0] inv_addr,
    input                       inv,

    // control signals
    output                      stall,
    input                       rst_n,
    input                       clk
);

    wire [ `dmem_tag_len-1:0] addr_tag  = addr[63:64-`dmem_tag_len];
    wire [ `dmem_set_len-1:0] addr_set  = addr[`dmem_set_len+`dmem_offs_len-1:`dmem_offs_len];
    wire [`dmem_offs_len-1:0] addr_offs = addr[`dmem_offs_len-1:0];

    localparam dmem_size = `dmem_sets * `dmem_ways;

    (* ram_style = "block" *)
    reg  [    `dmem_line-1:0] data [0: dmem_size-1];
    reg  [ `dmem_tag_len-1:0] tag  [0:`dmem_sets-1][0:`dmem_ways-1];
    reg                       v    [0:`dmem_sets-1][0:`dmem_ways-1];

    /* OUTPUT MUX */

    reg [`dmem_line-1:0] cache_line_out;
    reg [`dmem_line-1:0] cache_line_in;

    reg [`dmem_way_len-1:0] way;
    wire [63:0] data_mux [0:6];
    assign data_mux[0] =   $signed(cache_line_out[8*addr_offs +:  8]);  // signed byte
    assign data_mux[1] =   $signed(cache_line_out[8*addr_offs +: 16]);  // signed half word
    assign data_mux[2] =   $signed(cache_line_out[8*addr_offs +: 32]);  // signed word
    assign data_mux[3] =           cache_line_out[8*addr_offs +: 64];   // double word
    assign data_mux[4] = $unsigned(cache_line_out[8*addr_offs +:  8]);  // unsigned byte
    assign data_mux[5] = $unsigned(cache_line_out[8*addr_offs +: 16]);  // unsigned half word
    assign data_mux[6] = $unsigned(cache_line_out[8*addr_offs +: 32]);  // unsigned word
    assign data_out = data_mux[len];

    /* HIT DETECTION */

    reg hit;
    always @(*) begin : dmem_cache_hit_check
        integer i;
        hit = 0; way = 0;
        for(i = 0; i < `dmem_ways; i = i + 1) begin
            if(tag[addr_set][i] == addr_tag && v[addr_set][i]) begin
                way = i; hit = 1;
            end
        end
    end

    /* REPLACEMENT POLICY */

    // LRU tree
    localparam lru_size = `dmem_ways - 1;
    reg [lru_size-1:0] lru_tree [0:`dmem_sets-1];

    // replacement entry
    reg [`dmem_way_len-1:0] re [0:`dmem_sets-1];

    // dmem operation rising edge
    wire dmem_op = rd || wr;
    reg  dmem_op_d;

    wire lru_update = !dmem_op_d &&  dmem_op;
    reg  lru_update_d;

    wire re_update  =  dmem_op_d && !dmem_op;

    always @(posedge clk) begin
        if(!rst_n) begin
            dmem_op_d <= 0;
            lru_update_d <= 0;
        end
        else begin
            dmem_op_d <= dmem_op;
            lru_update_d <= lru_update;
        end
    end

    // find replacement entry and update LRU tree
    always @(posedge clk) begin
        if(!rst_n) begin : dmem_clr_lru
            integer i, j, l;
            for(i = 0; i < `dmem_sets; i = i + 1) begin
                // initialize LRU tree
                lru_tree[i] <= {lru_size{1'b1}};
                // initialize replacement entry
                re[i] <= {`dmem_way_len{1'b0}};
            end
        end
        else begin
            // update LRU tree
            if(lru_update_d) begin : dmem_lru_update
                integer i, l, i_parent;
                // write update
                if(wr) begin
                    i = 0;
                    for(l = 0; l < $clog2(`dmem_ways); l = l + 1) begin
                        if(lru_tree[addr_set][i]) begin
                            lru_tree[addr_set][i] = 1'b0;
                            i = (i<<1) + 1;
                        end
                        else begin
                            lru_tree[addr_set][i] = 1'b1;
                            i = (i<<1) + 2;
                        end
                    end
                end
                // read update
                if(rd) begin
                    i = (hit ? way : re[addr_set]) + lru_size;
                    for(l = 0; l < $clog2(`dmem_ways); l = l + 1) begin
                        i_parent = (i[0] ? i-1 : i-2) >> 1;
                        lru_tree[addr_set][i_parent] = !i[0];
                        i = i_parent;
                    end
                end
            end
            // update replacement entry
            if(re_update) begin : dmem_re_update
                integer i, l;
                i = 0;
                for(l = 0; l < $clog2(`dmem_ways); l = l + 1) begin
                    i = lru_tree[addr_set][i] ? (i<<1) + 1 : (i<<1) + 2;
                end
                re[addr_set] = i - `dmem_ways + 1;
            end
        end
    end

    /* CACHE DATA WRITE */
    reg [   `dmem_line-1:0] buf_in;
    reg                     buf_d;

    reg [`dmem_way_len-1:0] way_d;
    reg wre;
    always @(posedge clk) if(wre) data[`dmem_sets * addr_set + way_d] <= cache_line_in;

    always @(*) begin
        cache_line_in = buf_d ? buf_in : cache_line_out;
        if(wre) begin
            case(len)
                3'b000: cache_line_in[8*addr_offs +:  8] = data_in[ 7:0];
                3'b001: cache_line_in[8*addr_offs +: 16] = data_in[15:0];
                3'b010: cache_line_in[8*addr_offs +: 32] = data_in[31:0];
                3'b011: cache_line_in[8*addr_offs +: 64] = data_in[63:0];
            endcase
        end
    end

    /* CACHE DATA READ */

    reg [`dmem_way_len-1:0] way_q;
    reg rde;
    always @(posedge clk) if(rde) cache_line_out <= data[`dmem_sets * addr_set + way_q];

    /* FSM */

    reg [1:0] dmem_fsm;
    reg [1:0] dmem_fsm_next;

    reg [1:0] ld_cnt;

    always @(*) begin
        rde = 0;
        wre = 0;
        way_d = 0;
        way_q = 0;
        dmem_fsm_next = dmem_fsm;
        case(dmem_fsm)
            // IDLE
            2'd0: begin
                if(dmem_op && !hit) dmem_fsm_next = 1;
                if(dmem_op &&  hit) dmem_fsm_next = 2;
            end
            // FETCH
            2'd1: begin
                way_d = re[addr_set];
                wre = rd && b_dv_d;

                if(rd && b_dv_d) dmem_fsm_next = 0;
                if(wr && b_dv_d) dmem_fsm_next = 3;
            end
            // LOAD
            2'd2: begin
                way_q = way;
                rde = 1;

                if(rd && ld_cnt == 2'd0) dmem_fsm_next = 0;
                if(wr && ld_cnt == 2'd0) dmem_fsm_next = 3;
            end
            // WRITE
            2'd3: begin
                wre = 1;
                way_d = buf_d ? re[addr_set] : way;

                dmem_fsm_next = 0;
            end
        endcase
    end

    always @(posedge clk) begin
        if(!rst_n) begin
            buf_d <= 0;
            dmem_fsm <= 2'd0;
        end
        else begin
            case(dmem_fsm)
                // IDLE
                2'd0: begin
                    ld_cnt <= `dmem_read_valid_delay;
                    dmem_fsm <= dmem_fsm_next;
                end
                // FETCH
                2'd1: begin
                    if(b_dv_d) buf_in <= b_data_in_d;
                    buf_d <= 1;
                    dmem_fsm <= dmem_fsm_next;
                end
                // LOAD
                2'd2: begin
                    if(ld_cnt) ld_cnt <= ld_cnt - 1;
                    buf_d <= 0;
                    dmem_fsm <= dmem_fsm_next;
                end
                // WRITE
                2'd3: begin

                    dmem_fsm <= dmem_fsm_next;
                end
            endcase
        end
    end

    /* CACHE DATA UPDATE */

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
            // cache miss, load data into cache line on valid data bus
            if(!hit && b_dv_d) begin
                v  [addr_set][re[addr_set]] <= 1'b1;
                tag[addr_set][re[addr_set]] <= addr_tag;
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

    /* MISALIGNED ACCESS DETECTION */

    reg [63:0] aaddr_end;
    always @(*) begin
        case(len[1:0])
            2'b00: aaddr_end <= addr + 64'd0;
            2'b01: aaddr_end <= addr + 64'd1;
            2'b10: aaddr_end <= addr + 64'd3;
            2'b11: aaddr_end <= addr + 64'd7;
        endcase
    end
    assign ld_ma = rd && (aaddr_end[63:`dmem_offs_len] != addr[63:`dmem_offs_len]);
    assign st_ma = wr && (aaddr_end[63:`dmem_offs_len] != addr[63:`dmem_offs_len]);

    /* BUS CONTROL SIGNALS */

    assign b_addr_d = {addr[63:`dmem_offs_len], {`dmem_offs_len{1'b0}}};

    assign b_rd_d = dmem_fsm == 2'd1;

    assign b_data_out_d = cache_line_in;
    assign b_wr_d = dmem_fsm == 2'd3;

    assign stall = dmem_fsm_next != 2'd0;

endmodule
