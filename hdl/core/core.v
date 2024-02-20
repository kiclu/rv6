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

module rv6_core #(parameter HART_ID = 0) (
    // data bus signals
    output           [63:0] c_addr,
    output                  c_ext,

    input  [`CMEM_LINE-1:0] c_rdata,
    output                  c_rd,
    input                   c_dv,

    output           [63:0] c_wdata,
    output           [ 1:0] c_len,
    output                  c_wr,

    // interrupt signals
    input                   c_irq_me,
    input                   c_irq_mt,
    input                   c_irq_ms,

    input                   c_irq_se,
    input                   c_irq_st,
    input                   c_irq_ss,

    // cache invalidation signals
    input            [63:0] c_inv_addr,
    input                   c_inv,

    // atomic operation signals
    output                  c_amo_req,
    input                   c_amo_ack,

    // control signals
    input                   c_stall,
    input                   c_rst_n,
    input                   c_clk
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
    pc u_pc (
        .pc             (pc             ),
        .trap_taken     (trap_taken     ),
        .trap_addr      (trap_addr      ),
        .jalr_taken     (jalr_taken     ),
        .jalr_addr      (jalr_addr      ),
        .pr_miss        (pr_miss        ),
        .br_addr        (br_addr        ),
        .jal_taken      (jal_taken      ),
        .jal_addr       (jal_addr       ),
        .pr_taken       (pr_taken       ),
        .pr_offs        (pr_offs        ),
        .c_ins          (c_ins          ),
        .stall          (stall_if       ),
        .rst_n          (c_rst_n        ),
        .clk            (c_clk          )
    );

    // branch prediction unit
    bpu u_bpu (
        .pc             (pc             ),
        .ir             (ir             ),
        .jal_taken      (jal_taken      ),
        .jal_addr       (jal_addr       ),
        .pr_taken       (pr_taken       ),
        .pr_offs        (pr_offs        ),
        .rst_n          (c_rst_n        )
    );

    // instruction memory / L1i cache

    wire [`IMEM_BLK_LEN-1:0] b_addr_i;
    wire [   `IMEM_LINE-1:0] b_data_i;
    wire                     b_rd_i;
    wire                     b_dv_i;
    wire                     fence_i;
    wire                     stall_imem;

    imem u_imem (
        .pc             (pc             ),
        .ir             (ir             ),
        .b_addr_i       (b_addr_i       ),
        .b_data_i       (b_data_i       ),
        .b_rd_i         (b_rd_i         ),
        .b_dv_i         (b_dv_i         ),
        .fence_i        (fence_i        ),
        .stall_imem     (stall_imem     ),
        .rst_n          (c_rst_n        ),
        .clk            (c_clk          )
    );

    reg [31:0] bfp_ir;
    reg [63:0] bfp_pc;
    reg bfp_pr_taken;
    reg bfp_c_ins;

    wire flush_ena = !stall_if || (jalr_taken && fence_i);
    wire flush_pd = !flush_n && flush_ena;

    always @(posedge c_clk, negedge c_rst_n) begin
        if(!c_rst_n) begin
            bfp_ir       <=  `NOP;
            bfp_pc       <= 64'b0;
            bfp_pr_taken <=  1'b0;
            bfp_c_ins    <=  1'b0;
        end
        else begin
            if(flush_pd || t_flush_pd) begin
                bfp_ir       <=  `NOP;
                bfp_pc       <= 64'b0;
                bfp_pr_taken <=  1'b0;
                bfp_c_ins    <=  1'b0;
            end
            else if(!stall_if) begin
                bfp_pc       <= pc;
                bfp_ir       <= ir;
                bfp_pr_taken <= pr_taken;
                bfp_c_ins    <= c_ins;
            end
        end
    end

    /* PD */

    wire [31:0] pd_ir;

    wire stall_pd;

    // instruction predecoder
    pd u_pd (
        .pc_in          (bfp_pc         ),
        .ir_in          (bfp_ir         ),
        .ir_out         (pd_ir          ),
        .amo_req        (c_amo_req      ),
        .amo_ack        (c_amo_ack      ),
        .stall          (stall_pd       ),
        .rst_n          (c_rst_n        ),
        .clk            (c_clk          )
    );

    reg [31:0] bpd_ir;
    reg [63:0] bpd_pc;
    reg bpd_pr_taken;
    reg bpd_c_ins;

    wire flush_id = !flush_n && flush_ena;

    always @(posedge c_clk, negedge c_rst_n) begin
        if(!c_rst_n) begin
            bpd_ir       <=  `NOP;
            bpd_pc       <= 64'b0;
            bpd_pr_taken <=  1'b0;
            bpd_c_ins    <=  1'b0;
        end
        else begin
            if(flush_id || t_flush_id) begin
                bpd_ir       <=  `NOP;
                bpd_pc       <= 64'b0;
                bpd_pr_taken <=  1'b0;
                bpd_c_ins    <=  1'b0;
            end
            else if(!stall_pd) begin
                bpd_ir       <= pd_ir;
                bpd_pc       <= bfp_pc;
                bpd_pr_taken <= bfp_pr_taken;
                bpd_c_ins    <= bfp_c_ins;
            end
        end
    end

    /* ID */

    wire [63:0] rs1_data;
    wire [ 4:0] rs1 = bpd_ir[19:15];

    wire [63:0] rs2_data;
    wire [ 4:0] rs2 = bpd_ir[24:20];

    wire [63:0] rd_data;
    wire [ 4:0] rd;
    wire        we;

    // register file
    regfile u_regfile (
        .rs1_data       (rs1_data       ),
        .rs1            (rs1            ),
        .rs2_data       (rs2_data       ),
        .rs2            (rs2            ),
        .rd_data        (rd_data        ),
        .rd             (rd             ),
        .we             (we             ),
        .rst_n          (c_rst_n        ),
        .clk            (c_clk          )
    );

    wire stall_id;

    // branch alu
    br_alu u_br_alu (
        .pc             (bpd_pc         ),
        .ir             (bpd_ir         ),
        .rs1_data       (rs1_data       ),
        .rs2_data       (rs2_data       ),
        .jalr_taken     (jalr_taken     ),
        .jalr_addr      (jalr_addr      ),
        .pr_miss        (pr_miss        ),
        .br_addr        (br_addr        ),
        .pr_taken       (bpd_pr_taken   ),
        .rst_n          (c_rst_n        ),
        .stall          (stall_id       )
    );

    assign flush_n = c_rst_n && (!pr_miss && !jalr_taken);

    // immediate format mux
    reg [63:0] mux_imm;
    always @(*) begin
        case(bpd_ir[6:0])
            // I-type
            `OP_LOAD, `OP_ALRI, `OP_ALRIW:  mux_imm = {{52{bpd_ir[31]}}, bpd_ir[31:20]};
            // S-type
            `OP_STORE:                      mux_imm = {{52{bpd_ir[31]}}, bpd_ir[31:25], bpd_ir[11:7]};
            // U-type
            `OP_LUI, `OP_AUIPC:             mux_imm = {{32{bpd_ir[31]}}, bpd_ir[31:12], 12'b0};
            // J-type
            `OP_JAL, `OP_JALR:              mux_imm = bpd_c_ins ? 64'h2 : 64'h4;

            default:                        mux_imm = 64'b?;
        endcase
    end

    reg [31:0] bdx_ir;
    reg [63:0] bdx_pc;
    reg [63:0] bdx_rs1_data;
    reg [63:0] bdx_rs2_data;
    reg [63:0] bdx_imm;

    always @(posedge c_clk) begin
        if(!c_rst_n || t_flush_ex) begin
            bdx_ir          <=  `NOP;
            bdx_pc          <= 64'b0;
            bdx_rs1_data    <= 64'b0;
            bdx_rs2_data    <= 64'b0;
            bdx_imm         <= 64'b0;
        end
        else if(!stall_id) begin
            bdx_ir          <= bpd_ir;
            bdx_pc          <= bpd_pc;
            bdx_rs1_data    <= rs1_data;
            bdx_rs2_data    <= rs2_data;
            bdx_imm         <= mux_imm;
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
    assign alu_mx_a[0] = bdx_rs1_data;
    assign alu_mx_a[1] = bdx_pc;
    assign alu_mx_a[2] = mx_a_fw[s_mx_a_fw];
    assign alu_mx_a[3] = bdx_pc;
    wire [1:0] s_alu_mx_a;

    assign s_alu_mx_a[1] = a_fw;
    assign s_alu_mx_a[0] = bdx_ir[6:0] == `OP_JAL || bdx_ir[6:0] == `OP_JALR || bdx_ir[6:0] == `OP_AUIPC;

    wire [63:0] alu_mx_b [0:3];
    assign alu_mx_b[0] = bdx_imm;
    assign alu_mx_b[1] = bdx_rs2_data;
    assign alu_mx_b[2] = bdx_imm;
    assign alu_mx_b[3] = mx_b_fw[s_mx_b_fw];
    wire [1:0] s_alu_mx_b;

    assign s_alu_mx_b[1] = b_fw;
    assign s_alu_mx_b[0] = bdx_ir[6:0] == `OP_ALRR || bdx_ir[6:0] == `OP_ALRRW;

    wire [63:0] alu_out;

    wire [63:0] alu_a  = alu_mx_a[s_alu_mx_a];
    wire [63:0] alu_b  = alu_mx_b[s_alu_mx_b];
    wire [ 6:0] opcode = bdx_ir[6:0];
    wire [ 2:0] op     = bdx_ir[14:12];
    wire        mod    = bdx_ir[30];

    alu u_alu (
        .a              (alu_a          ),
        .b              (alu_b          ),
        .alu_out        (alu_out        ),
        .opcode         (opcode         ),
        .op             (op             ),
        .mod            (mod            )
    );

    reg [31:0] bxm_ir;
    reg [63:0] bxm_pc;
    reg [63:0] bxm_alu_out;
    reg [63:0] bxm_csr_in;
    reg [63:0] bxm_rs2_data;

    wire stall_ex;

    always @(posedge c_clk) begin
        if(!c_rst_n || t_flush_mem) begin
            bxm_ir          <=  `NOP;
            bxm_pc          <= 64'b0;
            bxm_alu_out     <= 64'b0;
            bxm_csr_in      <= 64'b0;
            bxm_rs2_data    <= 64'b0;
        end
        else if(!stall_ex) begin
            bxm_ir          <= bdx_ir;
            bxm_pc          <= bdx_pc;
            bxm_alu_out     <= alu_out;
            bxm_csr_in      <= bdx_ir[14] ? alu_b : alu_a;
            bxm_rs2_data    <= bdx_rs2_data;
        end
    end

    /* MEM */

    wire [63:0] dmem_out;
    wire stall_mem;

    // data memory / L1d cache
    wire op_load   = bxm_ir[6:0] == `OP_LOAD;
    wire op_store  = bxm_ir[6:0] == `OP_STORE;

    wire [`DMEM_BLK_LEN-1:0] b_addr_d;
    wire [   `DMEM_LINE-1:0] b_rdata_d;
    wire                     b_rd_d;
    wire                     b_dv_d;
    wire [`DMEM_BLK_LEN-1:0] b_inv_addr_d;
    wire                     stall_dmem;

    wire [2:0] len = bxm_ir[14:12];

    dmem u_dmem (
        .addr           (bxm_alu_out    ),
        .len            (len            ),
        .rdata          (dmem_out       ),
        .rd             (op_load        ),
        .wdata          (bxm_rs2_data   ),
        .wr             (op_store       ),
        .ld_ma          (dmem_ld_ma     ),
        .st_ma          (dmem_st_ma     ),
        .b_addr_d       (b_addr_d       ),
        .b_rdata_d      (b_rdata_d      ),
        .b_rd_d         (b_rd_d         ),
        .b_dv_d         (b_dv_d         ),
        .b_inv_addr_d   (b_inv_addr_d   ),
        .inv            (c_inv          ),
        .stall_dmem     (stall_dmem     ),
        .stall_mem      (stall_mem      ),
        .rst_n          (c_rst_n        ),
        .clk            (c_clk          )
    );

    wire [63:0] csr_out;
    wire        csr_rd;

    wire csr_addr_invalid;
    wire csr_wr_invalid;
    wire csr_pr_invalid;

    wire instret;

    csr #(.HART_ID(HART_ID)) u_csr (
        .ir             (bxm_ir         ),
        .csr_in         (bxm_csr_in     ),
        .csr_out        (csr_out        ),
        .csr_rd         (csr_rd         ),
        .trap_taken     (trap_taken     ),
        .trap_addr      (trap_addr      ),
        .irq_me         (c_irq_me       ),
        .irq_mt         (c_irq_mt       ),
        .irq_ms         (c_irq_ms       ),
        .irq_se         (c_irq_se       ),
        .irq_st         (c_irq_st       ),
        .irq_ss         (c_irq_ss       ),
        .dmem_ld_ma     (dmem_ld_ma     ),
        .dmem_st_ma     (dmem_st_ma     ),
        .dmem_addr      (bxm_alu_out    ),
        .flush_pd       (t_flush_pd     ),
        .flush_id       (t_flush_id     ),
        .flush_ex       (t_flush_ex     ),
        .flush_mem      (t_flush_mem    ),
        .pc_if          (pc             ),
        .pc_pd          (bfp_pc         ),
        .pc_id          (bpd_pc         ),
        .pc_ex          (bdx_pc         ),
        .pc_mem         (bxm_pc         ),
        .instret        (instret        ),
        .stall          (stall_mem      ),
        .rst_n          (c_rst_n        ),
        .clk            (c_clk          )
    );

    reg [31:0] bmw_ir;
    reg [63:0] bmw_pc;
    reg [63:0] bmw_alu_out;
    reg [63:0] bmw_dmem_out;
    reg [63:0] bmw_csr_out;
    reg        bmw_csr_rd;

    always @(posedge c_clk, negedge c_rst_n) begin
        if(!c_rst_n) begin
            bmw_ir       <=  `NOP;
            bmw_pc       <= 64'b0;
            bmw_alu_out  <= 64'b0;
            bmw_dmem_out <= 64'b0;
            bmw_csr_out  <= 64'b0;
            bmw_csr_rd   <= 1'b0;
        end
        else if(!stall_mem && !t_flush_mem) begin
            bmw_ir       <= bxm_ir;
            bmw_pc       <= bxm_pc;
            bmw_alu_out  <= bxm_alu_out;
            bmw_dmem_out <= dmem_out;
            bmw_csr_out  <= csr_out;
            bmw_csr_rd   <= csr_rd;
        end
    end

    /* WB */

    reg [63:0] wb_mux;

    always @(*) begin
        case(bmw_ir[6:0])
            `OP_LOAD:   wb_mux <= bmw_dmem_out;
            `OP_SYSTEM: wb_mux <= bmw_csr_out;
            default:    wb_mux <= bmw_alu_out;
        endcase
    end

    assign rd       = bmw_ir[11:7];
    assign rd_data  = wb_mux;

    wire stall_wb;
    assign we = (bmw_ir[6:0] != `OP_BRANCH) && (bmw_ir[6:0] != `OP_STORE) && !(bmw_ir[6:0] == `OP_SYSTEM && !bmw_csr_rd) && !stall_wb;

    assign instret = bmw_ir != `NOP && !stall_wb;

    /* WB FORWARD REGISTER */

    reg [63:0] wb_fw;
    always @(posedge c_clk) if(!stall_wb) wb_fw <= wb_mux;

    /* FORWARDING MUX */

    assign mx_a_fw[0] = bxm_alu_out;
    assign mx_a_fw[1] = bmw_alu_out;
    assign mx_a_fw[2] = wb_fw;

    assign mx_b_fw[0] = bxm_alu_out;
    assign mx_b_fw[1] = bmw_alu_out;
    assign mx_b_fw[2] = wb_fw;

    /* L2 CACHE */

    wire [63:0] b_addr_w    = bxm_alu_out;
    wire [63:0] b_wdata_w   = bxm_rs2_data;
    wire [ 1:0] b_len_w     = len;
    wire        b_wr_w      = op_store;

    wire [`CMEM_BLK_LEN-1:0] b_addr_c;
    wire [   `CMEM_LINE-1:0] b_rdata_c;
    wire                     b_rd_c;
    wire                     b_dv_c;

    wire [`CMEM_BLK_LEN-1:0] b_inv_addr_c;

    cmem u_cmem (
        .b_addr_w       (b_addr_w       ),
        .b_wdata_w      (b_wdata_w      ),
        .b_len_w        (b_len_w        ),
        .b_wr_w         (b_wr_w         ),
        .b_addr_i       (b_addr_i       ),
        .b_data_i       (b_data_i       ),
        .b_rd_i         (b_rd_i         ),
        .b_dv_i         (b_dv_i         ),
        .b_addr_d       (b_addr_d       ),
        .b_rdata_d      (b_rdata_d      ),
        .b_rd_d         (b_rd_d         ),
        .b_dv_d         (b_dv_d         ),
        .b_addr_c       (b_addr_c       ),
        .b_rdata_c      (b_rdata_c      ),
        .b_rd_c         (b_rd_c         ),
        .b_dv_c         (b_dv_c         ),
        .b_inv_addr_c   (b_inv_addr_c   ),
        .inv            (c_inv          ),
        .rst_n          (c_rst_n        ),
        .clk            (c_clk          )
    );

    /* CACHE INVALIDATION */

    assign b_inv_addr_d = c_inv_addr[63:`DMEM_OFFS_LEN];
    assign b_inv_addr_c = c_inv_addr[63:`CMEM_OFFS_LEN];

    /* DATA BUS ARBITER */

    dba u_dba (
        .b_addr_w       (b_addr_w       ),
        .b_wdata_w      (b_wdata_w      ),
        .b_len_w        (b_len_w        ),
        .b_wr_w         (b_wr_w         ),
        .b_addr_c       (b_addr_c       ),
        .b_rdata_c      (b_rdata_c      ),
        .b_rd_c         (b_rd_c         ),
        .b_dv_c         (b_dv_c         ),
        .c_addr         (c_addr         ),
        .c_ext          (c_ext          ),
        .c_rdata        (c_rdata        ),
        .c_rd           (c_rd           ),
        .c_dv           (c_dv           ),
        .c_wdata        (c_wdata        ),
        .c_len          (c_len          ),
        .c_wr           (c_wr           )
    );

    /* CONTROL UNIT */

    cu u_cu (
        .ir_if          (ir             ),
        .ir_id          (bpd_ir         ),
        .ir_ex          (bdx_ir         ),
        .ir_mem         (bxm_ir         ),
        .ir_wb          (bmw_ir         ),
        .stall_if       (stall_if       ),
        .stall_pd       (stall_pd       ),
        .stall_id       (stall_id       ),
        .stall_ex       (stall_ex       ),
        .stall_mem      (stall_mem      ),
        .stall_wb       (stall_wb       ),
        .c_stall        (c_stall        ),
        .stall_imem     (stall_imem     ),
        .stall_dmem     (stall_dmem     ),
        .fence_i        (fence_i        ),
        .amo_req        (c_amo_req      ),
        .amo_ack        (c_amo_ack      ),
        .s_mx_a_fw      (s_mx_a_fw      ),
        .a_fw           (a_fw           ),
        .s_mx_b_fw      (s_mx_b_fw      ),
        .b_fw           (b_fw           ),
        .rst_n          (c_rst_n        ),
        .clk            (c_clk          )
    );

endmodule
