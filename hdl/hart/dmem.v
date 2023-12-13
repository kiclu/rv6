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

module dmem(
    input                [63:0] addr,
    input                [ 2:0] len,

    output               [63:0] data_out,
    input                       rd,

    input                [63:0] data_in,
    input                       wr,

    output reg           [63:0] b_addr_d,

    input      [`dmem_line-1:0] b_data_in_d,
    output                      b_rd_d,
    input                       b_dv_d,

    output reg [`dmem_line-1:0] b_data_out_d,
    output reg                  b_wr_d,

    // control signals
    input                [63:0] inv_addr,
    input                       inv,

    input                       rst_n,

    input                       clk
);

    wire [ `dmem_tag_len-1:0] addr_tag  = addr[63:64-`dmem_tag_len];
    wire [ `dmem_set_len-1:0] addr_set  = addr[`dmem_set_len+`dmem_offs_len-1:`dmem_offs_len];
    wire [`dmem_offs_len-1:0] addr_offs = addr[`dmem_offs_len-1:0];

    reg  [    `dmem_line-1:0] data [0:`dmem_sets-1][0:`dmem_ways-1];
    reg  [ `dmem_tag_len-1:0] tag  [0:`dmem_sets-1][0:`dmem_ways-1];
    reg                       v    [0:`dmem_sets-1][0:`dmem_ways-1];

    /* MUX SELECTION */

    reg [`dmem_way_len-1:0] way;
    wire [63:0] data_mux [0:6];
    assign data_mux[0] = $signed(data[addr_set][way][8*addr_offs +:  8]);     // signed byte
    assign data_mux[1] = $signed(data[addr_set][way][8*addr_offs +: 16]);     // signed half word
    assign data_mux[2] = $signed(data[addr_set][way][8*addr_offs +: 32]);     // signed word
    assign data_mux[3] = data[addr_set][way][8*addr_offs +: 64];              // double word
    assign data_mux[4] = $unsigned(data[addr_set][way][8*addr_offs +:  8]);   // unsigned byte
    assign data_mux[5] = $unsigned(data[addr_set][way][8*addr_offs +: 16]);   // unsigned half word
    assign data_mux[6] = $unsigned(data[addr_set][way][8*addr_offs +: 32]);   // unsigned word
    assign data_out = data_mux[len];

    /* HIT DETECTION */

    reg hit;
    always @(*) begin : dmem_cache_hit_check
        integer i;
        hit <= 0;
        way <= 0;
        for(i = 0; i < `dmem_ways; i = i + 1) begin
            if(tag[addr_set][i] == addr_tag && v[addr_set][i]) begin
                way <= i;
                hit <= 1;
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
    wire re_update  =  dmem_op_d && !dmem_op;

    reg lru_update_d;
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
                else if(rd) begin
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

    /* CACHE DATA UPDATE */

    wire [`dmem_tag_len-1:0] inv_tag = inv_addr[63:64-`dmem_tag_len];
    wire [`dmem_set_len-1:0] inv_set = inv_addr[`dmem_set_len+`dmem_offs_len-1:`dmem_offs_len];

    always @(posedge clk) begin
        if(!rst_n) begin : dmem_clr_v
            integer s, w;
            for(s = 0; s < `dmem_sets; s = s + 1) begin
                for(w = 0; w < `dmem_ways; w = w + 1) begin
                    v[s][w] <= 0;
                end
            end
        end
        // cache hit, write data to cache and write-through
        else if(hit && wr) begin
            case(len)
                3'b000: data[addr_set][way][8*addr_offs +:  8] = data_in[ 7:0];
                3'b001: data[addr_set][way][8*addr_offs +: 16] = data_in[15:0];
                3'b010: data[addr_set][way][8*addr_offs +: 32] = data_in[31:0];
                3'b011: data[addr_set][way][8*addr_offs +: 64] = data_in[63:0];
            endcase
            b_data_out_d <= data[addr_set][way];
        end
        // cache miss, load data into cache line on valid data bus
        else if(!hit && b_dv_d) begin : dmem_cache_miss
            // load data into cache
            v[addr_set][re[addr_set]]    <= 1'b1;
            tag[addr_set][re[addr_set]]  <= addr_tag;
            data[addr_set][re[addr_set]]  = b_data_in_d;

            // write data
            if(wr) begin
                case(len)
                    3'b000: data[addr_set][re[addr_set]][8*addr_offs +:  8] = data_in[ 7:0];
                    3'b001: data[addr_set][re[addr_set]][8*addr_offs +: 16] = data_in[15:0];
                    3'b010: data[addr_set][re[addr_set]][8*addr_offs +: 32] = data_in[31:0];
                    3'b011: data[addr_set][re[addr_set]][8*addr_offs +: 64] = data_in[63:0];
                endcase
                // write-through
                b_data_out_d <= data[addr_set][re[addr_set]];
            end
        end
        // cache invalidation
        if(inv) begin : dmem_inv
            integer i;
            for(i = 0; i < `dmem_ways; i = i + 1) begin
                if(inv_tag == tag[inv_set][i]) v[inv_set][i] <= 0;
            end
        end
    end

    /* BUS CONTROL SIGNALS */

    always @(posedge clk) begin
        b_addr_d <= {addr[63:`dmem_offs_len], {`dmem_offs_len{1'b0}}};
    end

    reg b_wr_dd;
    always @(posedge clk) begin
        b_wr_dd <= hit && wr;
        b_wr_d <= !b_wr_dd && hit && wr;
    end

    // read from L2 cache if L1 cache miss
    assign b_rd_d = ~hit && (rd || wr);

endmodule
