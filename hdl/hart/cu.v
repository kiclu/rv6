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

`define op_lui      7'b0110111
`define op_auipc    7'b0010111
`define op_jal      7'b1101111
`define op_jalr     7'b1100111

`define op_load     7'b0000011
`define op_store    7'b0100011

`define op_itype    7'b0010011
`define op_itype_w  7'b0011011

`define op_rtype    7'b0110011
`define op_rtype_w  7'b0111011

`define op_branch   7'b1100011

`define op_system   7'b1110011

module cu (
    input      [31:0] ir_id,
    input      [31:0] ir_ex,
    input      [31:0] ir_mem,
    input      [31:0] ir_wb,

    // stage stall signals
    output            stall_if,
    output            stall_pd,
    output            stall_id,
    output            stall_ex,
    output            stall_mem,
    output            stall_wb,

    // input stall causes
    input             stall_imem,
    input             stall_dmem,
    input             stall_hmem,

    // atomic instruction signals
    input             amo_req,
    input             amo_ack,

    // instruction/data bus signals
    input             b_rd_i,
    input             b_rd_d,

    // forwarding signals
    output reg [ 1:0] s_mx_a_fw,
    output reg        a_fw,

    output reg [ 1:0] s_mx_b_fw,
    output reg        b_fw,

    input             rst_n,

    input             clk
);

    wire stall_all = !rst_n || stall_hmem || stall_imem || stall_dmem || (amo_req && !amo_ack);

    /* PIPELINE DATA HAZARD */

    wire rs1_pc  =
        ir_id[6:0] == `op_lui   ||
        ir_id[6:0] == `op_auipc ||
        ir_id[6:0] == `op_jal;

    wire rs2_imm =
        ir_id[6:0] != `op_rtype &&
        ir_id[6:0] != `op_rtype_w;

    wire [4:0] rs1 = ir_id[19:15];
    wire [4:0] rs2 = ir_id[24:20];

    wire [4:0] rd_ex  = ir_ex [11:7];
    wire [4:0] rd_mem = ir_mem[11:7];
    wire [4:0] rd_wb  = ir_wb [11:7];

    wire wr_ex  = ir_ex [6:0] != `op_branch && ir_ex [6:0] != `op_store;
    wire wr_mem = ir_mem[6:0] != `op_branch && ir_mem[6:0] != `op_store;
    wire wr_wb  = ir_wb [6:0] != `op_branch && ir_wb [6:0] != `op_store;

    /* DATA HAZARD DETECTION */

    // in order for a data hazard to occur, following needs to be true:
    // 1. instruction in ID stage depends on register result of instructions in either EX, MEM or WB
    // 2. EX, MEM or WB register result must not be zero register (result discarded false dependency)
    // 3. EX, MEM or WB instruction must update register (RAR false dependency)

    wire dh_ex  = ((rd_ex  == rs1 && !rs1_pc) || (rd_ex  == rs2 /*&& !rs2_imm*/)) && rd_ex  && wr_ex  && !stall_ex;
    wire dh_mem = ((rd_mem == rs1 && !rs1_pc) || (rd_mem == rs2 /*&& !rs2_imm*/)) && rd_mem && wr_mem && !stall_mem;
    wire dh_wb  = ((rd_wb  == rs1 && !rs1_pc) || (rd_wb  == rs2 /*&& !rs2_imm*/)) && rd_wb  && wr_wb  && !stall_wb;

    /* FORWARDING */

    wire a_fw_ex  = rd_ex  == rs1 && !rs1_pc && rd_ex  && wr_ex;
    wire a_fw_mem = rd_mem == rs1 && !rs1_pc && rd_mem && wr_mem;
    wire a_fw_wb  = rd_wb  == rs1 && !rs1_pc && rd_wb  && wr_wb;

    always @(posedge clk) begin
        if(!stall_all) begin
            if(a_fw_ex) begin
                a_fw <= ir_ex[6:0] != `op_load;
                s_mx_a_fw <= 0;
            end
            else if(a_fw_mem) begin
                a_fw <= ir_mem[6:0] != `op_load;
                s_mx_a_fw <= 1;
            end
            else if(a_fw_wb) begin
                a_fw <= 1;
                s_mx_a_fw <= 2;
            end
            else a_fw <= 0;
        end
    end

    wire b_fw_ex  = rd_ex  == rs2 && !rs2_imm && rd_ex  && wr_ex;
    wire b_fw_mem = rd_mem == rs2 && !rs2_imm && rd_mem && wr_mem;
    wire b_fw_wb  = rd_wb  == rs2 && !rs2_imm && rd_wb  && wr_wb;

    always @(posedge clk) begin
        if(!stall_all) begin
            if(b_fw_ex) begin
                b_fw <= ir_ex[6:0] != `op_load;
                s_mx_b_fw <= 0;
            end
            else if(b_fw_mem) begin
                b_fw <= ir_ex[6:0] != `op_load;
                s_mx_b_fw <= 1;
            end
            else if(b_fw_wb) begin
                b_fw <= 1;
                s_mx_b_fw <= 2;
            end
            else b_fw <= 0;
        end
    end

    reg fw;
    always @(*) begin
        fw <= 0;
        if(a_fw_ex || b_fw_ex)        fw <= ir_ex [6:0] != `op_load && ir_ex [6:0] != `op_system;
        else if(a_fw_mem || b_fw_mem) fw <= ir_mem[6:0] != `op_load && ir_mem[6:0] != `op_system;
        else if(a_fw_wb || b_fw_wb)   fw <= 1;
    end

    /* STALL */

    // front end stall counter
    reg  [1:0] stall_c;

    // back end stall counter
    reg  [4:0] stall_d;

    wire dh = (dh_ex || dh_mem || dh_wb) && !stall_c &&
        (!fw || ir_id[6:0] == `op_branch || ir_id[6:0] == `op_jalr || ir_id[6:0] == `op_store);

    // disable forwarding
    //wire dh = (dh_ex || dh_mem || dh_wb) && !stall_c;

    // front end stall signals
    assign stall_if  = stall_all || stall_c || dh || amo_req;
    assign stall_pd  = stall_all || stall_c || dh;
    assign stall_id  = stall_all || stall_c || dh;

    // back end stall signals
    assign stall_ex  = stall_all || stall_d[2];
    assign stall_mem = stall_all || stall_d[3];
    assign stall_wb  = stall_all || stall_d[4];

    always @(posedge clk) begin
        if(!rst_n) begin
            stall_c <= 0;
            stall_d <= 5'b11111;
        end
        else if(dh) begin
            if(dh_ex) begin
                stall_c <= 2;
                stall_d <= (stall_d << 1) | 5'b00111;
            end
            else if(dh_mem) begin
                stall_c <= 1;
                stall_d <= (stall_d << 1) | 5'b00110;
            end
            else if(dh_wb) begin
                stall_c <= 0;
                stall_d <= (stall_d << 1) | 5'b00100;
            end
        end
        else if(!stall_all) begin
            if(stall_c) stall_c <= stall_c - 1;
            stall_d <= stall_d << 1;
        end
    end

endmodule
