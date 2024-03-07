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

// Machine Information Registers
`define MVENDORID           12'hf11
`define MARCHID             12'hf12
`define MIMPID              12'hf13
`define MHARTID             12'hf14
`define MCONFIGPTR          12'hf15

// Machine Trap Setup
`define MSTATUS             12'h300
`define MISA                12'h301
`define MEDELEG             12'h302
`define MIDELEG             12'h303
`define MIE                 12'h304
`define MTVEC               12'h305
`define MCOUNTEREN          12'h306

// Machine Trap Handling
`define MSCRATCH            12'h340
`define MEPC                12'h341
`define MCAUSE              12'h342
`define MTVAL               12'h343
`define MIP                 12'h344

// Machine Configuration
`define MENVCFG             12'h30a
`define MSECCFG             12'h747

// Machine Memory Protection
`define PMPCFG0             12'h3a0
`define PMPCFG2             12'h3a2

`define PMPADDR0            12'h3b0
`define PMPADDR1            12'h3b1
`define PMPADDR2            12'h3b2
`define PMPADDR3            12'h3b3
`define PMPADDR4            12'h3b4
`define PMPADDR5            12'h3b5
`define PMPADDR6            12'h3b6
`define PMPADDR7            12'h3b7
`define PMPADDR8            12'h3b8
`define PMPADDR9            12'h3b9
`define PMPADDR10           12'h3ba
`define PMPADDR11           12'h3bb
`define PMPADDR12           12'h3bc
`define PMPADDR13           12'h3bd
`define PMPADDR14           12'h3be
`define PMPADDR15           12'h3bf

// Machine Counter/Timers
`define MCYCLE              12'hb00
`define MINSTRET            12'hb02
`define MHPMCOUNTER3        12'hb03

// Machine Counter Setup
`define MCOUNTINHIBIT       12'h320
`define MHPMEVENT3          12'h323

// Debug/Trace Registers
`define TSELECT             12'h7a0
`define TDATA1              12'h7a1
`define TDATA2              12'h7a2
`define TDATA3              12'h7a3
`define MCONTEXT            12'h7a8

// Supervisor Trap Setup
`define SSTATUS             12'h100
`define SIE                 12'h104
`define STVEC               12'h105
`define SCOUNTEREN          12'h106

// Supervisor Trap Handling
`define SSCRATCH            12'h140
`define SEPC                12'h141
`define SCAUSE              12'h142
`define STVAL               12'h143
`define SIP                 12'h144

// Supervisor Protection and Translation
`define SATP                12'h180

// Unprivileged Floating-Point CSRs
`define FFLAGS              12'h001
`define FRM                 12'h002
`define FCSR                12'h003

// Unprivileged Counter/Timers
`define CYCLE               12'hc00
`define TIME                12'hc01
`define INSTRET             12'hc02

// MSTATUS Register Fields
`define MSTATUS_SD          csr_mstatus[63]
`define MSTATUS_MBE         csr_mstatus[37]
`define MSTATUS_SBE         csr_mstatus[36]
`define MSTATUS_SXL         csr_mstatus[35:34]
`define MSTATUS_UXL         csr_mstatus[33:32]
`define MSTATUS_TSR         csr_mstatus[22]
`define MSTATUS_TW          csr_mstatus[21]
`define MSTATUS_TVM         csr_mstatus[20]
`define MSTATUS_MXR         csr_mstatus[19]
`define MSTATUS_SUM         csr_mstatus[18]
`define MSTATUS_MPRV        csr_mstatus[17]
`define MSTATUS_XS          csr_mstatus[16:15]
`define MSTATUS_FS          csr_mstatus[14:13]
`define MSTATUS_MPP         csr_mstatus[12:11]
`define MSTATUS_VS          csr_mstatus[10:9]
`define MSTATUS_SPP         csr_mstatus[8]
`define MSTATUS_MPIE        csr_mstatus[7]
`define MSTATUS_UBE         csr_mstatus[6]
`define MSTATUS_SPIE        csr_mstatus[5]
`define MSTATUS_MIE         csr_mstatus[3]
`define MSTATUS_SIE         csr_mstatus[1]

