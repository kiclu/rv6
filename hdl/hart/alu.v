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
    input      [14:0] op_ir
);

    `define op_itype    7'b0010011
    `define op_itype_w  7'b0011011

    `define op_rtype    7'b0110011
    `define op_rtype_w  7'b0111011

    `define op_lui      7'b0110111

    `define op_amo      7'b0101111

    `define op_system   7'b1110011


    `define sa $signed(a)
    `define sb $signed(b)

    `define wa a[31:0]
    `define wb b[31:0]

    `define swa $signed(a[31:0])

    always @(a, b, op_ir) begin
        alu_out = a + b;
        if(op_ir[6:0] == `op_lui) alu_out = b;
        else if(op_ir[6:0] == `op_amo) begin
            case(op_ir[14:10])
                5'b10000: alu_out = `sa < `sb ? a : b;
                5'b10100: alu_out = `sa > `sb ? a : b;
                5'b11000: alu_out = a < b ? a : b;
                5'b11100: alu_out = a > b ? a : b;
                default:  alu_out = 0;
            endcase
        end
        else if(op_ir[6:0] == `op_system) begin
            alu_out = op_ir[9] ? b : a;
        end
        else if(op_ir[6:0] == `op_rtype || op_ir[6:0] == `op_itype) begin
            case(op_ir[9:7])
                4'b000:  alu_out = op_ir[6:0] == `op_rtype && op_ir[13] ? a - b : a + b;
                4'b001:  alu_out = `sa << b[5:0];
                4'b010:  alu_out = `sa < `sb;
                4'b011:  alu_out = a  <  b;
                4'b100:  alu_out = a  ^  b;
                4'b101:  alu_out = op_ir[13] ? `sa >>> b[5:0] : `sa >> b[5:0];
                4'b110:  alu_out = a  |  b;
                4'b111:  alu_out = a  &  b;
            endcase
        end
        else if(op_ir[6:0] == `op_rtype_w || op_ir[6:0] == `op_itype_w) begin
            case(op_ir[9:7])
                3'b000:  alu_out[31:0] = op_ir[6:0] == `op_rtype_w && op_ir[13] ? `wa - `wb : `wa + `wb;
                3'b001:  alu_out[31:0] = `wa << b[4:0];
                3'b101:  alu_out[31:0] = op_ir[13] ? `swa >>> b[4:0] : `swa >> b[4:0];
                default: alu_out[31:0] = `wa + `wb;
            endcase
            alu_out[63:32] = (op_ir[9:7] == 3'b001 || op_ir[9:7] == 3'b101) ? 32'b0 : {32{alu_out[31]}};
        end
    end

endmodule
