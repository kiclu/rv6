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

`include "../hdl/config.vh"

`timescale 1ns/1ps
module tb_cmem();

    reg               [63:0] b_addr_i;
    wire    [`IMEM_LINE-1:0] b_data_i;
    reg                      b_rd_i;
    wire                     b_dv_i;
    reg               [63:0] b_addr_d;
    wire    [`DMEM_LINE-1:0] b_data_in_d;
    reg                      b_rd_d;
    wire                     b_dv_d;
    reg     [`DMEM_LINE-1:0] b_data_out_d;
    reg                      b_wr_d;
    wire              [63:0] h_addr;
    reg     [`CMEM_LINE-1:0] h_data_in;
    wire                     h_rd;
    reg                      h_dv;
    wire    [`CMEM_LINE-1:0] h_data_out;
    wire                     h_wr;
    reg               [63:0] inv_addr;
    reg                      inv;
    reg                      rst_n;
    reg                      clk;

    cmem dut(
        .b_addr_i       (b_addr_i       ),
        .b_data_i       (b_data_i       ),
        .b_rd_i         (b_rd_i         ),
        .b_dv_i         (b_dv_i         ),
        .b_addr_d       (b_addr_d       ),
        .b_data_in_d    (b_data_in_d    ),
        .b_rd_d         (b_rd_d         ),
        .b_dv_d         (b_dv_d         ),
        .b_data_out_d   (b_data_out_d   ),
        .b_wr_d         (b_wr_d         ),
        .h_addr         (h_addr         ),
        .h_data_in      (h_data_in      ),
        .h_rd           (h_rd           ),
        .h_dv           (h_dv           ),
        .h_data_out     (h_data_out     ),
        .h_wr           (h_wr           ),
        .inv_addr       (inv_addr       ),
        .inv            (inv            ),
        .rst_n          (rst_n          ),
        .clk            (clk            )
    );

endmodule
