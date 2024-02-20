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

module cu (
    input      [31:0] ir_if,
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

    // extern core stall
    input             c_stall,

    // cache stall signals
    input             stall_imem,
    input             stall_dmem,

    // instruction fence signal
    output            fence_i,

    // atomic instruction signals
    input             amo_req,
    input             amo_ack,

    // forwarding signals
    output reg [ 1:0] s_mx_a_fw,
    output reg        a_fw,
    output reg [ 1:0] s_mx_b_fw,
    output reg        b_fw,

    // control signals
    input             rst_n,
    input             clk
);

    wire stall_all = !rst_n || stall_imem || stall_dmem || (amo_req && !amo_ack) || c_stall;

    /* PIPELINE DATA HAZARD */

    wire rs1_pc  = ir_id[6:0] == `OP_LUI || ir_id[6:0] == `OP_AUIPC || ir_id[6:0] == `OP_JAL;
    wire rs2_imm = ir_id[6:0] != `OP_ALRR && ir_id[6:0] != `OP_ALRRW;

    wire [4:0] rs1 = ir_id[19:15];
    wire [4:0] rs2 = ir_id[24:20];

    wire [4:0] rd_ex  = ir_ex [11:7];
    wire [4:0] rd_mem = ir_mem[11:7];
    wire [4:0] rd_wb  = ir_wb [11:7];

    wire wr_ex  = ir_ex [6:0] != `OP_BRANCH && ir_ex [6:0] != `OP_STORE;
    wire wr_mem = ir_mem[6:0] != `OP_BRANCH && ir_mem[6:0] != `OP_STORE;
    wire wr_wb  = ir_wb [6:0] != `OP_BRANCH && ir_wb [6:0] != `OP_STORE;

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
                a_fw <= ir_ex[6:0] != `OP_LOAD && ir_ex[6:0] != `OP_SYSTEM;
                s_mx_a_fw <= 0;
            end
            else if(a_fw_mem) begin
                a_fw <= ir_mem[6:0] != `OP_LOAD && ir_mem[6:0] != `OP_SYSTEM;
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
                b_fw <= ir_ex[6:0] != `OP_LOAD && ir_ex[6:0] != `OP_SYSTEM;
                s_mx_b_fw <= 0;
            end
            else if(b_fw_mem) begin
                b_fw <= ir_ex[6:0] != `OP_LOAD && ir_mem[6:0] != `OP_SYSTEM;
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
        if(a_fw_ex || b_fw_ex)        fw <= ir_ex [6:0] != `OP_LOAD && ir_ex [6:0] != `OP_SYSTEM;
        else if(a_fw_mem || b_fw_mem) fw <= ir_mem[6:0] != `OP_LOAD && ir_mem[6:0] != `OP_SYSTEM;
        else if(a_fw_wb || b_fw_wb)   fw <= 1;
    end

    /* STALL */

    // front end stall counter
    reg  [1:0] stall_c;

    // back end stall counter
    reg  [4:0] stall_d;

    wire dh = (dh_ex || dh_mem || dh_wb) && !stall_c &&
        (!fw || ir_id[6:0] == `OP_BRANCH || ir_id[6:0] == `OP_JALR || ir_id[6:0] == `OP_STORE || ir_id[6:0] == `OP_SYSTEM);

    // disable forwarding
    //wire dh = (dh_ex || dh_mem || dh_wb) && !stall_c;

    // front end stall signals
    assign stall_if  = stall_all || stall_c || dh || amo_req || fence_i;
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

    /* FENCE_I */

    wire i_fence = ir_if[6:0] == `OP_FENCE;
    reg i_fence_d;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) i_fence_d <= 0;
        else i_fence_d <= i_fence;
    end
    wire i_fence_re = i_fence && !i_fence_d;

    reg [2:0] fence_cnt;
    reg fence_cnt_ena;

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) fence_cnt_ena <= 0;
        else if(i_fence_re) fence_cnt_ena <= 1;
        else if(fence_cnt == 3'd0) fence_cnt_ena <= 0;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) fence_cnt <= 3'd5;
        else begin
            if(!fence_cnt_ena) fence_cnt <= 3'd5;
            if(!stall_wb && fence_cnt_ena) fence_cnt <= fence_cnt - 1;
        end
    end

    assign fence_i = !stall_imem && (i_fence_re || (fence_cnt_ena && fence_cnt != 3'd0));

endmodule
