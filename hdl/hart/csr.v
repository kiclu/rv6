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
`define mtval2          12'h346
`define mtval2_reg      csr_reg[25]

// machine configuration
`define menvcfg         12'h30a
`define menvcfg_reg     csr_reg[26]
`define mseccfg         12'h747
`define mseccfg_reg     csr_reg[27]

// unprivileged floating-point csrs
`define fflags          12'h001
`define fflags_reg      csr_reg[28]
`define frm             12'h002
`define frm_reg         csr_reg[29]
`define fcsr            12'h003
`define fcsr_reg        csr_reg[30]

`define csr_count 32

`define op_system   7'b1110011
`define csr_rw      3'b001
`define csr_rs      3'b010
`define csr_rc      3'b011
`define csr_rwi     3'b101
`define csr_rsi     3'b110
`define csr_rci     3'b111

module csr #(parameter HART_ID = 0) (
    input      [31:0] ir,

    input      [63:0] csr_in,
    output reg [63:0] csr_out,

    output reg        csr_addr_invalid,
    output            csr_wr_invalid,
    output            csr_pr_invalid,

    output     [63:0] trap_addr,
    output reg        trap,

    input      [63:0] pc,

    input             rst_n,

    input             clk
);

    wire [11:0] csr_addr = ir[31:20];
    reg  [63:0] csr_reg [0:`csr_count-1];
    reg  [ 1:0] privilege_level = 2'b11;

    /* REGISTER READ/UPDATE */

    wire csr_rw  = ir[14:12] == `csr_rw  && ir[6:0] == `op_system;
    wire csr_rwi = ir[14:12] == `csr_rwi && ir[6:0] == `op_system;
    wire csr_rs  = ir[14:12] == `csr_rs  && ir[6:0] == `op_system;
    wire csr_rsi = ir[14:12] == `csr_rsi && ir[6:0] == `op_system;
    wire csr_rc  = ir[14:12] == `csr_rc  && ir[6:0] == `op_system;
    wire csr_rci = ir[14:12] == `csr_rci && ir[6:0] == `op_system;

    wire rd = !((csr_rw || csr_rwi)                      && ir[11:7]  == 5'b0) && ir[6:0] == `op_system;
    wire wr = !((csr_rs || csr_rsi || csr_rc || csr_rci) && ir[19:15] == 5'b0) && ir[6:0] == `op_system;

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
                `mtval2:        csr <= `mtval2_reg;

                `menvcfg:       csr <= `menvcfg_reg;
                `mseccfg:       csr <= `mseccfg_reg;

                `fflags:        csr <= `fflags_reg;
                `frm:           csr <= `frm_reg;
                `fcsr:          csr <= `fcsr_reg;

                default: csr_addr_invalid <= 1;
            endcase
        end
    end

    // write protected, read ignore bit mask
    reg [63:0] wpri;
    always @(*) begin
        case(csr_addr)
            `sstatus:       wpri <= 64'h80000003000de762;
            `mstatus:       wpri <= 64'h8000003f007fffea;

            `menvcfg:       wpri <= 64'hc0000000000000f1;
            `mseccfg:       wpri <= 64'h0000000000000207;

            default: wpri <= 64'hffffffffffffffff;
        endcase
    end

    always @(posedge clk) if(rd_valid) csr_out <= csr;

    // generate new CSR value
    reg [63:0] ncsr;
    always @(*) begin
        ncsr <= 64'b0;
        if(ir[6:0] == `op_system) begin
            case(ir[14:12])
                `csr_rw:  ncsr <= (       csr_in) & wpri;
                `csr_rs:  ncsr <= (csr |  csr_in) & wpri;
                `csr_rc:  ncsr <= (csr & ~csr_in) & wpri;

                `csr_rwi: ncsr <= (       {59'b0, ir[19:15]}) & wpri;
                `csr_rsi: ncsr <= (csr |  {59'b0, ir[19:15]}) & wpri;
                `csr_rci: ncsr <= (csr & ~{59'b0, ir[19:15]}) & wpri;

                default:  ncsr <= 64'b0;
            endcase
        end
    end

    always @(posedge clk) begin
        trap <= 0;
        if(!rst_n) begin
            // set privilege level to machine mode
            privilege_level <= 2'b11;

            // initialize CSR registers
            // mvendorid
            `mvendorid_reg <= 64'h0000000000000000;
            // marchid
            `marchid_reg <= 64'h0000000000000000;
            // mimpid
            `mimpid_reg <= 64'h0000000000000000;
            // mhartid
            `mhartid_reg <= HART_ID;

            // misa
            `misa_reg <= 64'h8000000000141105;

        end
        else if(wr_valid) begin
            case(csr_addr)
                // supervisor trap setup (srw)
                `sstatus:        `sstatus_reg       <= ncsr;
                `sie:            `sie_reg           <= ncsr;
                `stvec:          `stvec_reg         <= ncsr;
                `scounteren:     `scounteren_reg    <= ncsr;

                // supervisor trap handling (srw)
                `sscratch:       `sscratch_reg      <= ncsr;
                `sepc:           `sepc_reg          <= ncsr;
                `scause:         `scause_reg        <= ncsr;
                `stval:          `stval_reg         <= ncsr;
                `sip:            `sip_reg           <= ncsr;

                // supervisor protection and translation (srw)
                `satp:           `satp_reg          <= ncsr;

                // machine trap setup (mrw)
                `mstatus:        `mstatus_reg       <= ncsr;
                `misa:           `misa_reg          <= ncsr;
                `medeleg:        `medeleg_reg       <= ncsr;
                `mideleg:        `mideleg_reg       <= ncsr;
                `mie:            `mie_reg           <= ncsr;
                `mtvec:          `mtvec_reg         <= ncsr;
                `mcounteren:     `mcounteren_reg    <= ncsr;

                // machine trap handling (mrw)
                `mscratch:       `mscratch_reg      <= ncsr;
                `mepc:           `mepc_reg          <= ncsr;
                `mcause:         `mcause_reg        <= ncsr;
                `mtval:          `mtval_reg         <= ncsr;
                `mip:            `mip_reg           <= ncsr;
                `mtinst:         `mtinst_reg        <= ncsr;
                `mtval2:         `mtval2_reg        <= ncsr;

                // machine configuration
                `menvcfg:        `menvcfg_reg       <= ncsr;
                `mseccfg:        `mseccfg_reg       <= ncsr;

                `fflags:         `fflags_reg        <= ncsr;
                `frm:            `frm_reg           <= ncsr;
                `fcsr:           `fcsr_reg          <= ncsr;
            endcase
        end
        else begin

        end
        //else if() begin
        //    // supervisor trap
        //    if(privilege_level == 2'b00) begin
        //        // update sstatus

        //        // update sepc
        //        csr_reg[5] <= pc;
        //        // update scause

        //        // update stval

        //    end
        //    // machine trap
        //    else begin
        //        // update mstatus

        //        // update mepc
        //        csr_reg[23] <= pc;
        //        // update mcause

        //        // update mtval

        //    end
        //    trap <= 1;
        //end
    end

    /* TRAP HANDLING */

    always @(posedge clk) begin
        trap <= 0;
    end

    wire [63:0] tvec = privilege_level == 2'b00 ? csr_reg[2] : csr_reg[20];
    // TODO: implement vectored interrupt
    assign trap_addr = tvec;

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
