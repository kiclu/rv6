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

module regfile (
    output [63:0] r1,
    input   [4:0] rs1,

    output [63:0] r2,
    input   [4:0] rs2,

    input  [63:0] d,
    input   [4:0] rd,
    input         wr,

    input         clk
);

    (* ram_style = "registers" *)
    reg [63:0] _reg [1:31];

    assign r1 = rs1 ? _reg[rs1] : 64'b0;
    assign r2 = rs2 ? _reg[rs2] : 64'b0;

    always @(posedge clk) if(wr && rd) _reg[rd] <= d;

endmodule
