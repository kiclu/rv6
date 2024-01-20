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

// supervisor trap setup
`define SSTATUS         12'h100
`define SSTATUS_REG     csr_reg[0]
`define SIE             12'h104
`define SIE_REG         csr_reg[1]
`define STVEC           12'h105
`define STVEC_REG       csr_reg[2]
`define SCOUNTEREN      12'h106
`define SCOUNTEREN_REG  csr_reg[3]

// supervisor trap handling
`define SSCRATCH        12'h140
`define SSCRATCH_REG    csr_reg[4]
`define SEPC            12'h141
`define SEPC_REG        csr_reg[5]
`define SCAUSE          12'h142
`define SCAUSE_REG      csr_reg[6]
`define STVAL           12'h143
`define STVAL_REG       csr_reg[7]
`define SIP             12'h144
`define SIP_REG         csr_reg[8]

// supervisor protection and translation
`define SATP            12'h180
`define SATP_REG        csr_reg[9]

// machine information registers
`define MVENDORID       12'hf11
`define MVENDORID_REG   csr_reg[10]
`define MARCHID         12'hf12
`define MARCHID_REG     csr_reg[11]
`define MIMPID          12'hf13
`define MIMPID_REG      csr_reg[12]
`define MHARTID         12'hf14
`define MHARTID_REG     csr_reg[13]
`define MCONFIGPTR      12'hf15
`define MCONFIGPTR_REG  csr_reg[14]

// machine trap setup
`define MSTATUS         12'h300
`define MSTATUS_REG     csr_reg[0]
`define MISA            12'h301
`define MISA_REG        csr_reg[15]
`define MEDELEG         12'h302
`define MEDELEG_REG     csr_reg[16]
`define MIDELEG         12'h303
`define MIDELEG_REG     csr_reg[17]
`define MIE             12'h304
`define MIE_REG         csr_reg[1]
`define MTVEC           12'h305
`define MTVEC_REG       csr_reg[18]
`define MCOUNTEREN      12'h306
`define MCOUNTEREN_REG  csr_reg[19]

// machine trap handling
`define MSCRATCH        12'h340
`define MSCRATCH_REG    csr_reg[20]
`define MEPC            12'h341
`define MEPC_REG        csr_reg[21]
`define MCAUSE          12'h342
`define MCAUSE_REG      csr_reg[22]
`define MTVAL           12'h343
`define MTVAL_REG       csr_reg[23]
`define MIP             12'h344
`define MIP_REG         csr_reg[8]
`define MTINST          12'h345
`define MTINST_REG      csr_reg[24]

// machine configuration
`define MENVCFG         12'h30a
`define MENVCFG_REG     csr_reg[25]
`define MSECCFG         12'h747
`define MSECCFG_REG     csr_reg[26]

// unprivileged floating-point csrs
`define FFLAGS          12'h001
`define FFLAGS_REG      csr_reg[27]
`define FRM             12'h002
`define FRM_REG         csr_reg[28]
`define FCSR            12'h003
`define FCSR_REG        csr_reg[29]

// machine memory protection
`define PMPCFG0         12'h3a0
`define PMPADDR0        12'h3b0