// MIDELEG Register Fields
`define MIDELEG_MEID        csr_mideleg[11]
`define MIDELEG_SEID        csr_mideleg[9]
`define MIDELEG_MTID        csr_mideleg[7]
`define MIDELEG_STID        csr_mideleg[5]
`define MIDELEG_MSID        csr_mideleg[3]
`define MIDELEG_SSID        csr_mideleg[1]

// MIE Register Fields
`define MIE_MEIE            csr_mie[11]
`define MIE_SEIE            csr_mie[9]
`define MIE_MTIE            csr_mie[7]
`define MIE_STIE            csr_mie[5]
`define MIE_MSIE            csr_mie[3]
`define MIE_SSIE            csr_mie[1]

// MIP Register Fields
`define MIP_MEIP            csr_mip[11]
`define MIP_SEIP            csr_mip[9]
`define MIP_MTIP            csr_mip[7]
`define MIP_STIP            csr_mip[5]
`define MIP_MSIP            csr_mip[3]
`define MIP_SSIP            csr_mip[1]

// MCOUNTEREN Register Fields
`define MCOUNTEREN_HPM3     csr_mcounteren[3]
`define MCOUNTEREN_IR       csr_mcounteren[2]
`define MCOUNTEREN_TM       csr_mcounteren[1]
`define MCOUNTEREN_CY       csr_mcounteren[0]

// MCOUNTINHIBIT Register Fields
`define MCOUNTINHIBIT_HPM3  csr_mcountinhibit[3]
`define MCOUNTINHIBIT_IR    csr_mcountinhibit[2]
`define MCOUNTINHIBIT_CY    csr_mcountinhibit[0]

// SSTATUS Register Fields
`define SSTATUS_SD          csr_sstatus[63]
`define SSTATUS_UXL         csr_sstatus[33:32]
`define SSTATUS_MXR         csr_sstatus[19]
`define SSTATUS_SUM         csr_sstatus[18]
`define SSTATUS_XS          csr_sstatus[16:15]
`define SSTATUS_FS          csr_sstatus[14:13]
`define SSTATUS_VS          csr_sstatus[10:9]
`define SSTATUS_SPP         csr_sstatus[8]
`define SSTATUS_UBE         csr_sstatus[6]
`define SSTATUS_SPIE        csr_sstatus[5]
`define SSTATUS_SIE         csr_sstatus[1]

// SIE Register Fields
`define SIE_SEIE            csr_sie[9]
`define SIE_STIE            csr_sie[5]
`define SIE_SSIE            csr_sie[1]

// SIP Register Fields
`define SIP_SEIP            csr_sip[9]
`define SIP_STIP            csr_sip[5]
`define SIP_SSIP            csr_sip[1]

// SCOUNTEREN Register Fields
`define SCOUNTEREN_HPM3     csr_scounteren[3]
`define SCOUNTEREN_IR       csr_scounteren[2]
`define SCOUNTEREN_TM       csr_scounteren[1]
`define SCOUNTEREN_CY       csr_scounteren[0]

// Zicsr instructions
`define CSR_RW              3'b001
`define CSR_RS              3'b010
`define CSR_RC              3'b011
`define CSR_RWI             3'b101
`define CSR_RSI             3'b110
`define CSR_RCI             3'b111

`define OP_SRET             32'h10200073
`define OP_MRET             32'h30200073

`define FLUSH_PD            4'b1000
`define FLUSH_ID            4'b1100
`define FLUSH_EX            4'b1110
`define FLUSH_MEM           4'b1111

