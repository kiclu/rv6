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

/*
 * Configurable, write-allocated L2 hart cache with write-through policy
 */

`include "../config.v"

module hmem(
    // internal instruction bus
    input      [`IMEM_BLK_LEN-1:0] b_addr_i,
    output        [`IMEM_LINE-1:0] b_data_i,
    input                          b_rd_i,
    output                         b_dv_i,

    // internal data bus
    input                   [63:0] b_addr_d,

    output        [`DMEM_LINE-1:0] b_data_d,
    input                          b_rd_d,
    output                         b_dv_d,

    // external bus
    output reg              [63:0] h_addr,

    input         [`HMEM_LINE-1:0] h_data_in,
    output reg                     h_rd,
    input                          h_dv,

    output reg    [`HMEM_LINE-1:0] h_data_out,
    output reg                     h_wr,

    // control signals
    input                   [63:0] inv_addr,
    input                          inv,

    output                         stall_hmem,
    input                          rst_n,
    input                          clk
);

    // TODO:

endmodule
