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

module dba(
    input                [63:0] addr,
    input                [ 2:0] len,
    output               [63:0] rdata,
    input                       rd,
    input                [63:0] wdata,
    input                       wr,

    // cmem read bus
    input                [63:0] b_addr_c,
    input                       b_rd_c,
    output                      b_dv_c,

    // external bus
    output               [63:0] c_addr,
    output                      c_ext,

    input      [`CMEM_LINE-1:0] c_rdata,
    output                      c_rd,
    input                       c_dv,

    output               [63:0] c_wdata,
    output               [ 1:0] c_len,
    output                      c_wr
);

    assign c_ext   = (addr < `EXT_MMAP_RANGE) && (rd || wr);

endmodule
