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

module hmem(
    // internal instruction bus
    input                [63:0] b_addr_i,
    output     [`imem_line-1:0] b_data_i,
    input                       b_rd_i,
    output                      b_dv_i,

    // internal data bus common
    input                [63:0] b_addr_d,

    // internal data bus output
    output     [`dmem_line-1:0] b_data_in_d,
    input                       b_rd_d,
    output                      b_dv_d,
    
    // internal data bus input
    input      [`dmem_line-1:0] b_data_out_d,
    input                       b_wr_d,

    // external bus
    output reg           [63:0] h_addr,
    
    input      [`hmem_line-1:0] h_data_in,
    output                      h_rd,
    input                       h_dv,

    output reg [`hmem_line-1:0] h_data_out,
    output reg                  h_wr,

    // control signals
    input                [63:0] inv_addr,
    input                       inv,

    input                       rst_n,

    input                       clk
);

    wire [ `hmem_tag_len-1:0] addr_tag_i  = b_addr_i[63:64-`hmem_tag_len];
    wire [ `hmem_set_len-1:0] addr_set_i  = b_addr_i[`hmem_set_len+`hmem_offs_len-1:`hmem_offs_len];
    wire [`hmem_offs_len-1:0] addr_offs_i = b_addr_i[`hmem_offs_len-1:0];

    wire [ `hmem_tag_len-1:0] addr_tag_d  = b_addr_d[63:64-`hmem_tag_len];
    wire [ `hmem_set_len-1:0] addr_set_d  = b_addr_d[`hmem_set_len+`hmem_offs_len-1:`hmem_offs_len];
    wire [`hmem_offs_len-1:0] addr_offs_d = b_addr_d[`hmem_offs_len-1:0];

    reg  [    `hmem_line-1:0] data [0:`hmem_sets-1][0:`hmem_ways-1];
    reg  [ `hmem_tag_len-1:0] tag  [0:`hmem_sets-1][0:`hmem_ways-1];
    reg                       v    [0:`hmem_sets-1][0:`hmem_ways-1];

    /* HIT DETECTION */

    reg way_i;
    reg hit_i;
    always @(*) begin : hmem_cache_hit_check_i
        integer i;
        hit_i <= 0;
        way_i <= 0;
        for(i = 0; i < `hmem_ways; i = i + 1) begin
            if(tag[addr_set_i][i] == addr_tag_i && v[addr_set_i][i]) begin
                way_i <= i;
                hit_i <= 1;
            end
        end
    end

    assign b_data_i = data[addr_set_i][way_i][8*addr_offs_i +: `imem_line];
    assign b_dv_i = hit_i && b_rd_i;

    reg way_d;
    reg hit_d;
    always @(*) begin : hmem_cache_hit_check_d
        integer i;
        hit_d <= 0;
        way_d <= 0;
        for(i = 0; i < `hmem_ways; i = i + 1) begin
            if(tag[addr_set_d][i] == addr_tag_d && v[addr_set_d][i]) begin
                way_d <= i;
                hit_d <= 1;
            end
        end
    end

    assign b_data_in_d = data[addr_set_d][way_d][8*addr_offs_d +: `dmem_line];
    assign b_dv_d = hit_d && b_rd_d;

    /* REPLACEMENT POLICY */

    // LRU tree
    localparam lru_size = `hmem_ways - 1;
    reg [lru_size-1:0] lru_tree [0:`dmem_sets-1];

    // replacement entry
    reg re;

    // hmem operation rising edge
    wire hmem_op = b_rd_i || b_rd_d || b_wr_d;
    reg  hmem_op_d;
    wire lru_update = !hmem_op_d && hmem_op;
    always @(posedge clk) hmem_op_d <= hmem_op;

    // find replacement entry and update LRU tree
    always @(posedge clk) begin
        if(!rst_n) begin : hmem_clr_lru
            integer i;
            for(i = 0; i < `hmem_sets; i = i + 1) begin
                lru_tree[i] <= {lru_size{1'b0}};
            end
            re <= 0;
        end
        else if(lru_update) begin : hmem_lru_update
            integer i, l, i_parent;
            // write update
            if(b_wr_d) begin
                i = 0;
                for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                    if(lru_tree[addr_set_d][i]) begin
                        lru_tree[addr_set_d][i] = 1'b0;
                        i = i<<1 + 1;
                    end
                    else begin
                        lru_tree[addr_set_d][i] = 1'b1;
                        i = i<<1 + 2;
                    end
                end
                re = i - `hmem_ways + 1;
            end
            // read update
            else if(hit_d) begin
                i = way_d + lru_size;
                for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                    i_parent = (i[0] ? i-1 : i-2) >> 1;
                    lru_tree[addr_set_d][i_parent] = !i[0];
                    i = i_parent;
                end

                for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                    i = lru_tree[addr_set_d][i] ? i<<1 + 1 : i<<1 + 2;
                end
                re = i - `hmem_ways + 1;
            end
            else if(hit_i) begin
                i = way_i + lru_size;
                for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                    i_parent = (i[0] ? i-1 : i-2) >> 1;
                    lru_tree[addr_set_i][i_parent] = !i[0];
                    i = i_parent;
                end

                for(l = 0; l < $clog2(`hmem_ways); l = l + 1) begin
                    i = lru_tree[addr_set_i][i] ? i<<1 + 1 : i<<1 + 2;
                end
                re = i - `hmem_ways + 1;
            end
        end
    end

    /* CACHE DATA UPDATE */

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
            // cache hit, write data to cache and write-through
            if(hit_d && b_wr_d) begin
                // write data to cache
                data[addr_set_d][way_d][8*addr_offs_d +: `dmem_line] = b_data_in_d;
                // write-through
                h_data_out <= data[addr_set_d][way_d];
            end
            // data cache miss, load into cache line on valid external data bus
            if(!hit_d && h_dv && (b_rd_d || b_wr_d)) begin : hmem_cache_miss_d
                // load data into cache
                v[addr_set_d][re]   <= 1'b1;
                tag[addr_set_d][re] <= addr_tag_d;
                data[addr_set_d][re] = h_data_in;

                if(b_wr_d) begin
                    // write data to cache
                    data[addr_set_d][re][8*addr_offs_d +: `dmem_line] = b_data_in_d;
                    // write-through
                    h_data_out <= data[addr_set_d][re];
                end
            end
            // instruction cache miss, load into cache on valid external data bus
            else if(!hit_i && h_dv && b_rd_i) begin : hmem_cache_miss_i
                // load data into cache
                v[addr_set_i][re]   <= 1'b1;
                tag[addr_set_i][re] <= addr_tag_i;
                data[addr_set_i][re] = h_data_in;
            end
        end
    end

    /* BUS CONTROL SIGNALS */

    always @(posedge clk) begin
        if(b_rd_d || b_wr_d) h_addr <= {b_addr_d[63:`hmem_offs_len], {`hmem_offs_len{1'b0}}};
        else h_addr <= {b_addr_i[63:`hmem_offs_len], {`hmem_offs_len{1'b0}}};
    end

    reg h_wr_d;
    always @(posedge clk) begin
        h_wr_d <= hit_d && b_wr_d;
        h_wr <= !h_wr_d && hit_d && b_wr_d;
    end

    // read from L3 cache if L2 cache miss
    assign h_rd = (~hit_i && b_rd_i) || (~hit_d && (b_rd_d || b_wr_d));
    
endmodule
