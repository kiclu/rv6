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

// machine information registers
`define MVENDORID       12'hf11
`define MARCHID         12'hf12
`define MIMPID          12'hf13
`define MHARTID         12'hf14
`define MCONFIGPTR      12'hf15

// machine trap setup
`define MSTATUS         12'h300
`define MISA            12'h301
`define MEDELEG         12'h302
`define MIDELEG         12'h303
`define MIE             12'h304
`define MTVEC           12'h305
`define MCOUNTEREN      12'h306

// machine trap handling
`define MSCRATCH        12'h340
`define MEPC            12'h341
`define MCAUSE          12'h342
`define MTVAL           12'h343
`define MIP             12'h344

// machine configuration
`define MENVCFG         12'h30a
`define MSECCFG         12'h747

// Machine Memory Protection
`define PMPCFG0         12'h3a0

`define PMPADDR0        12'h3b0

// Machine Counter/Timers
`define MCYCLE          12'hb00
`define MINSTRET        12'hb02
`define MHPMCOUNTER3    12'hb03

// Machine Counter Setup
//`define MCOUNTINHIBIT   12'h

// Debug/Trace Registers
`define TSELECT         12'h7a0
`define TDATA1          12'h7a1
`define TDATA2          12'h7a2
`define TDATA3          12'h7a3
`define MCONTEXT        12'h7a8

// supervisor trap setup
`define SSTATUS         12'h100
`define SIE             12'h104
`define STVEC           12'h105
`define SCOUNTEREN      12'h106

// supervisor trap handling
`define SSCRATCH        12'h140
`define SEPC            12'h141
`define SCAUSE          12'h142
`define STVAL           12'h143
`define SIP             12'h144

// supervisor protection and translation
`define SATP            12'h180

// unprivileged floating-point csrs
`define FFLAGS          12'h001
`define FRM             12'h002
`define FCSR            12'h003

