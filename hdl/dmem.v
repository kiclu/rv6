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

module dmem(
    input      [  63:0] addr,
    input      [   2:0] len,

    output     [  63:0] data_out,
    input               rd,

    input      [  63:0] data_in,
    input               wr,

    output     [  63:0] b_addr,

    input      [1023:0] b_data_in,
    output              b_rd,
    input               b_dv,

    output reg [1023:0] b_data_out,
    output              b_wr,

    input               clr_n,

    input               clk
);

    // write-allocated, write-through data cache
    // 4 sets, 4 lines per set

    wire   [54:0] addr_tag  = addr[63:9];
    wire   [ 1:0] addr_set  = addr[8:7];
    wire   [ 6:0] addr_offs = addr[6:0];

    reg  [1023:0] data [0:3][0:3];
    reg  [  54:0] tag  [0:3][0:3];
    reg           v    [0:3][0:3];

    // output data mux and sign/zero extend
    reg    [ 1:0] set_mux  [0:3];
    wire   [63:0] data_mux [0:6];
    assign data_mux[0] = {{56{data[addr_set][set_mux[addr_set]][8*addr_offs+ 7]}}, data[addr_set][set_mux[addr_set]][8*addr_offs +:  8]};   // byte
    assign data_mux[1] = {{48{data[addr_set][set_mux[addr_set]][8*addr_offs+15]}}, data[addr_set][set_mux[addr_set]][8*addr_offs +: 16]};   // half word
    assign data_mux[2] = {{32{data[addr_set][set_mux[addr_set]][8*addr_offs+31]}}, data[addr_set][set_mux[addr_set]][8*addr_offs +: 32]};   // word
    assign data_mux[3] = data[addr_set][set_mux[addr_set]][8*addr_offs +: 64];                                                              // double word
    assign data_mux[4] = {56'b0, data[addr_set][set_mux[addr_set]][8*addr_offs +:  8]};                                                     // unsigned byte
    assign data_mux[5] = {48'b0, data[addr_set][set_mux[addr_set]][8*addr_offs +: 16]};                                                     // unsigned half word
    assign data_mux[6] = {32'b0, data[addr_set][set_mux[addr_set]][8*addr_offs +: 32]};                                                     // unsigned word
    assign data_out = data_mux[len];

    // external bus address
    assign b_addr = {addr[63:7], 7'b0};

    // check for cache hit and set mux
    reg hit;
    always @(*) begin : cache_check
        integer e;
        hit <= 1'b0;
        for(e = 0; e < 4; e = e + 1) begin
            set_mux[e] <= 2'b00;
            if(tag[addr_set][e] == addr_tag && v[addr_set][e]) begin
                set_mux[addr_set] <= e[1:0];
                hit <= 1'b1;
            end
        end
    end

    assign b_rd = ~hit && (rd || wr);

    // update lru tree on hit
    reg [2:0] lru_tree [0:3];
    always @(posedge clk, negedge clr_n) begin
        if(!clr_n) clr_lru_tree();
        else if(hit && (rd || wr)) begin
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
        // on cache miss and valid data bus, load data into cache line
        else if(!hit && b_rd && b_dv) begin
            if(lru_tree[addr_set][2]) begin
                if(lru_tree[addr_set][1]) begin
                    tag[addr_set][0]  <= addr_tag;
                    data[addr_set][0] <= b_data_in;
                    if(wr) begin
                        case(len)
                            3'b000: data[addr_set][0][8*addr_offs +:  8] <= data_in[ 7:0];
                            3'b001: data[addr_set][0][8*addr_offs +: 16] <= data_in[15:0];
                            3'b010: data[addr_set][0][8*addr_offs +: 32] <= data_in[31:0];
                            3'b011: data[addr_set][0][8*addr_offs +: 64] <= data_in[63:0];
                        endcase
                    end
                    v[addr_set][0]    <= 1'b1;
                end
                else begin
                    tag[addr_set][1]  <= addr_tag;
                    data[addr_set][1] <= b_data_in;
                    if(wr) begin
                        case(len)
                            3'b000: data[addr_set][1][8*addr_offs +:  8] <= data_in[ 7:0];
                            3'b001: data[addr_set][1][8*addr_offs +: 16] <= data_in[15:0];
                            3'b010: data[addr_set][1][8*addr_offs +: 32] <= data_in[31:0];
                            3'b011: data[addr_set][1][8*addr_offs +: 64] <= data_in[63:0];
                        endcase
                    end
                    v[addr_set][1]    <= 1'b1;
                end
            end
            else begin
                if(lru_tree[addr_set][0]) begin
                    tag[addr_set][2]  <= addr_tag;
                    data[addr_set][2] <= b_data_in;
                    if(wr) begin
                        case(len)
                            3'b000: data[addr_set][2][8*addr_offs +:  8] <= data_in[ 7:0];
                            3'b001: data[addr_set][2][8*addr_offs +: 16] <= data_in[15:0];
                            3'b010: data[addr_set][2][8*addr_offs +: 32] <= data_in[31:0];
                            3'b011: data[addr_set][2][8*addr_offs +: 64] <= data_in[63:0];
                        endcase
                    end
                    v[addr_set][2]    <= 1'b1;
                end
                else begin
                    tag[addr_set][3]  <= addr_tag;
                    data[addr_set][3] <= b_data_in;
                    if(wr) begin
                        case(len)
                            3'b000: data[addr_set][3][8*addr_offs +:  8] <= data_in[ 7:0];
                            3'b001: data[addr_set][3][8*addr_offs +: 16] <= data_in[15:0];
                            3'b010: data[addr_set][3][8*addr_offs +: 32] <= data_in[31:0];
                            3'b011: data[addr_set][3][8*addr_offs +: 64] <= data_in[63:0];
                        endcase
                    end
                    v[addr_set][3]    <= 1'b1;
                end
            end

            // data write-through
            b_data_out <= b_data_in;
            if(wr) begin
                case(len)
                    3'b000: begin
                        b_data_out[8*addr_offs +:  8] <= data_in[ 7:0];
                        data[addr_set][set_mux[addr_set]][8*addr_offs +:  8] <= data_in[ 7:0];
                    end
                    3'b001: begin
                        b_data_out[8*addr_offs +: 16] <= data_in[15:0];
                        data[addr_set][set_mux[addr_set]][8*addr_offs +: 16] <= data_in[15:0];
                    end
                    3'b010: begin
                        b_data_out[8*addr_offs +: 32] <= data_in[31:0];
                        data[addr_set][set_mux[addr_set]][8*addr_offs +: 32] <= data_in[31:0];
                    end
                    3'b011: begin
                        b_data_out[8*addr_offs +: 64] <= data_in[63:0];
                        data[addr_set][set_mux[addr_set]][8*addr_offs +: 64] <= data_in[63:0];
                    end
                endcase
            end
        end
    end

    // control signal generation
    reg b_wr_h;
    reg b_wr_h_prev;
    wire b_wr_l = wr && b_dv && b_rd;

    always @(posedge clk) begin
        b_wr_h_prev <= wr && hit && !b_rd;
        b_wr_h      <= wr && hit && !b_rd && !b_wr_h_prev;
    end

    assign b_wr = b_wr_l || (b_wr_h && !b_rd);

    // clear valid bits on reset
    task clr_v();
        integer s;
        integer e;
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
