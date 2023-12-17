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
 * Configurable L1 instruction cache
 */

`include "../config.v"

module imem(
    input            [63:0] pc,
    output           [31:0] ir,

    input  [`imem_line-1:0] b_data,
    output                  b_rd,
    input                   b_dv,

    // control signals
    input                   stall,

    input                   rst_n,

    input                   clk
);

    wire [ `imem_tag_len-1:0] addr_tag  = pc[63:64-`imem_tag_len];
    wire [ `imem_set_len-1:0] addr_set  = pc[`imem_set_len+`imem_offs_len-1:`imem_offs_len];
    wire [`imem_offs_len-1:0] addr_offs = pc[`imem_offs_len-1:0];

    reg  [    `imem_line-1:0] data [0:`imem_sets-1][0:`imem_ways-1];
    reg  [ `imem_tag_len-1:0] tag  [0:`imem_sets-1][0:`imem_ways-1];
    reg                       v    [0:`imem_sets-1][0:`imem_ways-1];

    reg [`imem_way_len-1:0] way;
    assign ir = data[addr_set][way][8*addr_offs +: 32];

    /* HIT DETECTION */

    reg hit;
    always @(*) begin : imem_cache_hit_check
        integer i;
        hit <= 0;
        way <= 0;
        for(i = 0; i < `imem_ways; i = i + 1) begin
            if((tag[addr_set][i] == addr_tag) && v[addr_set][i]) begin
                way <= i;
                hit <= 1;
            end
        end
    end

    /* REPLACEMENT POLICY */

    // LRU tree
    localparam lru_size = `imem_ways - 1;
    reg [lru_size-1:0] lru_tree [0:`imem_sets-1];

    // replacement entry
    reg [`imem_way_len-1:0] re [0:`imem_sets-1];

    // find replacement entry and update LRU tree
    always @(posedge clk) begin
        if(!rst_n) begin : imem_clr_lru
            integer i;
            for(i = 0; i < `imem_sets; i = i + 1) begin
                lru_tree[i] <= {lru_size{1'b1}};
                re[i] <= {`imem_way_len{1'b0}};
            end
        end
        else if(!stall) begin : imem_lru_update
            integer i, l, i_parent;

            // update LRU tree
            i = (hit ? way : re[addr_set]) + lru_size;
            for(l = 0; l < $clog2(`imem_ways); l = l + 1) begin
                i_parent = (i[0] ? i-1 : i-2) >> 1;
                lru_tree[addr_set][i_parent] = !i[0];
                i = i_parent;
            end

            // update replacement entry
            for(l = 0; l < $clog2(`imem_ways); l = l + 1) begin
                i = lru_tree[addr_set][i] ? 2*i+1 : 2*i+2;
            end
            re[addr_set] = i - `imem_ways + 1;
        end
    end

    /* CACHE DATA UPDATE */

    always @(posedge clk) begin
        if(!rst_n) begin : imem_clr_v
            integer s, e;
            for(s = 0; s < `imem_sets; s = s + 1) begin
                for(e = 0; e < `imem_ways; e = e + 1) begin
                    v[s][e] = 0;
                end
            end
        end
        // cache miss, load data into cache line on valid data bus
        else if(!hit && b_dv) begin : imem_cache_miss
            // load data into cache
            v[addr_set][re[addr_set]]    <= 1'b1;
            tag[addr_set][re[addr_set]]  <= addr_tag;
            data[addr_set][re[addr_set]] <= b_data;
        end
    end

    /* BUS CONTROL SIGNALS */

    assign b_rd = ~hit;

endmodule