module csr #(parameter HART_ID = 0) (
    output reg [ 1:0] priv,
    input      [31:0] ir,
    input      [63:0] pc,

    // CSR signals
    input      [63:0] csr_in,
    output reg [63:0] csr_out,
    output            csr_rd,
    output            csr_ii,

    // trap signals
    output reg [63:0] t_addr,
    output            t_taken,
    output            t_flush,

    // interrupt signals
    input             irq_me,
    input             irq_mt,
    input             irq_ms,
    input             irq_se,
    input             irq_st,
    input             irq_ss,

    // exception signals
    input             exc,
    input      [63:0] exc_cause,
    input      [63:0] exc_val,

    // PMP signals
    output     [63:0] pmpcfg0,
    output     [63:0] pmpcfg2,

    output     [63:0] pmpaddr0,
    output     [63:0] pmpaddr1,
    output     [63:0] pmpaddr2,
    output     [63:0] pmpaddr3,
    output     [63:0] pmpaddr4,
    output     [63:0] pmpaddr5,
    output     [63:0] pmpaddr6,
    output     [63:0] pmpaddr7,
    output     [63:0] pmpaddr8,
    output     [63:0] pmpaddr9,
    output     [63:0] pmpaddr10,
    output     [63:0] pmpaddr11,
    output     [63:0] pmpaddr12,
    output     [63:0] pmpaddr13,
    output     [63:0] pmpaddr14,
    output     [63:0] pmpaddr15,

    input             instret,
    input             stall,
    input             rst_n,
    input             clk
);

    wire [11:0] csr_addr = ir[31:20];

    /* ZICSR */

    wire csr_wr;

    wire csr_rw  = ir[14:12] == `CSR_RW  && ir[6:0] == `OP_SYSTEM;
    wire csr_rwi = ir[14:12] == `CSR_RWI && ir[6:0] == `OP_SYSTEM;
    wire csr_rs  = ir[14:12] == `CSR_RS  && ir[6:0] == `OP_SYSTEM;
    wire csr_rsi = ir[14:12] == `CSR_RSI && ir[6:0] == `OP_SYSTEM;
    wire csr_rc  = ir[14:12] == `CSR_RC  && ir[6:0] == `OP_SYSTEM;
    wire csr_rci = ir[14:12] == `CSR_RCI && ir[6:0] == `OP_SYSTEM;
    wire csr_op = csr_rw || csr_rwi || csr_rs || csr_rsi || csr_rc || csr_rci;

    wire rd = csr_op && !((csr_rw || csr_rwi                     ) && ir[11:7]  == 5'b0);
    wire wr = csr_op && !((csr_rs || csr_rsi || csr_rc || csr_rci) && ir[19:15] == 5'b0);

    reg  csr_addr_invalid;
    wire csr_wr_invalid = &csr_addr[11:10] && wr;
    wire csr_pr_invalid = priv < csr_addr[9:8] && (rd || wr);

    wire rd_valid = rd && !csr_addr_invalid && !csr_pr_invalid;
    wire wr_valid = wr && !csr_addr_invalid && !csr_pr_invalid && !csr_wr_invalid;

    assign csr_rd = rd_valid;
    assign csr_wr = wr_valid && !stall;

    /* TRAP CONTROL SIGNALS */

    reg [63:0] tcause;
    reg [63:0] tcause_pc;
    reg [63:0] tval;

    reg m_trap;
    reg s_trap;
    wire trap = m_trap || s_trap;

    wire mret = ir == `OP_MRET;
    wire sret = ir == `OP_SRET;
    wire tret = mret || sret;

    /* CSR REGISTERS */

    reg [63:0] ncsr;

    /* MISA */

    reg [63:0] csr_misa;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_misa <= 64'h8000000000141105;
        else if(csr_wr && csr_addr == `MISA) csr_misa <= ncsr;
    end

    /* MVENDORID */

    wire [63:0] csr_mvendorid = 64'h0;

    /* MARCHID */

    wire [63:0] csr_marchid   = 64'h27;

    /* MIMPID */

    wire [63:0] csr_mimpid    = 64'h0;

    /* MHARTID */

    wire [63:0] csr_mhartid   = HART_ID;

    /* MSTATUS */

    `define SSTATUS_MASK 64'h7ffffffcfff2189d

    reg [63:0] csr_mstatus;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mstatus <= 64'h0000000a00001800;
        else if(trap) begin
            if(m_trap) begin
                `MSTATUS_MIE  <= 1'b0;
                `MSTATUS_MPIE <= `MSTATUS_MIE;
                `MSTATUS_MPP  <= priv;
            end
            else begin
                `MSTATUS_SIE  <= 1'b0;
                `MSTATUS_SPIE <= `MSTATUS_SIE;
                `MSTATUS_SPP  <= priv[0];
            end
        end
        else if(tret) begin
            if(mret) begin
                `MSTATUS_MIE  <= `MSTATUS_MPIE;
                `MSTATUS_MPIE <= 1'b1;
                //`MSTATUS_MPP  <= 2'b00; ???
            end
            else begin
                `MSTATUS_SIE  <= `MSTATUS_SPIE;
                `MSTATUS_SPIE <= 1'b1;
                `MSTATUS_SPP  <= 1'b0;
            end
        end
        else if(csr_wr && csr_addr == `MSTATUS) csr_mstatus <= ncsr;
        else if(csr_wr && csr_addr == `SSTATUS) csr_mstatus <= (ncsr & `SSTATUS_MASK) | (csr_mstatus & ~`SSTATUS_MASK);
    end

    /* MTVEC */

    reg [63:0] csr_mtvec;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mtvec <= 64'h0;
        else if(csr_wr && csr_addr == `MTVEC) csr_mtvec <= ncsr;
    end

    /* MEDELEG */

    reg [63:0] csr_medeleg;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_medeleg <= 64'h0;
        else if(csr_wr && csr_addr == `MEDELEG) csr_medeleg <= ncsr;
    end

    /* MIDELEG */

    reg [63:0] csr_mideleg;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mideleg <= 64'h0;
        else if(csr_wr && csr_addr == `MIDELEG) csr_mideleg <= ncsr;
    end

    /* MIE */

    reg [63:0] csr_mie;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mie <= 64'h0;
        else if(csr_wr && csr_addr == `MIE) csr_mie <= ncsr;
    end

    /* MIP */

    reg [63:0] csr_mip;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mip <= 64'h0;
        else if(csr_wr && csr_addr == `MIP) csr_mip <= ncsr;
    end

    /* MCYCLE */

    reg [63:0] csr_mcycle;
    wire mcountinhibit_cy;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mcycle <= 64'h0;
        else if(csr_wr && csr_addr == `MCYCLE) csr_mcycle <= ncsr;
        else if(!mcountinhibit_cy) csr_mcycle <= csr_mcycle + 1;
    end

    /* MINSTRET */

    reg [63:0] csr_minstret;
    wire mcountinhibit_ir;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_minstret <= 64'h0;
        else if(csr_wr && csr_addr == `MINSTRET) csr_minstret <= ncsr;
        else if(!mcountinhibit_ir && instret) csr_minstret <= csr_minstret + 1;
    end

    /* MHPMCOUNTER */

    // TODO

    /* MCOUNTEREN */

    reg [63:0] csr_mcounteren;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mcounteren <= 64'h0;
        else if(csr_wr && csr_addr == `MCOUNTEREN) csr_mcounteren <= ncsr;
    end

    /* MCOUNTINHIBIT */

    reg [63:0] csr_mcountinhibit;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mcountinhibit <= 64'h0;
        else if(csr_wr && csr_addr == `MCOUNTINHIBIT) csr_mcountinhibit <= ncsr;
    end

    assign mcountinhibit_cy = `MCOUNTINHIBIT_CY;
    assign mcountinhibit_ir = `MCOUNTINHIBIT_IR;

    /* MSCRATCH */

    reg [63:0] csr_mscratch;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mscratch <= 64'h0;
        else if(csr_wr && csr_addr == `MSCRATCH) csr_mscratch <= ncsr;
    end

    /* MEPC */

    reg [63:0] csr_mepc;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mepc <= 64'h0;
        else if(m_trap) csr_mepc <= pc;
        else if(csr_wr && csr_addr == `MEPC) csr_mepc <= ncsr;
    end

    /* MCAUSE */

    reg [63:0] csr_mcause;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mcause <= 64'h0;
        else if(m_trap) csr_mcause <= tcause;
        else if(csr_wr && csr_addr == `MCAUSE) csr_mcause <= ncsr;
    end

    /* MTVAL */

    reg [63:0] csr_mtval;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mtval <= 64'h0;
        else if(m_trap) csr_mtval <= tval;
        else if(csr_wr && csr_addr == `MTVAL) csr_mtval <= ncsr;
    end

    /* MCONFIGPTR */

    reg [63:0] csr_mconfigptr;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mconfigptr <= 64'h0;
        else if(csr_wr && csr_addr == `MCONFIGPTR) csr_mconfigptr <= ncsr;
    end

    /* MENVCFG */

    reg [63:0] csr_menvcfg;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_menvcfg <= 64'h0;
        else if(csr_wr && csr_addr == `MENVCFG) csr_menvcfg <= ncsr;
    end

    /* MSECCFG */

    reg [63:0] csr_mseccfg;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mseccfg <= 64'h0;
        else if(csr_wr && csr_addr == `MSECCFG) csr_mseccfg <= ncsr;
    end

    /* PMPCFG */

    reg [63:0] csr_pmpcfg0;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpcfg0 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPCFG0) csr_pmpcfg0 <= ncsr;
    end

    reg [63:0] csr_pmpcfg2;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpcfg2 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPCFG2) csr_pmpcfg2 <= ncsr;
    end

    /* PMPADDR */

    reg [63:0] csr_pmpaddr0;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr0 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR0) csr_pmpaddr0 <= ncsr;
    end

    reg [63:0] csr_pmpaddr1;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr1 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR1) csr_pmpaddr1 <= ncsr;
    end

    reg [63:0] csr_pmpaddr2;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr2 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR2) csr_pmpaddr2 <= ncsr;
    end

    reg [63:0] csr_pmpaddr3;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr3 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR3) csr_pmpaddr3 <= ncsr;
    end

    reg [63:0] csr_pmpaddr4;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr4 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR4) csr_pmpaddr4 <= ncsr;
    end

    reg [63:0] csr_pmpaddr5;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr5 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR5) csr_pmpaddr5 <= ncsr;
    end

    reg [63:0] csr_pmpaddr6;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr6 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR6) csr_pmpaddr6 <= ncsr;
    end

    reg [63:0] csr_pmpaddr7;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr7 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR7) csr_pmpaddr7 <= ncsr;
    end

    reg [63:0] csr_pmpaddr8;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr8 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR8) csr_pmpaddr8 <= ncsr;
    end

    reg [63:0] csr_pmpaddr9;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr9 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR9) csr_pmpaddr9 <= ncsr;
    end

    reg [63:0] csr_pmpaddr10;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr10 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR10) csr_pmpaddr10 <= ncsr;
    end

    reg [63:0] csr_pmpaddr11;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr11 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR11) csr_pmpaddr11 <= ncsr;
    end

    reg [63:0] csr_pmpaddr12;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr12 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR12) csr_pmpaddr12 <= ncsr;
    end

    reg [63:0] csr_pmpaddr13;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr13 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR13) csr_pmpaddr13 <= ncsr;
    end

    reg [63:0] csr_pmpaddr14;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr14 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR14) csr_pmpaddr14 <= ncsr;
    end

    reg [63:0] csr_pmpaddr15;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr15 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR15) csr_pmpaddr15 <= ncsr;
    end

    /* TSELECT */

    reg [63:0] csr_tselect;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_tselect <= 64'h0;
        else if(csr_wr && csr_addr == `TSELECT) csr_tselect <= ncsr;
    end

    /* TDATA1 */

    reg [63:0] csr_tdata1;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_tdata1 <= 64'h0;
        else if(csr_wr && csr_addr == `TDATA1) csr_tdata1 <= ncsr;
    end

    /* TDATA2 */

    reg [63:0] csr_tdata2;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_tdata2 <= 64'h0;
        else if(csr_wr && csr_addr == `TDATA2) csr_tdata2 <= ncsr;
    end

    /* TDATA3 */

    reg [63:0] csr_tdata3;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_tdata3 <= 64'h0;
        else if(csr_wr && csr_addr == `TDATA3) csr_tdata3 <= ncsr;
    end

    /* MCONTEXT */

    reg [63:0] csr_mcontext;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mcontext <= 64'h0;
        else if(csr_wr && csr_addr == `MCONTEXT) csr_mcontext <= ncsr;
    end

    /* SSTATUS */

    wire [63:0] csr_sstatus = csr_mstatus;

    /* STVEC */

    reg [63:0] csr_stvec;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_stvec <= 64'h0;
        else if(csr_wr && csr_addr == `STVEC) csr_stvec <= ncsr;
    end

    /* SIE */

    reg [63:0] csr_sie;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_sie <= 64'h0;
        else if(csr_wr && csr_addr == `SIE) csr_sie <= ncsr;
    end

    /* SIP */

    reg [63:0] csr_sip;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_sip <= 64'h0;
        else if(csr_wr && csr_addr == `SIP) csr_sip <= ncsr;
    end

    /* SCOUNTEREN */

    reg [63:0] csr_scounteren;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_scounteren <= 64'h0;
        else if(csr_wr && csr_addr == `SCOUNTEREN) csr_scounteren <= ncsr;
    end

    /* SSCRATCH */

    reg [63:0] csr_sscratch;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_sscratch <= 64'h0;
        else if(csr_wr && csr_addr == `SSCRATCH) csr_sscratch <= ncsr;
    end

    /* SEPC */

    reg [63:0] csr_sepc;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_sepc <= 64'h0;
        else if(s_trap) csr_sepc <= pc;
        else if(csr_wr && csr_addr == `SEPC) csr_sepc <= ncsr;
    end

    /* SCAUSE */

    reg [63:0] csr_scause;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_scause <= 64'h0;
        else if(s_trap) csr_scause <= tcause;
        else if(csr_wr && csr_addr == `SCAUSE) csr_scause <= ncsr;
    end

    /* STVAL */

    reg [63:0] csr_stval;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_stval <= 64'h0;
        else if(s_trap) csr_stval <= tval;
        else if(csr_wr && csr_addr == `STVAL) csr_stval <= ncsr;
    end

    /* SENVCFG */

    // TODO

    /* SATP */

    reg [63:0] csr_satp;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_satp <= 64'h0;
        else if(csr_wr && csr_addr == `SATP) csr_satp <= ncsr;
    end

    /* CYCLE */

    wire [63:0] csr_cycle = csr_mcycle;
    reg csr_cycle_access_exc;

    always @(*) begin
        csr_cycle_access_exc = rd_valid && wr_valid && csr_addr == `CYCLE;
        case(priv)
            2'b11: csr_cycle_access_exc = 0;
            2'b01: csr_cycle_access_exc = csr_cycle_access_exc && !`MCOUNTEREN_CY;
            2'b00: csr_cycle_access_exc = csr_cycle_access_exc && (!`SCOUNTEREN_CY || !`MCOUNTEREN_CY);
        endcase
    end

    /* TIME */

    // wire [63:0] csr_time = mtime;
    // TODO: implement mtime in plic

    wire [63:0] csr_time = 0;
    reg csr_time_access_exc;

    always @(*) begin
        csr_time_access_exc = rd_valid && wr_valid && csr_addr == `TIME;
        case(priv)
            2'b11: csr_time_access_exc = 0;
            2'b01: csr_time_access_exc = csr_time_access_exc && !`MCOUNTEREN_TM;
            2'b00: csr_time_access_exc = csr_time_access_exc && (!`SCOUNTEREN_TM || !`MCOUNTEREN_TM);
        endcase
    end

    /* INSTRET */

    wire [63:0] csr_instret = csr_minstret;
    reg csr_instret_access_exc;

    always @(*) begin
        csr_instret_access_exc = rd_valid && wr_valid && csr_addr == `INSTRET;
        case(priv)
            2'b11: csr_instret_access_exc = 0;
            2'b01: csr_instret_access_exc = csr_instret_access_exc && !`MCOUNTEREN_IR;
            2'b00: csr_instret_access_exc = csr_instret_access_exc && (!`SCOUNTEREN_IR || !`MCOUNTEREN_IR);
        endcase
    end

    /* PRIVILEGE LEVEL */

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) priv <= 2'b11;
        else begin
            if(trap) priv <= m_trap ? 2'b11 : 2'b01;
            if(tret) priv <= mret ? `MSTATUS_MPP : {1'b0, `SSTATUS_SPP};
        end
    end

    /* TRAP ENTRY / RETURN */

    assign csr_ii = csr_addr_invalid || csr_wr_invalid || csr_pr_invalid || csr_cycle_access_exc ||  csr_time_access_exc || csr_instret_access_exc;

    wire [63:0] stvec_offs = (csr_stvec[1:0] == 2'b01 && !tcause[63]) ? (tcause << 2) : 64'b0;
    wire [63:0] mtvec_offs = (csr_mtvec[1:0] == 2'b01 && !tcause[63]) ? (tcause << 2) : 64'b0;

    always @(*) begin
        if(trap) t_addr = m_trap ? {csr_mtvec[63:2], 2'b00} + mtvec_offs : {csr_stvec[63:2], 2'b00} + stvec_offs;
        else     t_addr = mret ? csr_mepc : csr_sepc;
    end

    assign t_taken = trap || tret;

    /* TRAP CAUSE */

    always @(*) begin
        tcause = exc_cause;
    end

    /* TRAP VAL */

    always @(*) begin
        tval = exc_val;
    end

    /* TRAP DELEGATION */

    always @(*) begin
        s_trap = 0;
        m_trap = 0;

        if(exc) begin
            m_trap = !csr_medeleg[tcause] || priv == 2'b11;
            s_trap =  csr_medeleg[tcause] && priv != 2'b11;
        end
    end

    /* PIPELINE FLUSH */

    assign t_flush = t_taken;

    /* WPRI MASK */

    reg [63:0] wp_mask;
    always @(*) begin
        case(csr_addr)
            `MSTATUS: wp_mask = 64'h7fffffcfff800015;
            `SSTATUS: wp_mask = 64'h7ffffffffff2189d;
            default:  wp_mask = 64'h0000000000000000;
        endcase
        if(!rd_valid && !wr_valid) wp_mask = 64'hffffffffffffffff;
    end

    reg [63:0] ri_mask;
    always @(*) begin
        case(csr_addr)
            `MSTATUS: ri_mask = 64'h7fffffc0ff800015;
            `SSTATUS: ri_mask = 64'h7ffffffcfff2189d;
            default:  ri_mask = 64'h0000000000000000;
        endcase
        if(!rd_valid && !wr_valid) ri_mask = 64'hffffffffffffffff;
    end

    /* NCSR */

    always @(*) begin
        case(ir[14:12])
            `CSR_RW:  ncsr =  csr_in;
            `CSR_RS:  ncsr =  csr_in | csr_out;
            `CSR_RC:  ncsr = ~csr_in & csr_out;
            `CSR_RWI: ncsr = {59'b0,  ir[19:15]};
            `CSR_RSI: ncsr = {59'b0,  ir[19:15]} | csr_out;
            `CSR_RCI: ncsr = {59'b0, ~ir[19:15]} & csr_out;
            default:  ncsr = 64'h0;
        endcase
        ncsr = ncsr & ~wp_mask | csr_out & wp_mask;
    end

    /* OUTPUT MUX */

    always @(*) begin
        csr_addr_invalid = 0;
        csr_out = 64'h0;
        case(csr_addr)
            `MISA:              csr_out = csr_misa;
            `MVENDORID:         csr_out = csr_mvendorid;
            `MARCHID:           csr_out = csr_marchid;
            `MIMPID:            csr_out = csr_mimpid;
            `MHARTID:           csr_out = csr_mhartid;
            `MSTATUS:           csr_out = csr_mstatus;
            `MTVEC:             csr_out = csr_mtvec;
            `MEDELEG:           csr_out = csr_medeleg;
            `MIDELEG:           csr_out = csr_mideleg;
            `MIE:               csr_out = csr_mie;
            `MIP:               csr_out = csr_mip;
            `MCYCLE:            csr_out = csr_mcycle;
            `MINSTRET:          csr_out = csr_minstret;
            // `MHPMCOUNTER:
            `MCOUNTEREN:        csr_out = csr_mcounteren;
            `MCOUNTINHIBIT:     csr_out = csr_mcountinhibit;
            `MSCRATCH:          csr_out = csr_mscratch;
            `MEPC:              csr_out = csr_mepc;
            `MCAUSE:            csr_out = csr_mcause;
            `MTVAL:             csr_out = csr_mtval;
            `MCONFIGPTR:        csr_out = csr_mconfigptr;
            `MENVCFG:           csr_out = csr_menvcfg;
            `MSECCFG:           csr_out = csr_mseccfg;
            `PMPCFG0:           csr_out = csr_pmpcfg0;
            `PMPCFG2:           csr_out = csr_pmpcfg2;
            `PMPADDR0:          csr_out = csr_pmpaddr0;
            `PMPADDR1:          csr_out = csr_pmpaddr1;
            `PMPADDR2:          csr_out = csr_pmpaddr2;
            `PMPADDR3:          csr_out = csr_pmpaddr3;
            `PMPADDR4:          csr_out = csr_pmpaddr4;
            `PMPADDR5:          csr_out = csr_pmpaddr5;
            `PMPADDR6:          csr_out = csr_pmpaddr6;
            `PMPADDR7:          csr_out = csr_pmpaddr7;
            `PMPADDR8:          csr_out = csr_pmpaddr8;
            `PMPADDR9:          csr_out = csr_pmpaddr9;
            `PMPADDR10:         csr_out = csr_pmpaddr10;
            `PMPADDR11:         csr_out = csr_pmpaddr11;
            `PMPADDR12:         csr_out = csr_pmpaddr12;
            `PMPADDR13:         csr_out = csr_pmpaddr13;
            `PMPADDR14:         csr_out = csr_pmpaddr14;
            `PMPADDR15:         csr_out = csr_pmpaddr15;

            `TSELECT:           csr_out = csr_tselect;
            `TDATA1:            csr_out = csr_tdata1;
            `TDATA2:            csr_out = csr_tdata2;
            `TDATA2:            csr_out = csr_tdata3;
            `MCONTEXT:          csr_out = csr_mcontext;

            `SSTATUS:           csr_out = csr_sstatus;
            `STVEC:             csr_out = csr_stvec;
            `SIE:               csr_out = csr_sie;
            `SIP:               csr_out = csr_sip;
            `SCOUNTEREN:        csr_out = csr_scounteren;
            `SSCRATCH:          csr_out = csr_sscratch;
            `SEPC:              csr_out = csr_sepc;
            `SCAUSE:            csr_out = csr_scause;
            `STVAL:             csr_out = csr_stval;
            // `SENVCFG:
            `SATP:              csr_out = csr_satp;

            `CYCLE:             csr_out = csr_cycle;
            `TIME:              csr_out = csr_time;
            `INSTRET:           csr_out = csr_instret;

            default:            csr_addr_invalid = rd || wr;
        endcase
        csr_out = csr_out & ~ri_mask;
    end

    assign pmpcfg0 = csr_pmpcfg0;
    assign pmpcfg2 = csr_pmpcfg2;

    assign pmpaddr0  = csr_pmpaddr0;
    assign pmpaddr1  = csr_pmpaddr1;
    assign pmpaddr2  = csr_pmpaddr2;
    assign pmpaddr3  = csr_pmpaddr3;
    assign pmpaddr4  = csr_pmpaddr4;
    assign pmpaddr5  = csr_pmpaddr5;
    assign pmpaddr6  = csr_pmpaddr6;
    assign pmpaddr7  = csr_pmpaddr7;
    assign pmpaddr8  = csr_pmpaddr8;
    assign pmpaddr9  = csr_pmpaddr9;
    assign pmpaddr10 = csr_pmpaddr10;
    assign pmpaddr11 = csr_pmpaddr11;
    assign pmpaddr12 = csr_pmpaddr12;
    assign pmpaddr13 = csr_pmpaddr13;
    assign pmpaddr14 = csr_pmpaddr14;
    assign pmpaddr15 = csr_pmpaddr15;

endmodule
