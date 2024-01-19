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

module alu (
    input      [63:0] a,
    input      [63:0] b,
    output reg [63:0] alu_out,
    input      [ 6:0] opcode,
    input      [ 2:0] op,
    input             mod
);

    wire w = opcode[3];
    wire mod_sub = mod && opcode[5];

    wire [63:0] op1 = w ? {{32{a[31]}}, a[31:0]} : a;
    wire [63:0] op2 = w ? {{32{b[31]}}, b[31:0]} : b;

    wire [5:0] shamt = {op2[5] & ~w, op2[4:0]};

    /* ADD / SUB */

    wire [63:0] d_add = mod_sub ? op1 - op2 : op1 + op2;
    wire [31:0] add_ext = w ? {32{d_add[31]}} : d_add[63:32];

    /* SLL */

    wire [63:0] d_sll = op1 << shamt;
    wire [31:0] sll_ext = w ? {32{d_sll[31]}} : d_sll[63:32];

    /* SLT */

    wire signed [63:0] op1_s = op1;
    wire signed [63:0] op2_s = op2;

    wire slt = op1_s < op2_s;
    wire [63:0] d_slt = {63'b0, slt};
    wire [31:0] slt_ext = 32'b0;

    /* SLTU */

    wire [63:0] d_sltu = {63'b0, op1 < op2};
    wire [31:0] sltu_ext = 32'b0;

    /* XOR */

    wire [63:0] d_xor = op1 ^ op2;
    wire [31:0] xor_ext = d_xor[63:32];

    /* SRL / SRA */

    wire signed [63:0] op1_sd = a;
    wire signed [63:0] op2_sd = b;
    wire signed [31:0] op1_sw = a[31:0];
    wire signed [31:0] op2_sw = b[31:0];

    wire [63:0] srl     = op1_sd >>  shamt;
    wire [63:0] sra     = op1_sd >>> shamt;
    wire [31:0] srlw    = op1_sw >>  shamt;
    wire [31:0] sraw    = op1_sw >>> shamt;
    wire [63:0] shr_d   = mod ? sra  : srl;
    wire [31:0] shr_w   = mod ? sraw : srlw;
    wire [63:0] d_shr   = w ? shr_w : shr_d;
    wire [31:0] shr_ext = w ? {32{mod ? sraw[31] : srlw[31]}} : d_shr[63:32];

    /* OR */

    wire [63:0] d_or = op1 | op2;
    wire [31:0] or_ext = d_or[63:32];

    /* AND */

    wire [63:0] d_and = op1 & op2;
    wire [31:0] and_ext = d_and[63:32];

    /* OP MUX */

    wire [63:0] alu_out_mux [0:7];
    assign alu_out_mux[0] = d_add;
    assign alu_out_mux[1] = d_sll;
    assign alu_out_mux[2] = d_slt;
    assign alu_out_mux[3] = d_sltu;
    assign alu_out_mux[4] = d_xor;
    assign alu_out_mux[5] = d_shr;
    assign alu_out_mux[6] = d_or;
    assign alu_out_mux[7] = d_and;

    /* EXT MUX */

    wire [31:0] alu_ext_mux [0:7];
    assign alu_ext_mux[0] = add_ext;
    assign alu_ext_mux[1] = sll_ext;
    assign alu_ext_mux[2] = slt_ext;
    assign alu_ext_mux[3] = sltu_ext;
    assign alu_ext_mux[4] = xor_ext;
    assign alu_ext_mux[5] = shr_ext;
    assign alu_ext_mux[6] = or_ext;
    assign alu_ext_mux[7] = and_ext;

    always @(*) begin
        case(opcode)
            `OP_ALRI, `OP_ALRR, `OP_ALRIW, `OP_ALRRW: alu_out = {alu_ext_mux[op], alu_out_mux[op][31:0]};
            `OP_LUI: alu_out = b;
            default: alu_out = a + b;
        endcase
    end

endmodule
