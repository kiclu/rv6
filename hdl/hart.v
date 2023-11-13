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

module hart(
    // instruction bus
    output [  63:0] b_addr_i,
    input  [1023:0] b_data_i,
    output          b_rd_i,
    input           b_dv_i,

    // data bus common
    output [  63:0] b_addr,

    // data bus in
    input  [1023:0] b_data_in,
    output          b_rd,
    input           b_dv,

    // data bus out
    output [1023:0] b_data_out,
    output          b_wr,

    input           rst_n,

    input           clk
);

    wire flush_n;

    /* IF */

    wire [63:0] pc;
    wire [31:0] ir;

    wire [63:0] jalr_addr;
    wire [63:0] br_addr;
    wire [63:0] jal_addr;
    wire [12:0] pr_offs;

    wire jalr_taken;
    wire jal_taken;
    wire pr_taken;

    wire pr_miss;

    wire stall_if;

    // program counter
    pc inst_pc(
        .pc(pc),

        .jalr_taken(jalr_taken),
        .jalr_addr(jalr_addr),

        .pr_miss(pr_miss),
        .br_addr(br_addr),

        .jal_taken(jal_taken),
        .jal_addr(jal_addr),

        .pr_taken(pr_taken),
        .pr_offs(pr_offs),

        .stall(stall_if),

        .clr_n(rst_n),

        .clk(clk)
    );

    // branch prediction unit
    bpu inst_bpu(
        .pc(pc),
        .ir(ir),
        .jal_taken(jal_taken),
        .jal_addr(jal_addr),
        .pr_taken(pr_taken),
        .pr_offs(pr_offs),
        .clr_n(rst_n)
    );

    // instruction memory / L1i cache
    imem inst_imem(
        .pc(pc),

        .ir(ir),

        .b_data(b_data_i),
        .b_rd(b_rd_i),
        .b_dv(b_dv_i),

        .clr_n(rst_n),

        .clk(clk)
    );

    assign b_addr_i = {pc[63:7], 7'b0};

    reg [63:0] bfp_pc;
    reg [31:0] bfp_ir;

    reg bfp_pr_taken;

    always @(posedge clk) begin
        if(!flush_n) begin
            bfp_ir <= 32'h13;
            bfp_pr_taken <= 1'b0;
        end
        else if(!stall_if) begin
            bfp_pc <= pc;
            bfp_ir <= ir;
            bfp_pr_taken <= pr_taken;
        end
    end

    /* PD */

    // instruction predecoder
    //pd inst_pd(
    //    .pc_in(bfp_pc),
    //    .ir_in(bfp_ir),

    //    .pc_out(pd_pc),
    //    .ir_out(pd_ir),

    //    .stall(stall_pd),

    //    .clk(clk)
    //);

    reg [63:0] bpd_pc;
    reg [31:0] bpd_ir;

    reg  bpd_pr_taken;

    wire stall_pd;

    always @(posedge clk) begin
        if(!flush_n) begin
            bpd_ir <= 32'h13;
            bpd_pr_taken <= 1'b0;
        end
        else if(!stall_pd) begin
            bpd_pc <= bfp_pc;
            bpd_ir <= bfp_ir;
            bpd_pr_taken <= bfp_pr_taken;
        end
    end

    /* ID */

    wire [ 4:0] rs1 = bpd_ir[19:15];
    wire [ 4:0] rs2 = bpd_ir[24:20];
    wire [ 4:0] rd;

    wire [63:0] r1;
    wire [63:0] r2;
    wire [63:0] d;

    wire wr;

    // register file
    regfile inst_regfile(
        .r1(r1),
        .rs1(rs1),

        .r2(r2),
        .rs2(rs2),

        .d(d),
        .rd(rd),
        .wr(wr),

        .clk(clk)
    );

    // branch alu
    br_alu inst_br_alu(
        .pc(bpd_pc),
        .ir(bpd_ir),

        .r1(r1),
        .r2(r2),

        .jalr_taken(jalr_taken),
        .jalr_addr(jalr_addr),

        .pr_miss(pr_miss),
        .br_addr(br_addr),

        .pr_taken(bpd_pr_taken)
    );

    assign flush_n = rst_n & !pr_miss & !jalr_taken;

    // immediate format mux
    wire [63:0] mux_imm [0:3];
    assign mux_imm[0] = {{52{bpd_ir[31]}}, bpd_ir[31:20]};                  // I-type
    assign mux_imm[1] = {{52{bpd_ir[31]}}, bpd_ir[31:25], bpd_ir[11:7]};    // S-type
    assign mux_imm[2] = {{32{bpd_ir[31]}}, bpd_ir[31:12], 12'b0};           // U-type
    assign mux_imm[3] = 64'h4;                                              // J-type
    reg [1:0] s_mux_imm;

    always @(*) begin
        case(bpd_ir[6:0])
            // I-type
            7'b0000011, 7'b0010011: s_mux_imm <= 2'b00;
            // S-type
            7'b0100011:             s_mux_imm <= 2'b01;
            // U-type
            7'b0110111, 7'b0010111: s_mux_imm <= 2'b10;
            // J-type
            7'b1101111, 7'b1100111: s_mux_imm <= 2'b11;
            default: s_mux_imm <= 2'b00;
        endcase
    end

    reg [63:0] bdx_pc;
    reg [31:0] bdx_ir;

    reg [63:0] bdx_r1;
    reg [63:0] bdx_r2;

    reg [63:0] bdx_imm;

    wire stall_id;

    always @(posedge clk) begin
        if(!rst_n) bdx_ir <= 32'h13;
        else if(!stall_id) begin
            bdx_pc <= bpd_pc;
            bdx_ir <= bpd_ir;

            bdx_r1 <= r1;
            bdx_r2 <= r2;

            bdx_imm <= mux_imm[s_mux_imm];
        end
        else bdx_ir <= 32'h13;
    end

    /* EX */

    // TODO: add forwarding
    wire [63:0] alu_mx_a [0:1];
    assign alu_mx_a[0] = bdx_r1;
    assign alu_mx_a[1] = bdx_pc;
    wire [1:0] s_alu_mx_a;

    assign s_alu_mx_a[1] = 1'b0;
    assign s_alu_mx_a[0] = (bdx_ir == 7'b1101111) || (bdx_ir == 7'b1101111);

    // TODO: add forwarding
    wire [63:0] alu_mx_b [0:1];
    assign alu_mx_b[0] = bdx_imm;
    assign alu_mx_b[1] = bdx_r2;
    wire [1:0] s_alu_mx_b;

    assign s_alu_mx_b[1] = 1'b0;
    assign s_alu_mx_b[0] = (bdx_ir == 7'b0110011);

    wire [63:0] alu_out;

    alu inst_alu(
        .a(alu_mx_a[s_alu_mx_a]),
        .b(alu_mx_b[s_alu_mx_b]),
        .alu_out(alu_out),
        .ir(bdx_ir)
    );

    reg [31:0] bxm_ir;

    reg [63:0] bxm_alu_out;
    reg [63:0] bxm_r2;

    wire stall_ex;

    always @(posedge clk) begin
        if(!rst_n) bxm_ir <= 32'h13;
        else if(!stall_ex) begin
            bxm_ir <= bdx_ir;

            bxm_alu_out <= alu_out;
            bxm_r2 <= bdx_r2;
        end
    end

    /* MEM */

    wire [63:0] dmem_out;

    // data memory / L1d cache
    dmem inst_dmem(
        .addr(bxm_alu_out),
        .len(bxm_ir[14:12]),

        .data_out(dmem_out),
        .rd(bxm_ir[6:0] == 7'b0000011),

        .data_in(bxm_r2),
        .wr(bxm_ir[6:0] == 7'b0100011),

        .b_addr(b_addr),

        .b_data_in(b_data_in),
        .b_rd(b_rd),
        .b_dv(b_dv),

        .b_data_out(b_data_out),
        .b_wr(b_wr),

        .clr_n(rst_n),

        .clk(clk)
    );

    reg [31:0] bmw_ir;

    reg [63:0] bmw_alu_out;
    reg [63:0] bmw_dmem_out;

    wire stall_mem;

    always @(posedge clk) begin
        if(!rst_n) bmw_ir <= 32'h13;
        else if(!stall_mem) begin
            bmw_ir <= bxm_ir;

            bmw_alu_out <= bxm_alu_out;
            bmw_dmem_out <= dmem_out;
        end
    end

    /* WB */

    wire [63:0] wb_mux [0:1];
    assign wb_mux[0] = bmw_alu_out;
    assign wb_mux[1] = bmw_dmem_out;
    wire s_wb_mux = (bxm_ir[6:0] == 7'b0000011);

    assign rd = bmw_ir[11:7];
    assign d  = wb_mux[s_wb_mux];

    assign wr = (bmw_ir[6:0] != 7'b1100011) && (bmw_ir[6:0] != 7'b0100011);

    /* CONTROL UNIT */

    cu inst_cu(
        .ir_if(ir),
        .ir_pd(bfp_ir),
        .ir_id(bpd_ir),
        .ir_ex(bdx_ir),
        .ir_mem(bxm_ir),
        .ir_wb(bmw_ir),

        .b_rd_i(b_rd_i),

        .b_rd(b_rd),
        .b_wr(b_wr),

        .stall_if(stall_if),
        .stall_pd(stall_pd),
        .stall_id(stall_id),
        .stall_ex(stall_ex),
        .stall_mem(stall_mem),

        .rst_n(rst_n),

        .clk(clk)
    );

endmodule
