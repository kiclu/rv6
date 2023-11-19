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

module regfile(
    output [63:0] r1,
    input   [4:0] rs1,

    output [63:0] r2,
    input   [4:0] rs2,

    input  [63:0] d,
    input   [4:0] rd,
    input         wr,

    input         clk
);

    reg [63:0] register [1:31];

    assign r1 = rs1 ? register[rs1] : 64'b0;
    assign r2 = rs2 ? register[rs2] : 64'b0;

    always @(posedge clk) if(wr && rd) register[rd] <= d;

    // debug only, initialize registers to 0
    `ifdef DEBUG
    initial for(integer i = 1; i < 32; i++) register[i] <= 0;
    `endif

endmodule