`define CSR_COUNT 32

// mstatus register fields
`define MSTATUS_SD      `MSTATUS_REG[63]
`define MSTATUS_MBE     `MSTATUS_REG[37]
`define MSTATUS_SBE     `MSTATUS_REG[36]
`define MSTATUS_SXL     `MSTATUS_REG[35:34]
`define MSTATUS_UXL     `MSTATUS_REG[33:32]
`define MSTATUS_TSR     `MSTATUS_REG[22]
`define MSTATUS_TW      `MSTATUS_REG[21]
`define MSTATUS_TVM     `MSTATUS_REG[20]
`define MSTATUS_MXR     `MSTATUS_REG[19]
`define MSTATUS_SUM     `MSTATUS_REG[18]
`define MSTATUS_MPRV    `MSTATUS_REG[17]
`define MSTATUS_XS      `MSTATUS_REG[16:15]
`define MSTATUS_FS      `MSTATUS_REG[14:13]
`define MSTATUS_MPP     `MSTATUS_REG[12:11]
`define MSTATUS_VS      `MSTATUS_REG[10:9]
`define MSTATUS_SPP     `MSTATUS_REG[8]
`define MSTATUS_MPIE    `MSTATUS_REG[7]
`define MSTATUS_UBE     `MSTATUS_REG[6]
`define MSTATUS_SPIE    `MSTATUS_REG[5]
`define MSTATUS_MIE     `MSTATUS_REG[3]
`define MSTATUS_SIE     `MSTATUS_REG[1]

// mideleg register fields
`define MIDELEG_MEID    `MIDELEG_REG[11]
`define MIDELEG_SEID    `MIDELEG_REG[9]
`define MIDELEG_MTID    `MIDELEG_REG[7]
`define MIDELEG_STID    `MIDELEG_REG[5]
`define MIDELEG_MSID    `MIDELEG_REG[3]
`define MIDELEG_SSID    `MIDELEG_REG[1]

// mip register fields
`define MIP_MEIP        `MIP_REG[11]
`define MIP_SEIP        `MIP_REG[9]
`define MIP_MTIP        `MIP_REG[7]
`define MIP_STIP        `MIP_REG[5]
`define MIP_MSIP        `MIP_REG[3]
`define MIP_SSIP        `MIP_REG[1]

// mie register fields
`define MIE_MEIE        `MIE_REG[11]
`define MIE_SEIE        `MIE_REG[9]
`define MIE_MTIE        `MIE_REG[7]
`define MIE_STIE        `MIE_REG[5]
`define MIE_MSIE        `MIE_REG[3]
`define MIE_SSIE        `MIE_REG[1]

// sstatus register fields
`define SSTATUS_SD      `SSTATUS_REG[63]
`define SSTATUS_UXL     `SSTATUS_REG[33:32]
`define SSTATUS_MXR     `SSTATUS_REG[19]
`define SSTATUS_SUM     `SSTATUS_REG[18]
`define SSTATUS_XS      `SSTATUS_REG[16:15]
`define SSTATUS_FS      `SSTATUS_REG[14:13]
`define SSTATUS_VS      `SSTATUS_REG[10:9]
`define SSTATUS_SPP     `SSTATUS_REG[8]
`define SSTATUS_UBE     `SSTATUS_REG[6]
`define SSTATUS_SPIE    `SSTATUS_REG[5]
`define SSTATUS_SIE     `SSTATUS_REG[1]

// sip register fields
`define SIP_SEIP        `SIP_REG[9]
`define SIP_STIP        `SIP_REG[5]
`define SIP_SSIP        `SIP_REG[1]

// sie register fields
`define SIE_SEIE        `SIE_REG[9]
`define SIE_STIE        `SIE_REG[5]
`define SIE_SSIE        `SIE_REG[1]

// Zicsr instructions
`define CSR_RW          3'b001
`define CSR_RS          3'b010
`define CSR_RC          3'b011
`define CSR_RWI         3'b101
`define CSR_RSI         3'b110
`define CSR_RCI         3'b111

`define FLUSH_PD        4'b1000
`define FLUSH_ID        4'b1100
`define FLUSH_EX        4'b1110
`define FLUSH_MEM       4'b1111

module csr #(parameter HART_ID = 0) (
    input      [31:0] ir,

    input      [63:0] csr_in,
    output reg [63:0] csr_out,

    // PC signals
    output reg [63:0] trap_addr,
    output reg        trap_taken,

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

    input             stall,

    input             rst_n,

    input             clk
);

    wire [11:0] csr_addr = ir[31:20];
    reg  [63:0] csr_reg [0:`CSR_COUNT-1];
    reg  [ 1:0] privilege_level;

    // CSR exceptions
    reg  csr_addr_invalid;
    wire csr_wr_invalid;
    wire csr_pr_invalid;

    // trap handling signals
    reg [63:0] cause;
    reg [63:0] cause_pc;
    wire trap;

    reg  m_trap;
    wire m_ret;

    reg  s_trap;
    wire s_ret;

    wire trap_ret;

    // interrupt / exception context
    reg [63:0] val;

    /* REGISTER READ/UPDATE */

    wire csr_rw  = ir[14:12] == `CSR_RW  && ir[6:0] == `OP_SYSTEM;
    wire csr_rwi = ir[14:12] == `CSR_RWI && ir[6:0] == `OP_SYSTEM;
    wire csr_rs  = ir[14:12] == `CSR_RS  && ir[6:0] == `OP_SYSTEM;
    wire csr_rsi = ir[14:12] == `CSR_RSI && ir[6:0] == `OP_SYSTEM;
    wire csr_rc  = ir[14:12] == `CSR_RC  && ir[6:0] == `OP_SYSTEM;
    wire csr_rci = ir[14:12] == `CSR_RCI && ir[6:0] == `OP_SYSTEM;
    wire csr_op = csr_rw || csr_rwi || csr_rs || csr_rsi || csr_rc || csr_rci;

    wire rd = csr_op && !((csr_rw || csr_rwi                     ) && ir[11:7]  == 5'b0);
    wire wr = csr_op && !((csr_rs || csr_rsi || csr_rc || csr_rci) && ir[19:15] == 5'b0);

    assign csr_wr_invalid = &csr_addr[11:10] && wr;
    assign csr_pr_invalid = privilege_level < csr_addr[9:8] && (rd || wr);

    wire rd_valid = rd && !csr_addr_invalid && !csr_wr_invalid && !csr_pr_invalid;
    wire wr_valid = wr && !csr_addr_invalid && !csr_wr_invalid && !csr_pr_invalid;

    // current CSR value
    reg [63:0] csr;
    always @(*) begin
        csr_addr_invalid = 0;
        csr = 64'b0;
        if(rd || wr) begin
            case(csr_addr)
                `SSTATUS:       csr = `SSTATUS_REG;
                `SIE:           csr = `SIE_REG;
                `STVEC:         csr = `STVEC_REG;
                `SCOUNTEREN:    csr = `SCOUNTEREN_REG;

                `SSCRATCH:      csr = `SSCRATCH_REG;
                `SEPC:          csr = `SEPC_REG;
                `SCAUSE:        csr = `SCAUSE_REG;
                `STVAL:         csr = `STVAL_REG;
                `SIP:           csr = `SIP_REG;

                `SATP:          csr = `SATP_REG;

                `MVENDORID:     csr = `MVENDORID_REG;
                `MARCHID:       csr = `MARCHID_REG;
                `MIMPID:        csr = `MIMPID_REG;
                `MHARTID:       csr = `MHARTID_REG;
                `MCONFIGPTR:    csr = `MCONFIGPTR_REG;

                `MSTATUS:       csr = `MSTATUS_REG;
                `MISA:          csr = `MISA_REG;
                `MEDELEG:       csr = `MEDELEG_REG;
                `MIDELEG:       csr = `MIDELEG_REG;
                `MIE:           csr = `MIE_REG;
                `MTVEC:         csr = `MTVEC_REG;
                `MCOUNTEREN:    csr = `MCOUNTEREN_REG;

                `MSCRATCH:      csr = `MSCRATCH_REG;
                `MEPC:          csr = `MEPC_REG;
                `MCAUSE:        csr = `MCAUSE_REG;
                `MTVAL:         csr = `MTVAL_REG;
                `MIP:           csr = `MIP_REG;
                `MTINST:        csr = `MTINST_REG;

                `MENVCFG:       csr = `MENVCFG_REG;
                `MSECCFG:       csr = `MSECCFG_REG;

                `FFLAGS:        csr = `FFLAGS_REG;
                `FRM:           csr = `FRM_REG;
                `FCSR:          csr = `FCSR_REG;

                // riscv-tests only
                `PMPCFG0:       csr = 0;
                `PMPADDR0:      csr = 0;

                default: csr_addr_invalid = 1;
            endcase
        end
    end

    // WPRI bit mask
    reg [63:0] wpri;
    always @(*) begin
        case(csr_addr)
            `SSTATUS:   wpri = 64'h80000003000de762;
            `MSTATUS:   wpri = 64'h8000003f007fffea;

            `MENVCFG:   wpri = 64'hc0000000000000f1;
            `MSECCFG:   wpri = 64'h0000000000000207;

            default:    wpri = 64'hffffffffffffffff;
        endcase
    end

    always @(posedge clk) if(rd_valid) csr_out <= csr;

    // generate new CSR value
    reg [63:0] ncsr;
    always @(*) begin
        ncsr = 64'b0;
        if(ir[6:0] == `OP_SYSTEM) begin
            case(ir[14:12])
                `CSR_RW:  ncsr =        csr_in;
                `CSR_RS:  ncsr = csr |  csr_in;
                `CSR_RC:  ncsr = csr & ~csr_in;

                `CSR_RWI: ncsr =        {59'b0, ir[19:15]};
                `CSR_RSI: ncsr = csr |  {59'b0, ir[19:15]};
                `CSR_RCI: ncsr = csr & ~{59'b0, ir[19:15]};

                default:  ncsr = 64'b0;
            endcase
            ncsr = (ncsr & wpri) | (csr & ~wpri);
        end
    end

    // update CSR on reset, CSR instruction or trap
    always @(posedge clk) begin
        if(!rst_n) begin
            // set privilege level to machine mode
            privilege_level <= 2'b11;

            // initialize CSR registers
            // mvendorid
            `MVENDORID_REG  <= 64'h0000000000000000;
            // marchid
            `MARCHID_REG    <= 64'h0000000000000027;
            // mimpid
            `MIMPID_REG     <= 64'h0000000000000000;
            // mhartid
            `MHARTID_REG    <= HART_ID;
            // mconfigptr
            `MCONFIGPTR_REG <= 64'h0000000000000000;

            // mstatus
            `MSTATUS_REG    <= 64'h0000000a00001900;
            // misa
            `MISA_REG       <= 64'h8000000000141105;
            // medeleg
            `MEDELEG_REG    <= 64'h0000000000000000;
            // mideleg
            `MIDELEG_REG    <= 64'h0000000000000000;
            // mie
            `MIE_REG        <= 64'h0000000000000000;
            // mtvec
            `MTVEC_REG      <= 64'h0000000000000000;
            // mcounteren
            `MCOUNTEREN_REG <= 64'h0000000000000000;

            // mscratch
            `MSCRATCH_REG   <= 64'h0000000000000000;
            // mepc
            `MEPC_REG       <= 64'h0000000000000000;
            // mcause
            `MCAUSE_REG     <= 64'h0000000000000000;
            // mtval
            `MTVAL_REG      <= 64'h0000000000000000;
            // mip
            `MIP_REG        <= 64'h0000000000000000;
            // mtinst
            `MTINST_REG     <= 64'h0000000000000000;

        end
        else if(wr_valid && !stall) begin
            case(csr_addr)
                // supervisor trap setup
                `SSTATUS:        `SSTATUS_REG       <= ncsr;
                `SIE:            `SIE_REG           <= ncsr;
                `STVEC:          `STVEC_REG         <= ncsr;
                `SCOUNTEREN:     `SCOUNTEREN_REG    <= ncsr;

                // supervisor trap handling
                `SSCRATCH:       `SSCRATCH_REG      <= ncsr;
                `SEPC:           `SEPC_REG          <= ncsr;
                `SCAUSE:         `SCAUSE_REG        <= ncsr;
                `STVAL:          `STVAL_REG         <= ncsr;
                `SIP:            `SIP_REG           <= ncsr;

                // supervisor protection and translation
                `SATP:           `SATP_REG          <= ncsr;

                // machine trap setup
                `MSTATUS:        `MSTATUS_REG       <= ncsr;
                `MISA:           `MISA_REG          <= ncsr;
                `MEDELEG:        `MEDELEG_REG       <= ncsr;
                `MIDELEG:        `MIDELEG_REG       <= ncsr;
                `MIE:            `MIE_REG           <= ncsr;
                `MTVEC:          `MTVEC_REG         <= ncsr;
                `MCOUNTEREN:     `MCOUNTEREN_REG    <= ncsr;

                // machine trap handling
                `MSCRATCH:       `MSCRATCH_REG      <= ncsr;
                `MEPC:           `MEPC_REG          <= ncsr;
                `MCAUSE:         `MCAUSE_REG        <= ncsr;
                `MTVAL:          `MTVAL_REG         <= ncsr;
                `MIP:            `MIP_REG           <= ncsr;
                `MTINST:         `MTINST_REG        <= ncsr;

                // machine configuration
                `MENVCFG:        `MENVCFG_REG       <= ncsr;
                `MSECCFG:        `MSECCFG_REG       <= ncsr;

                `FFLAGS:         `FFLAGS_REG        <= ncsr;
                `FRM:            `FRM_REG           <= ncsr;
                `FCSR:           `FCSR_REG          <= ncsr;
            endcase
        end
        // trap setup
        else if(trap) begin
            // machine trap
            if(m_trap) begin
                privilege_level <= 2'b11;

                // mstatus
                `MSTATUS_MIE    <= 0;
                `MSTATUS_MPIE   <= `MSTATUS_MIE;
                `MSTATUS_MPP    <= privilege_level;
                // mepc
                `MEPC_REG       <= cause_pc;
                // mcause
                `MCAUSE_REG     <= cause;
                // mtval
                `MTVAL_REG      <= val;
            end
            // supervisor trap
            else if(s_trap) begin
                privilege_level <= 2'b01;

                // sstatus
                `SSTATUS_SIE    <= 0;
                `SSTATUS_SPIE   <= `SSTATUS_SIE;
                `SSTATUS_SPP    <= privilege_level[0];
                // sepc
                `SEPC_REG       <= cause_pc;
                // scause
                `SCAUSE_REG     <= cause;
                // stval
                `STVAL_REG      <= val;
            end
        end
        else if(trap_ret) begin
            if(m_ret) begin
                `MSTATUS_MIE <= `MSTATUS_MPIE;
                privilege_level <= `MSTATUS_MPP;
            end
            else if(s_ret) begin
                `SSTATUS_SIE <= `SSTATUS_SPIE;
                privilege_level <= {1'b0, `SSTATUS_SPP};
            end
        end
    end

    /* TRAP HANDLING */

    assign trap = m_trap || s_trap;

    assign m_ret = ir == 32'h30200073;
    assign s_ret = ir == 32'h10200073;
    assign trap_ret = m_ret || s_ret;

    // exception signals
    wire ecall      = ir == 32'h00000073;
    wire dmem_ma    = dmem_ld_ma || dmem_st_ma;

    // interrupt / exception detection
    reg intr = 0;
    reg exc;

    // pipeline flush signals
    reg [3:0] flush;
    assign {flush_pd, flush_id, flush_ex, flush_mem} = flush;

    always @(*) begin
        cause = 64'd0;
        cause_pc = 64'h0;
        exc = 0;
        val = 64'h0;
        flush = 5'b0;

        if(trap_ret) flush = `FLUSH_MEM;

        // Environment call
        else if(ecall) begin
            case(privilege_level)
                2'b00: begin cause = 4'd8;  exc = 1; end
                2'b01: begin cause = 4'd9;  exc = 1; end
                2'b11: begin cause = 4'd11; exc = 1; end
                default: exc = 0;
            endcase
            cause_pc    = pc_mem;
            flush       = `FLUSH_MEM;
        end
        // Load/Store/AMO Address Misaligned
        else if(dmem_ma) begin
            if(dmem_ld_ma) begin cause = 4'd4; exc = 1; end
            else           begin cause = 4'd6; exc = 1; end
            cause_pc    = pc_mem;
            val         = dmem_addr;
            flush       = `FLUSH_MEM;
        end
        else if(csr_addr_invalid) begin
            cause       = 4'd2;
            exc         = 1;
            cause_pc    = pc_mem;
            val         = 0;
            flush       = `FLUSH_MEM;
        end
    end

    // exception delegation
    always @(*) begin
        s_trap = 0;
        m_trap = 0;

        if(intr) begin
            // check if interrupts enabled globally
            // and specific interrupt enabled

        end
        else if(exc) begin
            m_trap = !`MIDELEG_REG[cause] || privilege_level == 2'b11;
            s_trap =  `MIDELEG_REG[cause] && privilege_level != 2'b11;
        end

        trap_taken = m_trap || s_trap || m_ret || s_ret;
    end

    // trap entry/exit address
    wire [63:0] stvec_offs;
    wire [63:0] mtvec_offs;
    always @(*) begin
        trap_addr = 64'hZ;
        if(m_trap) trap_addr = {`MTVEC_REG[63:2], 2'b00} + mtvec_offs;
        if(s_trap) trap_addr = {`STVEC_REG[63:2], 2'b00} + stvec_offs;
        if(m_ret)  trap_addr = `MEPC_REG;
        if(s_ret)  trap_addr = `SEPC_REG;
    end

    // vectored exception address generation
    assign mtvec_offs = (`MTVEC_REG[1:0] == 2'b01 && !cause[63]) ? (cause << 2) : 64'b0;
    assign stvec_offs = (`STVEC_REG[1:0] == 2'b01 && !cause[63]) ? (cause << 2) : 64'b0;

    // sstatus / mstatus
    // SD   = VS, FS, XS context status
    // MBE  = machine endianness
    // SBE  = supervisor endiannes
    // SXL  = supervisor XLEN
    // UXL  = user XLEN
    // TSR  = trap SRET (virtualization)
    // TW   = timeout wait (virtualization)
    // TVM  = trap virtual memory (virtualization)
    // MXR  = make executable readable
    // SUM  = permit supervisor user memory access
    // MPRV = Modify Privilege
    // XS   = user mode extension context status
    // FS   = float extension context status
    // MPP  = machine previous privilege
    // VS   = vector extension context status
    // SPP  = supervisor previous privilege
    // MPIE = machine previous interrupt enable
    // UBE  = user endianness
    // SPIE = supervisor previous interrupt enable
    // MIE  = machine interrupt enable
    // SIE  = supervisor interrupt enable
endmodule

/* currently unimplemented registers */


// unprivileged counter/timers
`define CYCLE           12'hc00
`define TIME            12'hc01
`define INSTRET         12'hc02
`define HPMCOUNTER3     12'hc03

// machine counter/timers
`define MCYCLE          12'hb00
`define MINSTRET        12'hb02
`define MHPMCOUNTER3    12'hb03

// machine counter setup
`define MCOUNTINHIBIT   12'hb20
`define MHPMEVENT3      12'hb23
