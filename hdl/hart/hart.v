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

`include "../config.v"

module hart #(parameter HART_ID = 0) (
    output           [63:0] h_addr,

    input  [`hmem_line-1:0] h_data_in,
    output                  h_rd,
    input                   h_dv,

    output [`hmem_line-1:0] h_data_out,
    output                  h_wr,

    input            [63:0] h_inv_addr,
    input                   h_inv,

    output                  h_amo_req,
    input                   h_amo_ack,

    input                   h_rst_n,

    input                   h_clk
);

    // pipeline flush
    wire flush_n;

    wire t_flush_pd;
    wire t_flush_id;
    wire t_flush_ex;
    wire t_flush_mem;

    // exception signals
    wire dmem_ld_ma;
    wire dmem_st_ma;

    /* IF */

    wire [63:0] pc;
    wire [31:0] ir;

    wire [63:0] trap_addr;
    wire [63:0] jalr_addr;
    wire [63:0] br_addr;
    wire [63:0] jal_addr;
    wire [12:0] pr_offs;

    wire trap_taken;
    wire jalr_taken;
    wire jal_taken;
    wire pr_taken;

    wire c_ins = ir[1:0] != 2'b11;

    wire pr_miss;

    wire stall_if;

    // program counter
    pc u_pc(
        .pc(pc),

        .trap_taken(trap_taken),
        .trap_addr(trap_addr),

        .jalr_taken(jalr_taken),
        .jalr_addr(jalr_addr),

        .pr_miss(pr_miss),
        .br_addr(br_addr),

        .jal_taken(jal_taken),
        .jal_addr(jal_addr),

        .pr_taken(pr_taken),
        .pr_offs(pr_offs),

        .c_ins(c_ins),

        .stall(stall_if),

        .rst_n(h_rst_n),

        .clk(h_clk)
    );

    // branch prediction unit
    bpu u_bpu(
        .pc(pc),
        .ir(ir),

        .jal_taken(jal_taken),
        .jal_addr(jal_addr),
        .pr_taken(pr_taken),
        .pr_offs(pr_offs),

        .rst_n(h_rst_n)
    );

    // instruction memory / L1i cache

    wire [63:0] b_addr_i;
    wire [`imem_line-1:0] b_data_i;
    wire b_rd_i;
    wire b_dv_i;

    imem u_imem(
        .pc(pc),
        .ir(ir),

        .b_addr(b_addr_i),

        .b_data(b_data_i),
        .b_rd(b_rd_i),
        .b_dv(b_dv_i),

        .stall(stall_if),
        .stall_ima(stall_ima),
        .rst_n(h_rst_n),

        .clk(h_clk)
    );

    reg [63:0] bfp_pc;
    reg [31:0] bfp_ir;

    reg bfp_pr_taken;
    reg bfp_c_ins;

    always @(posedge h_clk) begin
        if(!flush_n || t_flush_pd) begin
            bfp_ir <= 32'h13;
            bfp_pr_taken <= 1'b0;
            bfp_c_ins <= 1'b0;
        end
        else if(!stall_if) begin
            bfp_pc <= pc;
            bfp_ir <= ir;
            bfp_pr_taken <= pr_taken;
            bfp_c_ins <= c_ins;
        end
    end

    /* PD */

    wire [31:0] pd_ir;

    wire stall_pd;

    // instruction predecoder
    pd u_pd(
        .pc_in(bfp_pc),
        .ir_in(bfp_ir),

        .ir_out(pd_ir),

        .amo_req(h_amo_req),
        .amo_ack(h_amo_ack),

        .stall(stall_pd),

        .rst_n(h_rst_n),

        .clk(h_clk)
    );

    reg [63:0] bpd_pc;
    reg [31:0] bpd_ir;

    reg bpd_pr_taken;
    reg bpd_c_ins;

    always @(posedge h_clk) begin
        if(!flush_n || t_flush_id) begin
            bpd_ir <= 32'h13;
            bpd_pr_taken <= 1'b0;
            bpd_c_ins <= 1'b0;
        end
        else if(!stall_pd) begin
            bpd_pc <= bfp_pc;
            bpd_ir <= pd_ir;
            bpd_pr_taken <= bfp_pr_taken;
            bpd_c_ins <= bfp_c_ins;
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
    regfile u_regfile(
        .r1(r1),
        .rs1(rs1),

        .r2(r2),
        .rs2(rs2),

        .d(d),
        .rd(rd),
        .wr(wr),

        .clk(h_clk)
    );

    wire stall_id;

    // branch alu
    br_alu u_br_alu(
        .pc(bpd_pc),
        .ir(bpd_ir),

        .r1(r1),
        .r2(r2),

        .jalr_taken(jalr_taken),
        .jalr_addr(jalr_addr),

        .pr_miss(pr_miss),
        .br_addr(br_addr),

        .pr_taken(bpd_pr_taken),

        .stall(stall_id)
    );

    assign flush_n = h_rst_n && !pr_miss && !jalr_taken;

    // immediate format mux
    wire [63:0] mux_imm [0:4];
    assign mux_imm[0] = {{52{bpd_ir[31]}}, bpd_ir[31:20]};                  // I-type
    assign mux_imm[1] = {{52{bpd_ir[31]}}, bpd_ir[31:25], bpd_ir[11:7]};    // S-type
    assign mux_imm[2] = {{32{bpd_ir[31]}}, bpd_ir[31:12], 12'b0};           // U-type
    assign mux_imm[3] = bpd_c_ins ? 64'h2 : 64'h4;                          // J-type
    assign mux_imm[4] = {59'b0, bpd_ir[19:15]};                             // SYSTEM-IMM
    reg [2:0] s_mux_imm;

    always @(*) begin
        case(bpd_ir[6:0])
            // I-type
            7'b0000011, 7'b0010011: s_mux_imm <= 3'b000;
            // S-type
            7'b0100011:             s_mux_imm <= 3'b001;
            // U-type
            7'b0110111, 7'b0010111: s_mux_imm <= 3'b010;
            // J-type
            7'b1101111, 7'b1100111: s_mux_imm <= 3'b011;
            // SYSTEM
            7'b1110011:             s_mux_imm <= 3'b100;

            default:                s_mux_imm <= 3'b000;
        endcase
    end

    reg [63:0] bdx_pc;
    reg [31:0] bdx_ir;

    reg [63:0] bdx_r1;
    reg [63:0] bdx_r2;

    reg [63:0] bdx_imm;


    always @(posedge h_clk) begin
        if(!h_rst_n || t_flush_ex) bdx_ir <= 32'h13;
        else if(!stall_id) begin
            bdx_pc <= bpd_pc;
            bdx_ir <= bpd_ir;

            bdx_r1 <= r1;
            bdx_r2 <= r2;

            bdx_imm <= mux_imm[s_mux_imm];
        end
    end

    /* EX */

    wire [63:0] mx_a_fw [0:2];
    wire [ 1:0] s_mx_a_fw;
    wire a_fw;

    wire [63:0] mx_b_fw [0:2];
    wire [ 1:0] s_mx_b_fw;
    wire b_fw;

    wire [63:0] alu_mx_a [0:3];
    assign alu_mx_a[0] = bdx_r1;
    assign alu_mx_a[1] = bdx_pc;
    assign alu_mx_a[2] = mx_a_fw[s_mx_a_fw];
    wire [1:0] s_alu_mx_a;

    assign s_alu_mx_a[1] = a_fw;
    assign s_alu_mx_a[0] = bdx_ir[6:0] == 7'b1101111 || bdx_ir[6:0] == 7'b1100111 || bdx_ir[6:0] == 7'b0010111;

    wire [63:0] alu_mx_b [0:3];
    assign alu_mx_b[0] = bdx_imm;
    assign alu_mx_b[1] = bdx_r2;
    assign alu_mx_b[3] = mx_b_fw[s_mx_b_fw];
    wire [1:0] s_alu_mx_b;

    assign s_alu_mx_b[1] = b_fw;
    assign s_alu_mx_b[0] = bdx_ir[6:0] == 7'b0110011 || bdx_ir[6:0] == 7'b0111011;

    wire [63:0] alu_out;

    alu u_alu(
        .a(alu_mx_a[s_alu_mx_a]),
        .b(alu_mx_b[s_alu_mx_b]),
        .alu_out(alu_out),
        .op_ir({bdx_ir[31:27], bdx_ir[14:12], bdx_ir[6:0]})
    );

    reg [63:0] bxm_pc;
    reg [31:0] bxm_ir;

    reg [63:0] bxm_alu_out;
    reg [63:0] bxm_r2;

    wire stall_ex;

    always @(posedge h_clk) begin
        if(!h_rst_n || t_flush_mem) bxm_ir <= 32'h13;
        else if(!stall_ex) begin
            bxm_pc <= bdx_pc;
            bxm_ir <= bdx_ir;

            bxm_alu_out <= alu_out;
            bxm_r2 <= bdx_r2;
        end
    end

    /* MEM */

    wire [63:0] dmem_out;
    wire stall_mem;

    // data memory / L1d cache

    wire [63:0] b_addr_d;
    wire [`dmem_line-1:0] b_data_in_d;
    wire b_rd_d;
    wire b_dv_d;
    wire [`dmem_line-1:0] b_data_out_d;
    wire b_wr_d;

    dmem u_dmem(
        .addr(bxm_alu_out),
        .len(bxm_ir[14:12]),

        .data_out(dmem_out),
        .rd(bxm_ir[6:0] == 7'b0000011),

        .data_in(bxm_r2),
        .wr(bxm_ir[6:0] == 7'b0100011),

        .ld_ma(dmem_ld_ma),
        .st_ma(dmem_st_ma),

        .b_addr_d(b_addr_d),

        .b_data_in_d(b_data_in_d),
        .b_rd_d(b_rd_d),
        .b_dv_d(b_dv_d),

        .b_data_out_d(b_data_out_d),
        .b_wr_d(b_wr_d),

        .inv_addr(h_inv_addr),
        .inv(h_inv),

        .rst_n(h_rst_n),

        .clk(h_clk)
    );

    wire [63:0] csr_out;

    wire csr_addr_invalid;
    wire csr_wr_invalid;
    wire csr_pr_invalid;

    csr #(.HART_ID(HART_ID)) u_csr (
        .ir(bxm_ir),

        .csr_in(bxm_alu_out),
        .csr_out(csr_out),

        .trap_taken(trap_taken),
        .trap_addr(trap_addr),

        .intr_s(1'b0),
        .intr_t(1'b0),
        .intr_e(1'b0),

        .dmem_ld_ma(dmem_ld_ma),
        .dmem_st_ma(dmem_st_ma),

        .dmem_addr(addr),

        .flush_if(t_flush_if),
        .flush_pd(t_flush_pd),
        .flush_id(t_flush_id),
        .flush_ex(t_flush_ex),
        .flush_mem(t_flush_mem),

        .pc_if(pc),
        .pc_pd(bfp_pc),
        .pc_id(bpd_pc),
        .pc_ex(bdx_pc),
        .pc_mem(bxm_pc),

        .stall(stall_mem),

        .rst_n(h_rst_n),

        .clk(h_clk)
    );

    reg [31:0] bmw_ir;

    reg [63:0] bmw_csr_out;
    reg [63:0] bmw_alu_out;
    reg [63:0] bmw_dmem_out;

    always @(posedge h_clk) begin
        if(!h_rst_n) bmw_ir <= 32'h13;
        else if(!stall_mem) begin
            bmw_ir <= bxm_ir;

            bmw_csr_out <= csr_out;
            bmw_alu_out <= bxm_alu_out;
            bmw_dmem_out <= dmem_out;
        end
    end

    /* WB */

    reg [63:0] wb_mux;

    always @(*) begin
        case(bmw_ir[6:0])
            7'b0000011: wb_mux <= bmw_dmem_out;
            7'b1110011: wb_mux <= csr_out;
            default:    wb_mux <= bmw_alu_out;
        endcase
    end

    assign rd = bmw_ir[11:7];
    assign d  = wb_mux;

    wire stall_wb;
    assign wr = (bmw_ir[6:0] != 7'b1100011) && (bmw_ir[6:0] != 7'b0100011);

    /* FORWARDING */

    // wb forward register
    reg [63:0] wb_fw;
    always @(posedge h_clk) if(!stall_wb) wb_fw <= wb_mux;

    assign mx_a_fw[0] = bxm_alu_out;
    assign mx_a_fw[1] = bmw_alu_out;
    assign mx_a_fw[2] = wb_fw;

    assign mx_b_fw[0] = bxm_alu_out;
    assign mx_b_fw[1] = bmw_alu_out;
    assign mx_b_fw[2] = wb_fw;

    /* L2 CACHE */

    hmem u_hmem(
        .b_addr_i(b_addr_i),
        .b_data_i(b_data_i),
        .b_rd_i(b_rd_i),
        .b_dv_i(b_dv_i),

        .b_addr_d(b_addr_d),

        .b_data_in_d(b_data_in_d),
        .b_rd_d(b_rd_d),
        .b_dv_d(b_dv_d),

        .b_data_out_d(b_data_out_d),
        .b_wr_d(b_wr_d),

        .h_addr(h_addr),

        .h_data_in(h_data_in),
        .h_rd(h_rd),
        .h_dv(h_dv),

        .h_data_out(h_data_out),
        .h_wr(h_wr),

        .inv_addr(h_inv_addr),
        .inv(h_inv),

        .rst_n(h_rst_n),

        .clk(h_clk)
    );

    /* CONTROL UNIT */

    cu u_cu(
        .ir_id(bpd_ir),
        .ir_ex(bdx_ir),
        .ir_mem(bxm_ir),
        .ir_wb(bmw_ir),

        .stall_if(stall_if),
        .stall_pd(stall_pd),
        .stall_id(stall_id),
        .stall_ex(stall_ex),
        .stall_mem(stall_mem),
        .stall_wb(stall_wb),

	.stall_ima(stall_ima),

        .amo_req(h_amo_req),
        .amo_ack(h_amo_ack),

        .b_rd_i(b_rd_i),
        .b_rd_d(b_rd_d),

        .s_mx_a_fw(s_mx_a_fw),
        .a_fw(a_fw),

        .s_mx_b_fw(s_mx_b_fw),
        .b_fw(b_fw),

        .rst_n(h_rst_n),

        .clk(h_clk)
    );

endmodule
