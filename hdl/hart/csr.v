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

// supervisor trap setup
`define sstatus         12'h100
`define sstatus_reg     csr_reg[0]
`define sie             12'h104
`define sie_reg         csr_reg[1]
`define stvec           12'h105
`define stvec_reg       csr_reg[2]
`define scounteren      12'h106
`define scounteren_reg  csr_reg[3]

// supervisor trap handling
`define sscratch        12'h140
`define sscratch_reg    csr_reg[4]
`define sepc            12'h141
`define sepc_reg        csr_reg[5]
`define scause          12'h142
`define scause_reg      csr_reg[6]
`define stval           12'h143
`define stval_reg       csr_reg[7]
`define sip             12'h144
`define sip_reg         csr_reg[8]

// supervisor protection and translation
`define satp            12'h180
`define satp_reg        csr_reg[9]

// machine information registers
`define mvendorid       12'hf11
`define mvendorid_reg   csr_reg[10]
`define marchid         12'hf12
`define marchid_reg     csr_reg[11]
`define mimpid          12'hf13
`define mimpid_reg      csr_reg[12]
`define mhartid         12'hf14
`define mhartid_reg     csr_reg[13]
`define mconfigptr      12'hf15
`define mconfigptr_reg  csr_reg[14]

// machine trap setup
`define mstatus         12'h300
`define mstatus_reg     csr_reg[0]
`define misa            12'h301
`define misa_reg        csr_reg[15]
`define medeleg         12'h302
`define medeleg_reg     csr_reg[16]
`define mideleg         12'h303
`define mideleg_reg     csr_reg[17]
`define mie             12'h304
`define mie_reg         csr_reg[1]
`define mtvec           12'h305
`define mtvec_reg       csr_reg[18]
`define mcounteren      12'h306
`define mcounteren_reg  csr_reg[19]

// machine trap handling
`define mscratch        12'h340
`define mscratch_reg    csr_reg[20]
`define mepc            12'h341
`define mepc_reg        csr_reg[21]
`define mcause          12'h342
`define mcause_reg      csr_reg[22]
`define mtval           12'h343
`define mtval_reg       csr_reg[23]
`define mip             12'h344
`define mip_reg         csr_reg[8]
`define mtinst          12'h345
`define mtinst_reg      csr_reg[24]

// machine configuration
`define menvcfg         12'h30a
`define menvcfg_reg     csr_reg[25]
`define mseccfg         12'h747
`define mseccfg_reg     csr_reg[26]

// unprivileged floating-point csrs
`define fflags          12'h001
`define fflags_reg      csr_reg[27]
`define frm             12'h002
`define frm_reg         csr_reg[28]
`define fcsr            12'h003
`define fcsr_reg        csr_reg[29]

