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

module imem(
    input      [  63:0] pc,

    output     [  31:0] ir,

    input      [1023:0] b_data,
    output              b_rd,
    input               b_dv,

    input               clr_n,

    input               clk
);

    wire [  54:0] addr_tag  = pc[63:9];
    wire [   1:0] addr_set  = pc[8:7];
    wire [   6:0] addr_offs = pc[6:0];

    reg  [1023:0] data [0:3][0:3];
    reg  [  54:0] tag  [0:3][0:3];
    reg           v    [0:3][0:3];

    reg [1:0] set_mux [0:3];
    assign ir = data[addr_set][set_mux[addr_set]][8*addr_offs+31 -: 32];

    // check for cache hit and set mux
    reg hit;
    always @(*) begin : cache_hit_check
        integer e;
        hit <= 1'b0;
        for(e = 0; e < 4; e = e + 1) begin
            if(tag[addr_set][e] == addr_tag && v[addr_set][e]) begin
                set_mux[addr_set] <= e;
                hit <= 1'b1;
            end
        end
    end

    assign b_rd = ~hit;

    // update lru tree on hit
    reg [2:0] lru_tree [0:3];
    always @(posedge clk, negedge clr_n) begin
        if(!clr_n) clr_lru_tree();
        else if(hit) begin
            case(set_mux[addr_set])
                2'b00: lru_tree[addr_set] <= lru_tree[addr_set] & 3'b001 | 3'b000;
                2'b01: lru_tree[addr_set] <= lru_tree[addr_set] & 3'b001 | 3'b010;
                3'b10: lru_tree[addr_set] <= lru_tree[addr_set] & 3'b010 | 3'b100;
                3'b11: lru_tree[addr_set] <= lru_tree[addr_set] & 3'b010 | 3'b101;
            endcase
        end
    end

    // load on miss
    always @(posedge clk, negedge clr_n) begin
        if(!clr_n) clr_v();
        else if(!hit && b_dv) begin
            if(lru_tree[addr_set][2]) begin
                if(lru_tree[addr_set][1]) begin
                    tag[addr_set][0]  <= addr_tag;
                    data[addr_set][0] <= b_data;
                    v[addr_set][0]    <= 1'b1;
                end
                else begin
                    tag[addr_set][1]  <= addr_tag;
                    data[addr_set][1] <= b_data;
                    v[addr_set][1]    <= 1'b1;
                end
            end
            else begin
                if(lru_tree[addr_set][0]) begin
                    tag[addr_set][2]  <= addr_tag;
                    data[addr_set][2] <= b_data;
                    v[addr_set][2]    <= 1'b1;
                end
                else begin
                    tag[addr_set][3]  <= addr_tag;
                    data[addr_set][3] <= b_data;
                    v[addr_set][3]    <= 1'b1;
                end
            end
        end
    end

    // clear valid bits on reset
    task clr_v();
        integer s, e;
        for(s = 0; s < 4; s = s + 1) begin
            for(e = 0; e < 4; e = e + 1) begin
                v[s][e] = 0;
            end
        end
    endtask

    // clear lru tree on reset
    task clr_lru_tree();
        integer s;
        for(s = 0; s < 4; s = s + 1) lru_tree[s] <= 3'b000;
    endtask

endmodule
