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
    // write bus
    input                [63:0] b_addr_w,
    input                [63:0] b_wdata_w,
    input                [ 1:0] b_len_w,
    input                       b_wr_w,

    // read bus
    input   [`CMEM_BLK_LEN-1:0] b_addr_c,
    output  [   `CMEM_LINE-1:0] b_rdata_c,
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

    assign b_rdata_c    = c_rdata;
    assign b_dv_c       = c_dv;

    assign c_addr   = {b_addr_c, {`CMEM_OFFS_LEN{1'b0}}};
    assign c_ext    = (c_addr < `EXT_MMAP_RANGE) && (c_rd || c_wr);
    assign c_rd     = b_rd_c;

    assign c_wdata  = b_wdata_w;
    assign c_len    = b_len_w;
    assign c_wr     = b_wr_w;

endmodule