`define csr_count 32


// mstatus register fields
`define mstatus_sd      `mstatus_reg[63]
`define mstatus_mbe     `mstatus_reg[37]
`define mstatus_sbe     `mstatus_reg[36]
`define mstatus_sxl     `mstatus_reg[35:34]
`define mstatus_uxl     `mstatus_reg[33:32]
`define mstatus_tsr     `mstatus_reg[22]
`define mstatus_tw      `mstatus_reg[21]
`define mstatus_tvm     `mstatus_reg[20]
`define mstatus_mxr     `mstatus_reg[19]
`define mstatus_sum     `mstatus_reg[18]
`define mstatus_mprv    `mstatus_reg[17]
`define mstatus_xs      `mstatus_reg[16:15]
`define mstatus_fs      `mstatus_reg[14:13]
`define mstatus_mpp     `mstatus_reg[12:11]
`define mstatus_vs      `mstatus_reg[10:9]
`define mstatus_spp     `mstatus_reg[8]
`define mstatus_mpie    `mstatus_reg[7]
`define mstatus_ube     `mstatus_reg[6]
`define mstatus_spie    `mstatus_reg[5]
`define mstatus_mie     `mstatus_reg[3]
`define mstatus_sie     `mstatus_reg[1]

// mideleg register fields
`define mideleg_meid    `mideleg_reg[11]
`define mideleg_seid    `mideleg_reg[9]
`define mideleg_mtid    `mideleg_reg[7]
`define mideleg_stid    `mideleg_reg[5]
`define mideleg_msid    `mideleg_reg[3]
`define mideleg_ssid    `mideleg_reg[1]

// mip register fields
`define mip_meip        `mip_reg[11]
`define mip_seip        `mip_reg[9]
`define mip_mtip        `mip_reg[7]
`define mip_stip        `mip_reg[5]
`define mip_msip        `mip_reg[3]
`define mip_ssip        `mip_reg[1]

// mie register fields
`define mie_meie        `mie_reg[11]
`define mie_seie        `mie_reg[9]
`define mie_mtie        `mie_reg[7]
`define mie_stie        `mie_reg[5]
`define mie_msie        `mie_reg[3]
`define mie_ssie        `mie_reg[1]

// sstatus register fields
`define sstatus_sd      `sstatus_reg[63]
`define sstatus_uxl     `sstatus_reg[33:32]
`define sstatus_mxr     `sstatus_reg[19]
`define sstatus_sum     `sstatus_reg[18]
`define sstatus_xs      `sstatus_reg[16:15]
`define sstatus_fs      `sstatus_reg[14:13]
`define sstatus_vs      `sstatus_reg[10:9]
`define sstatus_spp     `sstatus_reg[8]
`define sstatus_ube     `sstatus_reg[6]
`define sstatus_spie    `sstatus_reg[5]
`define sstatus_sie     `sstatus_reg[1]

// sip register fields
`define sip_seip        `sip_reg[9]
`define sip_stip        `sip_reg[5]
`define sip_ssip        `sip_reg[1]

// sie register fields
`define sie_seie        `sie_reg[9]
`define sie_stie        `sie_reg[5]
`define sie_ssie        `sie_reg[1]


// Zicsr instructions
`define op_system   7'b1110011
`define csr_rw      3'b001
`define csr_rs      3'b010
`define csr_rc      3'b011
`define csr_rwi     3'b101
`define csr_rsi     3'b110
`define csr_rci     3'b111

`define FLUSH_PD    4'b1000
`define FLUSH_ID    4'b1100
`define FLUSH_EX    4'b1110
`define FLUSH_MEM   4'b1111

