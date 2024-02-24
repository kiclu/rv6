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

`define PHY_ADDR 64

`include "../config.vh"

module pmp (
    input     [`PHY_ADDR-1:0] b_addr_w_p,
    input                     b_wr_w_p,
    input [`IMEM_BLK_LEN-1:0] b_addr_i_p,
    input                     b_rd_i_p,
    input [`DMEM_BLK_LEN-1:0] b_addr_d_p,
    input                     b_rd_d_p,

    input              [ 1:0] priv,

    input              [63:0] pmpcfg0,
    input              [63:0] pmpcfg2,

    input              [63:0] pmpaddr0,
    input              [63:0] pmpaddr1,
    input              [63:0] pmpaddr2,
    input              [63:0] pmpaddr3,
    input              [63:0] pmpaddr4,
    input              [63:0] pmpaddr5,
    input              [63:0] pmpaddr6,
    input              [63:0] pmpaddr7,
    input              [63:0] pmpaddr8,
    input              [63:0] pmpaddr9,
    input              [63:0] pmpaddr10,
    input              [63:0] pmpaddr11,
    input              [63:0] pmpaddr12,
    input              [63:0] pmpaddr13,
    input              [63:0] pmpaddr14,
    input              [63:0] pmpaddr15,

    output                    pmp_iaf,
    output                    pmp_laf,
    output                    pmp_saf,

    input                     rst_n,
    input                     clk
);

    wire [ 7:0] pmpcfg  [0:15];
    wire [63:0] pmpaddr [0:15];

    reg  [15:0] access_i;
    reg  [15:0] access_d;
    reg  [15:0] access_w;

    wire [63:0] napot_mask [0:15];

    wire pmp_iaf_oob = |b_addr_i_p[63-`IMEM_OFFS_LEN -: 8] && b_rd_i_p;
    wire pmp_laf_oob = |b_addr_d_p[63-`DMEM_OFFS_LEN -: 8] && b_rd_d_p;
    wire pmp_saf_oob = |b_addr_w_p[63:56] && b_wr_w_p;

    assign pmp_iaf = (~|access_i && b_rd_i_p && priv != 2'b11) || pmp_iaf_oob;
    assign pmp_laf = (~|access_d && b_rd_d_p && priv != 2'b11) || pmp_laf_oob;
    assign pmp_saf = (~|access_w && b_wr_w_p && priv != 2'b11) || pmp_saf_oob;

    wire [63:0] b_addr_w = b_addr_w_p;
    wire [63:0] b_addr_i = {b_addr_i_p, {`IMEM_OFFS_LEN{1'b0}}};
    wire [63:0] b_addr_d = {b_addr_d_p, {`DMEM_OFFS_LEN{1'b0}}};

    genvar i;
    generate
        for(i = 0; i < 16; i = i + 1) begin
            always @(*) begin
                case(pmpcfg[i][4:3])
                    // OFF
                    2'b00: begin
                        access_w[i] = 0;
                        access_i[i] = 0;
                        access_d[i] = 0;
                    end
                    // TOR
                    2'b01: begin
                        access_w[i] = 0;
                        access_i[i] = 0;
                        access_d[i] = 0;
                    end
                    // NA4
                    2'b10: begin
                        access_w[i] = 0;
                        access_i[i] = 0;
                        access_d[i] = 0;
                    end
                    // NAPOT
                    2'b11: begin
                        access_w[i] = &(~(b_addr_w ^ {pmpaddr[i][61:0], 2'b00}) | napot_mask[i]) && pmpcfg[i][1];
                        access_i[i] = &(~(b_addr_i ^ {pmpaddr[i][61:0], 2'b00}) | napot_mask[i]) && pmpcfg[i][2];
                        access_d[i] = &(~(b_addr_d ^ {pmpaddr[i][61:0], 2'b00}) | napot_mask[i]) && pmpcfg[i][0];
                    end
                endcase
            end
        end
    endgenerate

    /* NAPOT */

    genvar j;
    generate
        for(i = 0; i < 16; i = i + 1) begin
            assign napot_mask[i][2:0] = 3'b111;
            for(j = 4; j < 64; j = j + 1) begin
                assign napot_mask[i][j] = napot_mask[i][j-1] && pmpaddr[i][j-2];
            end
        end
    endgenerate

    /* INPUT SIGNALS */

    generate
        for(i = 0; i < 8; i = i + 1) begin
            assign pmpcfg[i]   = pmpcfg0[i<<3 +: 8];
            assign pmpcfg[i+8] = pmpcfg2[i<<3 +: 8];
        end
    endgenerate

    assign pmpaddr[0]  = pmpaddr0;
    assign pmpaddr[1]  = pmpaddr1;
    assign pmpaddr[2]  = pmpaddr2;
    assign pmpaddr[3]  = pmpaddr3;
    assign pmpaddr[4]  = pmpaddr4;
    assign pmpaddr[5]  = pmpaddr5;
    assign pmpaddr[6]  = pmpaddr6;
    assign pmpaddr[7]  = pmpaddr7;
    assign pmpaddr[8]  = pmpaddr8;
    assign pmpaddr[9]  = pmpaddr9;
    assign pmpaddr[10] = pmpaddr10;
    assign pmpaddr[11] = pmpaddr11;
    assign pmpaddr[12] = pmpaddr12;
    assign pmpaddr[13] = pmpaddr13;
    assign pmpaddr[14] = pmpaddr14;
    assign pmpaddr[15] = pmpaddr15;

endmodule
