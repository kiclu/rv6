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

module cu(
    input      [31:0] ir_if,
    input      [31:0] ir_pd,
    input      [31:0] ir_id,
    input      [31:0] ir_ex,
    input      [31:0] ir_mem,
    input      [31:0] ir_wb,

    input             b_rd_i,

    input             b_rd,
    input             b_wr,

    output            stall_if,
    output            stall_pd,
    output            stall_id,
    output            stall_ex,
    output            stall_mem,

    output            flush_ex_n,

    input             rst_n,

    input             clk
);

    wire [4:0] rs1 = ir_id[19:15];
    wire [4:0] rs2 = ir_id[24:20];

    wire [4:0] rd_ex  = ir_ex [11:7];
    wire [4:0] rd_mem = ir_mem[11:7];
    wire [4:0] rd_wb  = ir_wb [11:7];

    wire wr_ex  = (ir_ex [6:0] != 7'b1100011) && (ir_ex [6:0] != 7'b0100011);
    wire wr_mem = (ir_mem[6:0] != 7'b1100011) && (ir_mem[6:0] != 7'b0100011);
    wire wr_wb  = (ir_wb [6:0] != 7'b1100011) && (ir_wb [6:0] != 7'b0100011);

    wire stall_all = !rst_n || b_rd_i || b_rd || b_wr;

    reg  [1:0] stall_c;

    // in order for a data hazard to occur, following needs to be true:
    // 1. instruction in ID stage depends on register result of instructions in either EX, MEM or WB
    // 2. EX, MEM or WB register result must not be zero register (fake dependency 1)
    // 3. EX, MEM or WB instruction must update register (fake dependency 2)
    wire dh_ex  = (rd_ex  == rs1 || rd_ex  == rs2) && rd_ex  && wr_ex;
    wire dh_mem = (rd_mem == rs1 || rd_mem == rs2) && rd_mem && wr_mem;
    wire dh_wb  = (rd_wb  == rs1 || rd_wb  == rs2) && rd_wb  && wr_wb;

    wire dh = (dh_ex || dh_mem || dh_wb) && !stall_c;

    assign stall_if  = stall_all || stall_c || dh;
    assign stall_pd  = stall_all || stall_c || dh;
    assign stall_id  = stall_all || stall_c || dh;
    assign stall_ex  = stall_all;
    assign stall_mem = stall_all;

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) stall_c <= 0;
        else if(dh) begin
            if(dh_ex) stall_c <= 2;
            else if(dh_mem) stall_c <= 1;
        end
        else if(!stall_all) if(stall_c) stall_c <= stall_c - 1;
    end

    // TODO: check if correct
    assign flush_ex_n = !(stall_c != 2 && dh_ex && !stall_all);
    //assign flush_ex_n = !(stall_c != 2 && dh && !stall_all);

endmodule