// mstatus register fields
`define MSTATUS_SD      csr_mstatus[63]
`define MSTATUS_MBE     csr_mstatus[37]
`define MSTATUS_SBE     csr_mstatus[36]
`define MSTATUS_SXL     csr_mstatus[35:34]
`define MSTATUS_UXL     csr_mstatus[33:32]
`define MSTATUS_TSR     csr_mstatus[22]
`define MSTATUS_TW      csr_mstatus[21]
`define MSTATUS_TVM     csr_mstatus[20]
`define MSTATUS_MXR     csr_mstatus[19]
`define MSTATUS_SUM     csr_mstatus[18]
`define MSTATUS_MPRV    csr_mstatus[17]
`define MSTATUS_XS      csr_mstatus[16:15]
`define MSTATUS_FS      csr_mstatus[14:13]
`define MSTATUS_MPP     csr_mstatus[12:11]
`define MSTATUS_VS      csr_mstatus[10:9]
`define MSTATUS_SPP     csr_mstatus[8]
`define MSTATUS_MPIE    csr_mstatus[7]
`define MSTATUS_UBE     csr_mstatus[6]
`define MSTATUS_SPIE    csr_mstatus[5]
`define MSTATUS_MIE     csr_mstatus[3]
`define MSTATUS_SIE     csr_mstatus[1]

// Zicsr instructions
`define CSR_RW          3'b001
`define CSR_RS          3'b010
`define CSR_RC          3'b011
`define CSR_RWI         3'b101
`define CSR_RSI         3'b110
`define CSR_RCI         3'b111

`define OP_ECALL        32'h00000073
`define OP_EBREAK       32'h00100073
`define OP_SRET         32'h10200073
`define OP_MRET         32'h30200073

`define FLUSH_PD        4'b1000
`define FLUSH_ID        4'b1100
`define FLUSH_EX        4'b1110
`define FLUSH_MEM       4'b1111

module csr #(parameter HART_ID = 0) (
    input      [31:0] ir,

    input      [63:0] csr_in,
    output reg [63:0] csr_out,
    output            csr_rd,

    // PC signals
    output reg [63:0] trap_addr,
    output            trap_taken,

    // interrupt signals
    input             irq_e,
    input             irq_t,
    input             irq_s,

    // exception signals
    input             dmem_ld_ma,
    input             dmem_st_ma,

    // exception context signals
    input      [63:0] dmem_addr,

    // pipeline flush signals
    output            flush_pd,
    output            flush_id,
    output            flush_ex,
    output            flush_mem,

    input      [63:0] pc_if,
    input      [63:0] pc_pd,
    input      [63:0] pc_id,
    input      [63:0] pc_ex,
    input      [63:0] pc_mem,

    input             instret,
    input             stall,
    input             rst_n,
    input             clk
);

    wire [11:0] csr_addr = ir[31:20];
    reg  [ 1:0] privilege_level;

    wire ecall  = ir == `OP_ECALL;
    wire ebreak = ir == `OP_EBREAK;

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
    wire csr_pr_invalid = privilege_level < csr_addr[9:8] && (rd || wr);

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

    wire [63:0] csr_marchid   = 64'h0000000000000027;

    /* MIMPID */

    wire [63:0] csr_mimpid    = 64'h0;

    /* MHARTID */

    wire [63:0] csr_mhartid   = HART_ID;

    /* MSTATUS */

    reg [63:0] csr_mstatus;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mstatus <= 64'h0000000a00001800;
        else if(trap) begin
            if(m_trap) begin
                `MSTATUS_MIE  <= 1'b0;
                `MSTATUS_MPIE <= `MSTATUS_MIE;
                `MSTATUS_MPP  <= privilege_level;
            end
            else begin
                `MSTATUS_SIE  <= 1'b0;
                `MSTATUS_SPIE <= `MSTATUS_SIE;
                `MSTATUS_SPP  <= privilege_level[0];
            end
        end
        else if(tret) begin
            if(mret) begin
                `MSTATUS_MIE  <= `MSTATUS_MPIE;
                `MSTATUS_MPIE <= 1'b1;
            end
            else begin
                `MSTATUS_SIE  <= `MSTATUS_SPIE;
                `MSTATUS_SPIE <= 1'b1;
            end
        end
        else if(csr_wr && csr_addr == `MSTATUS) csr_mstatus <= ncsr;
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
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_mcycle <= 64'h0;
        else if(csr_wr && csr_addr == `MCYCLE) csr_mcycle <= ncsr;
        else csr_mcycle <= csr_mcycle + 1;
    end

    /* MINSTRET */

    reg [63:0] csr_minstret;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_minstret <= 64'h0;
        else if(csr_wr && csr_addr == `MINSTRET) csr_minstret <= ncsr;
        else if(instret) csr_minstret <= csr_minstret + 1;
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

    // TODO

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
        else if(m_trap) csr_mepc <= tcause_pc;
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

    /* PMPADDR */

    reg [63:0] csr_pmpaddr0;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_pmpaddr0 <= 64'h0;
        else if(csr_wr && csr_addr == `PMPADDR0) csr_pmpaddr0 <= ncsr;
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
    always @(posedge clk) begin
        //if(csr_wr && csr_addr == `SSTATUS) csr_mstatus <= ncsr;
    end

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
        else if(csr_wr && csr_addr == `SEPC) csr_sepc <= ncsr;
    end

    /* SCAUSE */

    reg [63:0] csr_scause;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_scause <= 64'h0;
        else if(csr_wr && csr_addr == `SCAUSE) csr_scause <= ncsr;
    end

    /* STVAL */

    reg [63:0] csr_stval;
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) csr_stval <= 64'h0;
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

    /* PRIVILEGE LEVEL */

    always @(posedge clk, negedge rst_n, negedge rst_n) begin
        if(!rst_n) privilege_level <= 2'b11;
        else begin
            if(trap) privilege_level <= m_trap ? 2'b11 : 2'b01;
            if(tret) privilege_level <= mret ? `MSTATUS_MPP : {1'b0, `MSTATUS_SPP};
        end
    end

    /* PIPELINE FLUSH */

    reg [3:0] flush;
    assign {flush_pd, flush_id, flush_ex, flush_mem} = flush;

    /* TRAP ENTRY / RETURN */

    reg exc;

    wire dmem_ma = dmem_ld_ma || dmem_st_ma;
    wire csr_exc = csr_addr_invalid || csr_wr_invalid || csr_pr_invalid;

    always @(*) begin
        tcause    = 64'd0;
        tcause_pc = 64'h0;
        tval      = 64'h0;
        exc       = 1;
        flush     = 0;

        if(tret) begin
            flush = `FLUSH_MEM;
            exc = 0;
        end
        else if(ebreak) begin
            tcause    = 64'd3;
            tcause_pc = pc_mem;
            flush     = `FLUSH_MEM;
        end
        else if(ecall) begin
            case(privilege_level)
                2'b00: tcause = 64'd8;
                2'b01: tcause = 64'd9;
                2'b11: tcause = 64'd11;
            endcase
            tcause_pc = pc_mem;
            flush     = `FLUSH_MEM;
        end
        else if(dmem_ma) begin
            if(dmem_ld_ma) tcause = 64'd4;
            else           tcause = 64'd6;
            tcause_pc = pc_mem;
            tval      = dmem_addr;
            flush     = `FLUSH_MEM;
        end
        else if(csr_exc) begin
            tcause    = 64'd2;
            tcause_pc = pc_mem;
            flush     = `FLUSH_MEM;
        end
        else exc = 0;
    end

    wire [63:0] stvec_offs = (csr_stvec[1:0] == 2'b01 && !tcause[63]) ? (tcause << 2) : 64'b0;
    wire [63:0] mtvec_offs = (csr_mtvec[1:0] == 2'b01 && !tcause[63]) ? (tcause << 2) : 64'b0;

    always @(*) begin
        if(trap) trap_addr = m_trap ? {csr_mtvec[63:2], 2'b00} + mtvec_offs : {csr_stvec[63:0], 2'b00} + stvec_offs;
        else     trap_addr = mret ? csr_mepc : csr_sepc;
    end

    assign trap_taken = trap || tret;

    /* TRAP DELEGATION */

    always @(*) begin
        s_trap = 0;
        m_trap = 0;

        if(exc) begin
            m_trap = !csr_medeleg[tcause] || privilege_level == 2'b11;
            s_trap =  csr_medeleg[tcause] && privilege_level != 2'b11;
        end
    end

    /* WPRI MASK */

    reg [63:0] wpri_mask;
    always @(*) begin
        case(csr_addr)
            `MSTATUS: wpri_mask = 64'hffffffffffffe655;
            default:  wpri_mask = 64'h0000000000000000;
        endcase
        if(!rd_valid && !wr_valid) wpri_mask = 64'hffffffffffffffff;
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
        ncsr = ncsr & ~wpri_mask | csr_out & wpri_mask;
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
            // `MCOUNTERINHIBIT:   csr_out = csr_mcountinhibit;
            `MSCRATCH:          csr_out = csr_mscratch;
            `MEPC:              csr_out = csr_mepc;
            `MCAUSE:            csr_out = csr_mcause;
            `MTVAL:             csr_out = csr_mtval;
            `MCONFIGPTR:        csr_out = csr_mconfigptr;
            `MENVCFG:           csr_out = csr_menvcfg;
            `MSECCFG:           csr_out = csr_mseccfg;
            `PMPCFG0:           csr_out = csr_pmpcfg0;
            `PMPADDR0:          csr_out = csr_pmpaddr0;
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

            `TSELECT:           csr_out = csr_tselect;
            `TDATA1:            csr_out = csr_tdata1;
            `TDATA2:            csr_out = csr_tdata2;
            `TDATA2:            csr_out = csr_tdata3;
            `MCONTEXT:          csr_out = csr_mcontext;

            default:            csr_addr_invalid = rd || wr;
        endcase
    end