module csr #(parameter HART_ID = 0) (
    input      [31:0] ir,

    input      [63:0] csr_in,
    output reg [63:0] csr_out,

    // PC signals
    output reg [63:0] trap_addr,
    output            trap_taken,

    // interrupt signals
    input             intr_s,
    input             intr_t,
    input             intr_e,

    // exception signals
    input             dmem_ld_ma,
    input             dmem_st_ma,

    // exception context signals
    input      [63:0] dmem_addr,

    // pipeline flush signals
    output            flush_if,
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
    reg  [63:0] csr_reg [0:`csr_count-1];
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

    // interrupt / exception context
    reg [63:0] val;

    /* REGISTER READ/UPDATE */

    wire csr_rw  = ir[14:12] == `csr_rw  && ir[6:0] == `op_system;
    wire csr_rwi = ir[14:12] == `csr_rwi && ir[6:0] == `op_system;
    wire csr_rs  = ir[14:12] == `csr_rs  && ir[6:0] == `op_system;
    wire csr_rsi = ir[14:12] == `csr_rsi && ir[6:0] == `op_system;
    wire csr_rc  = ir[14:12] == `csr_rc  && ir[6:0] == `op_system;
    wire csr_rci = ir[14:12] == `csr_rci && ir[6:0] == `op_system;
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
        csr_addr_invalid <= 0;
        csr <= 64'b0;
        if(rd || wr) begin
            case(csr_addr)
                `sstatus:       csr <= `sstatus_reg;
                `sie:           csr <= `sie_reg;
                `stvec:         csr <= `stvec_reg;
                `scounteren:    csr <= `scounteren_reg;

                `sscratch:      csr <= `sscratch_reg;
                `sepc:          csr <= `sepc_reg;
                `scause:        csr <= `scause_reg;
                `stval:         csr <= `stval_reg;
                `sip:           csr <= `sip_reg;

                `satp:          csr <= `satp_reg;

                `mvendorid:     csr <= `mvendorid_reg;
                `marchid:       csr <= `marchid_reg;
                `mimpid:        csr <= `mimpid_reg;
                `mhartid:       csr <= `mhartid_reg;
                `mconfigptr:    csr <= `mconfigptr_reg;

                `mstatus:       csr <= `mstatus_reg;
                `misa:          csr <= `misa_reg;
                `medeleg:       csr <= `medeleg_reg;
                `mideleg:       csr <= `mideleg_reg;
                `mie:           csr <= `mie_reg;
                `mtvec:         csr <= `mtvec_reg;
                `mcounteren:    csr <= `mcounteren_reg;

                `mscratch:      csr <= `mscratch_reg;
                `mepc:          csr <= `mepc_reg;
                `mcause:        csr <= `mcause_reg;
                `mtval:         csr <= `mtval_reg;
                `mip:           csr <= `mip_reg;
                `mtinst:        csr <= `mtinst_reg;

                `menvcfg:       csr <= `menvcfg_reg;
                `mseccfg:       csr <= `mseccfg_reg;

                `fflags:        csr <= `fflags_reg;
                `frm:           csr <= `frm_reg;
                `fcsr:          csr <= `fcsr_reg;

                default: csr_addr_invalid <= 1;
            endcase
        end
    end

    // WPRI bit mask
    reg [63:0] wpri;
    always @(*) begin
        case(csr_addr)
            `sstatus:   wpri <= 64'h80000003000de762;
            `mstatus:   wpri <= 64'h8000003f007fffea;

            `menvcfg:   wpri <= 64'hc0000000000000f1;
            `mseccfg:   wpri <= 64'h0000000000000207;

            default:    wpri <= 64'hffffffffffffffff;
        endcase
    end

    always @(posedge clk) if(rd_valid) csr_out <= csr;

    // generate new CSR value
    reg [63:0] ncsr;
    always @(csr, ir, csr_in, wpri) begin
        ncsr = 64'b0;
        if(ir[6:0] == `op_system) begin
            case(ir[14:12])
                `csr_rw:  ncsr =        csr_in;
                `csr_rs:  ncsr = csr |  csr_in;
                `csr_rc:  ncsr = csr & ~csr_in;

                `csr_rwi: ncsr =        {59'b0, ir[19:15]};
                `csr_rsi: ncsr = csr |  {59'b0, ir[19:15]};
                `csr_rci: ncsr = csr & ~{59'b0, ir[19:15]};

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
            `mvendorid_reg  <= 64'h0000000000000000;
            // marchid
            `marchid_reg    <= 64'h0000000000000000;
            // mimpid
            `mimpid_reg     <= 64'h0000000000000000;
            // mhartid
            `mhartid_reg    <= HART_ID;
            // mconfigptr
            `mconfigptr_reg <= 64'h0000000000000000;

            // mstatus
            `mstatus_reg    <= 64'h0000000a00001900;
            // misa
            `misa_reg       <= 64'h8000000000141105;
            // medeleg
            `medeleg_reg    <= 64'h0000000000000000;
            // mideleg
            `mideleg_reg    <= 64'h0000000000000000;
            // mie
            `mie_reg        <= 64'h0000000000000000;
            // mtvec
            `mtvec_reg      <= 64'h0000000000000000;
            // mcounteren
            `mcounteren_reg <= 64'h0000000000000000;

            // mscratch
            `mscratch_reg   <= 64'h0000000000000000;
            // mepc
            `mepc_reg       <= 64'h0000000000000000;
            // mcause
            `mcause_reg     <= 64'h0000000000000000;
            // mtval
            `mtval_reg      <= 64'h0000000000000000;
            // mip
            `mip_reg        <= 64'h0000000000000000;
            // mtinst
            `mtinst_reg     <= 64'h0000000000000000;

        end
        else if(wr_valid && !stall) begin
            case(csr_addr)
                // supervisor trap setup
                `sstatus:        `sstatus_reg       <= ncsr;
                `sie:            `sie_reg           <= ncsr;
                `stvec:          `stvec_reg         <= ncsr;
                `scounteren:     `scounteren_reg    <= ncsr;

                // supervisor trap handling
                `sscratch:       `sscratch_reg      <= ncsr;
                `sepc:           `sepc_reg          <= ncsr;
                `scause:         `scause_reg        <= ncsr;
                `stval:          `stval_reg         <= ncsr;
                `sip:            `sip_reg           <= ncsr;

                // supervisor protection and translation
                `satp:           `satp_reg          <= ncsr;

                // machine trap setup
                `mstatus:        `mstatus_reg       <= ncsr;
                `misa:           `misa_reg          <= ncsr;
                `medeleg:        `medeleg_reg       <= ncsr;
                `mideleg:        `mideleg_reg       <= ncsr;
                `mie:            `mie_reg           <= ncsr;
                `mtvec:          `mtvec_reg         <= ncsr;
                `mcounteren:     `mcounteren_reg    <= ncsr;

                // machine trap handling
                `mscratch:       `mscratch_reg      <= ncsr;
                `mepc:           `mepc_reg          <= ncsr;
                `mcause:         `mcause_reg        <= ncsr;
                `mtval:          `mtval_reg         <= ncsr;
                `mip:            `mip_reg           <= ncsr;
                `mtinst:         `mtinst_reg        <= ncsr;

                // machine configuration
                `menvcfg:        `menvcfg_reg       <= ncsr;
                `mseccfg:        `mseccfg_reg       <= ncsr;

                `fflags:         `fflags_reg        <= ncsr;
                `frm:            `frm_reg           <= ncsr;
                `fcsr:           `fcsr_reg          <= ncsr;
            endcase
        end
        // trap setup
        else if(trap) begin
            // machine trap
            if(m_trap) begin
                privilege_level <= 2'b11;

                // mstatus
                `mstatus_mie    <= 0;
                `mstatus_mpie   <= `mie;
                `mstatus_mpp    <= privilege_level;
                // mepc
                `mepc_reg       <= cause_pc;
                // mcause
                `mcause_reg     <= cause;
                // mtval
                `mtval_reg      <= val;
                // mip

            end
            // supervisor trap
            else if(s_trap) begin
                privilege_level <= 2'b01;

                // sstatus
                `sstatus_sie    <= 0;
                `sstatus_spie   <= `sie;
                `sstatus_spp    <= privilege_level[0];
                // sepc
                `sepc_reg       <= cause_pc;
                // scause
                `scause_reg     <= cause;
                // stval
                `stval_reg      <= val;
                // sip

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
    wire intr = intr_s || intr_t || intr_e;
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
        if(ecall) begin
            case(privilege_level)
                2'b00: begin cause = 4'd8;  exc = 1; end
                2'b01: begin cause = 4'd9;  exc = 1; end
                2'b11: begin cause = 4'd11; exc = 1; end
                default: exc = 0;
            endcase
            cause_pc = pc_mem;
            val = dmem_addr;
            flush = `FLUSH_MEM;
        end
        // Load/Store/AMO Address Misaligned
        else if(dmem_ma) begin
            if(dmem_ld_ma) begin cause = 4'd4; exc = 1; end
            else           begin cause = 4'd6; exc = 1; end
            cause_pc = pc_mem;
            flush = `FLUSH_MEM;
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
            m_trap = !`mideleg_reg[cause] || privilege_level == 2'b11;
            s_trap =  `mideleg_reg[cause] && privilege_level != 2'b11;
        end
    end

    // PC trap signal generation
    reg trap_taken_d;
    always @(posedge clk) trap_taken_d <= m_trap || s_trap;
    assign trap_taken = ((m_trap || s_trap) && !trap_taken_d) || trap_ret;

    // trap entry/exit address
    wire [63:0] stvec_offs;
    wire [63:0] mtvec_offs;
    always @(*) begin
        trap_addr <= 64'h0;
        if(m_trap) trap_addr <= {`mtvec_reg[63:2], 2'b00} + mtvec_offs;
        if(s_trap) trap_addr <= {`stvec_reg[63:2], 2'b00} + stvec_offs;
        if(m_ret)  trap_addr <= `mepc_reg;
        if(s_ret)  trap_addr <= `sepc_reg;
    end

    // vectored exception address generation
    assign mtvec_offs = (`mtvec_reg[1:0] == 2'b01 && !cause[63]) ? (cause << 2) : 64'b0;
    assign stvec_offs = (`stvec_reg[1:0] == 2'b01 && !cause[63]) ? (cause << 2) : 64'b0;

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

// machine memory protection
`define pmpcfg0         12'h3a0
`define pmpaddr0        12'h3b0

// unprivileged counter/timers
`define cycle           12'hc00
`define time            12'hc01
`define instret         12'hc02
`define hpmcounter3     12'hc03

// machine counter/timers
`define mcycle          12'hb00
`define minstret        12'hb02
`define mhpmcounter3    12'hb03

// machine counter setup
`define mcountinhibit   12'hb20
`define mhpmevent3      12'hb23
