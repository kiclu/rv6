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

`include "../config.vh"

module cmem(
    // write bus
    input                   [63:0] addr,
    input                   [ 2:0] len,
    input                   [63:0] wdata,
    input                          wr,

    // imem read bus
    input      [`IMEM_BLK_LEN-1:0] b_addr_i,
    output        [`IMEM_LINE-1:0] b_data_i,
    input                          b_rd_i,
    output                         b_dv_i,

    // dmem read bus
    input      [`DMEM_BLK_LEN-1:0] b_addr_d,
    output        [`DMEM_LINE-1:0] b_rdata_d,
    input                          b_rd_d,
    output                         b_dv_d,

    // external bus
    output     [`CMEM_BLK_LEN-1:0] b_addr_c,
    input         [`CMEM_LINE-1:0] b_rdata_c,
    output                         b_rd_c,
    input                          b_dv_c,

    // cache invalidation
    input      [`CMEM_BLK_LEN-1:0] inv_addr,
    input                          inv,

    // control signals
    output                         stall_cmem,
    input                          rst_n,
    input                          clk
);

    // TODO:

endmodule