endmodule

/* currently unimplemented registers */


// unprivileged counter/timers
`define CYCLE           12'hc00
`define TIME            12'hc01
`define INSTRET         12'hc02


// machine counter setup
`define MCOUNTINHIBIT   12'hb20
`define MHPMEVENT3      12'hb23

// mideleg register fields
`define MIDELEG_MEID    csr_mideleg[11]
`define MIDELEG_SEID    csr_mideleg[9]
`define MIDELEG_MTID    csr_mideleg[7]
`define MIDELEG_STID    csr_mideleg[5]
`define MIDELEG_MSID    csr_mideleg[3]
`define MIDELEG_SSID    csr_mideleg[1]

// mip register fields
`define MIP_MEIP        csr_mip[11]
`define MIP_SEIP        csr_mip[9]
`define MIP_MTIP        csr_mip[7]
`define MIP_STIP        csr_mip[5]
`define MIP_MSIP        csr_mip[3]
`define MIP_SSIP        csr_mip[1]

// mie register fields
`define MIE_MEIE        csr_mie[11]
`define MIE_SEIE        csr_mie[9]
`define MIE_MTIE        csr_mie[7]
`define MIE_STIE        csr_mie[5]
`define MIE_MSIE        csr_mie[3]
`define MIE_SSIE        csr_mie[1]

// sstatus register fields
`define SSTATUS_SD      csr_mstatus[63]
`define SSTATUS_UXL     csr_mstatus[33:32]
`define SSTATUS_MXR     csr_mstatus[19]
`define SSTATUS_SUM     csr_mstatus[18]
`define SSTATUS_XS      csr_mstatus[16:15]
`define SSTATUS_FS      csr_mstatus[14:13]
`define SSTATUS_VS      csr_mstatus[10:9]
`define SSTATUS_SPP     csr_mstatus[8]
`define SSTATUS_UBE     csr_mstatus[6]
`define SSTATUS_SPIE    csr_mstatus[5]
`define SSTATUS_SIE     csr_mstatus[1]

// sip register fields
`define SIP_SEIP        csr_sip[9]
`define SIP_STIP        csr_sip[5]
`define SIP_SSIP        csr_sip[1]

// sie register fields
`define SIE_SEIE        csr_sie[9]
`define SIE_STIE        csr_sie[5]
`define SIE_SSIE        csr_sie[1]
