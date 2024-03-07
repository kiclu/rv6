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

`define OP_ECALL    32'h00000073
`define OP_EBREAK   32'h00100073

module exc (
    input      [ 1:0] priv,
    input      [31:0] ir,

    output reg        exc,
    output reg [63:0] exc_cause,
    output reg [63:0] exc_val,

    input             exc_ii_if,
    input             exc_ii_csr,
    input             exc_pmp_iaf,
    input             exc_pmp_laf,
    input             exc_pmp_saf,
    input             exc_dmem_lma,
    input             exc_dmem_sma,

    input      [63:0] dmem_addr,

    input             flush_pd,
    input             flush_id,
    input             t_flush,

    input             stall_if,
    input             stall_pd,
    input             stall_id,
    input             stall_ex,
    input             stall_mem,
    input             stall_wb,

    input             rst_n,
    input             clk
);

    wire ecall  = ir == `OP_ECALL;
    wire ebreak = ir == `OP_EBREAK;

    reg        pd_exc;
    reg [ 5:0] pd_exc_cause;
    reg [63:0] pd_exc_val;

    always @(posedge clk) begin
        if(!rst_n) pd_exc <= 0;
        else if(flush_pd || t_flush) begin
            pd_exc       <= 0;
        end
        else if(exc_pmp_iaf) begin
            pd_exc       <= 1;
            pd_exc_cause <= 6'd1;
            pd_exc_val   <= 64'h0;
        end
        else if(exc_ii_if) begin
            pd_exc       <= 1;
            pd_exc_cause <= 6'd2;
            pd_exc_val   <= 64'h0;
        end
        else if(!stall_pd) begin
            pd_exc       <= 0;
        end
    end

    reg        id_exc;
    reg [ 5:0] id_exc_cause;
    reg [63:0] id_exc_val;

    always @(posedge clk) begin
        if(!rst_n) id_exc <= 0;
        else if(flush_id || t_flush) begin
            id_exc       <= 0;
        end
        else if(!stall_id) begin
            id_exc       <= pd_exc;
            id_exc_cause <= pd_exc_cause;
            id_exc_val   <= pd_exc_val;
        end
    end

    reg        ex_exc;
    reg [ 5:0] ex_exc_cause;
    reg [63:0] ex_exc_val;

    always @(posedge clk) begin
        if(!rst_n) ex_exc <= 0;
        else if(t_flush) begin
            ex_exc       <= 0;
        end
        else if(!stall_ex) begin
            ex_exc       <= id_exc;
            ex_exc_cause <= id_exc_cause;
            ex_exc_val   <= id_exc_val;
        end
    end

    reg        mem_exc;
    reg [ 5:0] mem_exc_cause;
    reg [63:0] mem_exc_val;

    always @(posedge clk) begin
        if(!rst_n) mem_exc <= 0;
        else if(t_flush) begin
            mem_exc       <= 0;
        end
        else if(!stall_mem) begin
            mem_exc       <= ex_exc;
            mem_exc_cause <= ex_exc_cause;
            mem_exc_val   <= ex_exc_val;
        end
    end

    always @(*) begin
        exc = 1;

        exc_cause = 64'h0;
        exc_val   = 64'h0;

        if(mem_exc) begin
            exc_cause = mem_exc_cause;
            exc_val   = mem_exc_val;
        end
        else if(exc_ii_csr) begin
            exc_cause = 64'd2;
        end
        else if(ecall) begin
            case(priv)
                2'b00: exc_cause = 64'd8;
                2'b01: exc_cause = 64'd9;
                2'b11: exc_cause = 64'd11;
            endcase
        end
        else if(ebreak) begin
            exc_cause = 64'd3;
        end
        else if(exc_pmp_laf) begin
            exc_cause = 64'd5;
        end
        else if(exc_pmp_saf) begin
            exc_cause = 64'd7;
        end
        else if(exc_dmem_lma) begin
            exc_cause = 64'd4;
            exc_val   = dmem_addr;
        end
        else if(exc_dmem_sma) begin
            exc_cause = 64'd6;
            exc_val   = dmem_addr;
        end
        else exc = 0;
    end

endmodule
