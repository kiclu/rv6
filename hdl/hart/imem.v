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
 * Configurable L1 instruction cache
 */

`include "../config.v"

module imem(
    input                    [63:0] pc,
    output reg               [31:0] ir,

    output reg  [`IMEM_BLK_LEN-1:0] b_addr_i,
    input          [`IMEM_LINE-1:0] b_data_i,
    output reg                      b_rd_i,
    input                           b_dv_i,

    // control signals
    input                           stall,
    output reg                      stall_imem,
    input                           rst_n,
    input                           clk
);

    // TODO:

endmodule
