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

module alu(
    input      [63:0] a,
    input      [63:0] b,
    output reg [63:0] alu_out,
    input      [31:0] ir
);

    wire signed [63:0] sa = a;
    wire signed [63:0] sb = b;

    always @(*) begin
        if(ir[6:0] == 7'b0010011) begin
            casez({ir[30], ir[14:12]})
                4'bz000: alu_out <= a + b;
                4'bz010: alu_out <= sa < sb;
                4'bz011: alu_out <= a < b;
                4'bz100: alu_out <= a ^ b;
                4'bz110: alu_out <= a | b;
                4'bz111: alu_out <= a & b;

                4'b0001: alu_out <= a << b[5:0];
                4'b0101: alu_out <= a >> b[5:0];
                4'b1101: alu_out <= a >>> b[5:0];
                default: alu_out <= a + b;
            endcase
        end
        if(ir[6:0] == 7'b0110011) begin
            case({ir[30], ir[14:12]})
                4'b0000: alu_out <= a + b;
                4'b0001: alu_out <= a << b[5:0];
                4'b0010: alu_out <= sa < sb;
                4'b0011: alu_out <= a < b;
                4'b0100: alu_out <= a ^ b;
                4'b0101: alu_out <= a >> b[5:0];
                4'b0110: alu_out <= a | b;
                4'b0111: alu_out <= a & b;

                4'b1000: alu_out <= a - b;
                4'b1101: alu_out <= a >>> b[5:0];
                default: alu_out <= a + b;
            endcase
        end
        else if(ir[6:0] == 7'b0110111) alu_out <= b;
        else alu_out <= a + b;
    end

endmodule
