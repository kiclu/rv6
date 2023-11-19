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

/*
 * Optional registers can be enabled during compilation by uncommenting
 * csr_fp, csr_mmp and csr_counter define macros. In order to enable one,
 * all previous one must be included too.
*/

//`define csr_fp
//`define csr_mmp
//`define csr_counter

module csr(
    input      [11:0] csr_addr,

    input      [63:0] csr_in,

    output reg [63:0] csr_out,

    input             csr_rd,
    input             csr_wr,

    output reg        csr_invalid,
    output            csr_wr_invalid,
    output            csr_pr_invalid,

    input             rst_n,

    input             clk
);

    reg [1:0] privilege_level = 2'b11;

    // supervisor trap setup
    `define sstatus         12'h100
    `define sie             12'h104
    `define stvec           12'h105
    `define scounteren      12'h106

    // supervisor trap handling
    `define sscratch        12'h140
    `define sepc            12'h141
    `define scause          12'h142
    `define stval           12'h143
    `define sip             12'h144

    // supervisor protection and translation
    `define satp            12'h180

    // machine information registers
    `define mvendorid       12'hF11
    `define marchid         12'hF12
    `define mimpid          12'hF13
    `define mhartid         12'hF14
    `define mconfigptr      12'hF15

    // machine trap setup
    `define mstatus         12'h300
    `define misa            12'h301
    `define medeleg         12'h302
    `define mideleg         12'h303
    `define mie             12'h304
    `define mtvec           12'h305
    `define mcounteren      12'h306
    
    // machine trap handling
    `define mscratch        12'h340
    `define mepc            12'h341
    `define mcause          12'h342
    `define mtval           12'h343
    `define mip             12'h344
    `define mtinst          12'h345
    `define mtval2          12'h346

    // machine configuration
    `define menvcfg         12'h30A
    `define mseccfg         12'h747

    `define csr_count 31

`ifdef csr_fp
    // unprivileged floating-point csrs
    `define fflags          12'h001
    `define frm             12'h002
    `define fcsr            12'h003

    `define csr_count 34
`endif

`ifdef csr_mmp
    // machine memory protection
    `define pmpcfg0         12'h3A0
    `define pmpcfg2         12'h3A2
    `define pmpcfg4         12'h3A4
    `define pmpcfg6         12'h3A6
    `define pmpcfg8         12'h3A8
    `define pmpcfg10        12'h3AA
    `define pmpcfg12        12'h3AC
    `define pmpcfg14        12'h3AE
    `define pmpaddr0        12'h3B0
    `define pmpaddr1        12'h3B1
    `define pmpaddr2        12'h3B2
    `define pmpaddr3        12'h3B3
    `define pmpaddr4        12'h3B4
    `define pmpaddr5        12'h3B5
    `define pmpaddr6        12'h3B6
    `define pmpaddr7        12'h3B7
    `define pmpaddr8        12'h3B8
    `define pmpaddr9        12'h3B9
    `define pmpaddr10       12'h3BA
    `define pmpaddr11       12'h3BB
    `define pmpaddr12       12'h3BC
    `define pmpaddr13       12'h3BD
    `define pmpaddr14       12'h3BE
    `define pmpaddr15       12'h3BF
    `define pmpaddr16       12'h3C0
    `define pmpaddr17       12'h3C1
    `define pmpaddr18       12'h3C2
    `define pmpaddr19       12'h3C3
    `define pmpaddr20       12'h3C4
    `define pmpaddr21       12'h3C5
    `define pmpaddr22       12'h3C6
    `define pmpaddr23       12'h3C7
    `define pmpaddr24       12'h3C8
    `define pmpaddr25       12'h3C9
    `define pmpaddr26       12'h3CA
    `define pmpaddr27       12'h3CB
    `define pmpaddr28       12'h3CC
    `define pmpaddr29       12'h3CD
    `define pmpaddr30       12'h3CE
    `define pmpaddr31       12'h3CF
    `define pmpaddr32       12'h3D0
    `define pmpaddr33       12'h3D1
    `define pmpaddr34       12'h3D2
    `define pmpaddr35       12'h3D3
    `define pmpaddr36       12'h3D4
    `define pmpaddr37       12'h3D5
    `define pmpaddr38       12'h3D6
    `define pmpaddr39       12'h3D7
    `define pmpaddr40       12'h3D8
    `define pmpaddr41       12'h3D9
    `define pmpaddr42       12'h3DA
    `define pmpaddr43       12'h3DB
    `define pmpaddr44       12'h3DC
    `define pmpaddr45       12'h3DD
    `define pmpaddr46       12'h3DE
    `define pmpaddr47       12'h3DF
    `define pmpaddr48       12'h3D0
    `define pmpaddr49       12'h3D1
    `define pmpaddr50       12'h3D2
    `define pmpaddr51       12'h3D3
    `define pmpaddr52       12'h3D4
    `define pmpaddr53       12'h3D5
    `define pmpaddr54       12'h3D6
    `define pmpaddr55       12'h3D7
    `define pmpaddr56       12'h3D8
    `define pmpaddr57       12'h3D9
    `define pmpaddr58       12'h3DA
    `define pmpaddr59       12'h3DB
    `define pmpaddr60       12'h3DC
    `define pmpaddr61       12'h3DD
    `define pmpaddr62       12'h3DE
    `define pmpaddr63       12'h3DF

    `define csr_count 107
`endif

`ifdef csr_counter
    // unprivileged counter/timers
    `define cycle           12'hC00
    `define time            12'hC01
    `define instret         12'hC02
    `define hpmcounter3     12'hC03
    `define hpmcounter4     12'hC04
    `define hpmcounter5     12'hC05
    `define hpmcounter6     12'hC06
    `define hpmcounter7     12'hC07
    `define hpmcounter8     12'hC08
    `define hpmcounter9     12'hC09
    `define hpmcounter10    12'hC0A
    `define hpmcounter11    12'hC0B
    `define hpmcounter12    12'hC0C
    `define hpmcounter13    12'hC0D
    `define hpmcounter14    12'hC0E
    `define hpmcounter15    12'hC0F
    `define hpmcounter16    12'hC10
    `define hpmcounter17    12'hC11
    `define hpmcounter18    12'hC12
    `define hpmcounter19    12'hC13
    `define hpmcounter20    12'hC14
    `define hpmcounter21    12'hC15
    `define hpmcounter22    12'hC16
    `define hpmcounter23    12'hC17
    `define hpmcounter24    12'hC18
    `define hpmcounter25    12'hC19
    `define hpmcounter26    12'hC1A
    `define hpmcounter27    12'hC1B
    `define hpmcounter28    12'hC1C
    `define hpmcounter29    12'hC1D
    `define hpmcounter30    12'hC1E
    `define hpmcounter31    12'hC1F

    // machine counter/timers
    `define mcycle          12'hB00
    `define minstret        12'hB02
    `define mhpmcounter3    12'hB03
    `define mhpmcounter4    12'hB04
    `define mhpmcounter5    12'hB05
    `define mhpmcounter6    12'hB06
    `define mhpmcounter7    12'hB07
    `define mhpmcounter8    12'hB08
    `define mhpmcounter9    12'hB09
    `define mhpmcounter10   12'hB0A
    `define mhpmcounter11   12'hB0B
    `define mhpmcounter12   12'hB0C
    `define mhpmcounter13   12'hB0D
    `define mhpmcounter14   12'hB0E
    `define mhpmcounter15   12'hB0F
    `define mhpmcounter16   12'hB10
    `define mhpmcounter17   12'hB11
    `define mhpmcounter18   12'hB12
    `define mhpmcounter19   12'hB13
    `define mhpmcounter20   12'hB14
    `define mhpmcounter21   12'hB15
    `define mhpmcounter22   12'hB16
    `define mhpmcounter23   12'hB17
    `define mhpmcounter24   12'hB18
    `define mhpmcounter25   12'hB19
    `define mhpmcounter26   12'hB1A
    `define mhpmcounter27   12'hB1B
    `define mhpmcounter28   12'hB1C
    `define mhpmcounter29   12'hB1D
    `define mhpmcounter30   12'hB1E
    `define mhpmcounter31   12'hB1F
    
    // machine counter setup
    `define mcountinhibit   12'hB20
    `define mhpmevent3      12'h323
    `define mhpmevent4      12'h324
    `define mhpmevent5      12'h325
    `define mhpmevent6      12'h326
    `define mhpmevent7      12'h327
    `define mhpmevent8      12'h328
    `define mhpmevent9      12'h329
    `define mhpmevent10     12'h32A
    `define mhpmevent11     12'h32B
    `define mhpmevent12     12'h32C
    `define mhpmevent13     12'h32D
    `define mhpmevent14     12'h32E
    `define mhpmevent15     12'h32F
    `define mhpmevent16     12'h330
    `define mhpmevent17     12'h331
    `define mhpmevent18     12'h332
    `define mhpmevent19     12'h333
    `define mhpmevent20     12'h334
    `define mhpmevent21     12'h335
    `define mhpmevent22     12'h336
    `define mhpmevent23     12'h337
    `define mhpmevent24     12'h338
    `define mhpmevent25     12'h339
    `define mhpmevent26     12'h33A
    `define mhpmevent27     12'h33B
    `define mhpmevent28     12'h33C
    `define mhpmevent29     12'h33D
    `define mhpmevent30     12'h33E
    `define mhpmevent31     12'h33F

    `define csr_count 200
`endif

    reg [63:0] csr_reg [0:`csr_count-1];

    initial $display(`csr_count);

    always @(*) begin
        csr_invalid <= 0;
        case(csr_addr)
            `sstatus:       csr_out <= csr_reg[0];
            `sie:           csr_out <= csr_reg[1];
            `stvec:         csr_out <= csr_reg[2];
            `scounteren:    csr_out <= csr_reg[3];

            `sscratch:      csr_out <= csr_reg[4];
            `sepc:          csr_out <= csr_reg[5];
            `scause:        csr_out <= csr_reg[6];
            `stval:         csr_out <= csr_reg[7];
            `sip:           csr_out <= csr_reg[8];

            `satp:          csr_out <= csr_reg[9];

            `mvendorid:     csr_out <= csr_reg[10];
            `marchid:       csr_out <= csr_reg[11];
            `mimpid:        csr_out <= csr_reg[12];
            `mhartid:       csr_out <= csr_reg[13];
            `mconfigptr:    csr_out <= csr_reg[14];

            `mstatus:       csr_out <= csr_reg[15];
            `misa:          csr_out <= csr_reg[16];
            `medeleg:       csr_out <= csr_reg[17];
            `mideleg:       csr_out <= csr_reg[18];
            `mie:           csr_out <= csr_reg[19];
            `mtvec:         csr_out <= csr_reg[20];
            `mcounteren:    csr_out <= csr_reg[21];

            `mscratch:      csr_out <= csr_reg[22];
            `mepc:          csr_out <= csr_reg[23];
            `mcause:        csr_out <= csr_reg[24];
            `mtval:         csr_out <= csr_reg[25];
            `mip:           csr_out <= csr_reg[26];
            `mtinst:        csr_out <= csr_reg[27];
            `mtval2:        csr_out <= csr_reg[28];

            `menvcfg:       csr_out <= csr_reg[29];
            `mseccfg:       csr_out <= csr_reg[30];

        `ifdef csr_fp
            `fflags:        csr_out <= csr_reg[31];
            `frm:           csr_out <= csr_reg[32];
            `fcsr:          csr_out <= csr_reg[33];
        `endif

        `ifdef csr_mmp

        `endif

        `ifdef csr_counter

        `endif
            
            default: csr_invalid <= 1;
        endcase
    end

    assign csr_wr_invalid = &csr_addr[11:10] && csr_wr;
    assign csr_pr_invalid = privilege_level < csr_addr[9:8] && (csr_wr || csr_rd);
    wire wr = csr_wr && !csr_invalid && !csr_wr_invalid && !csr_pr_invalid;

    always @(posedge clk) begin
        if(wr) begin
            case(csr_addr)
                `sstatus:        csr_reg[0]  <= csr_out;
                `sie:            csr_reg[1]  <= csr_out;
                `stvec:          csr_reg[2]  <= csr_out;
                `scounteren:     csr_reg[3]  <= csr_out;

                `sscratch:       csr_reg[4]  <= csr_out;
                `sepc:           csr_reg[5]  <= csr_out;
                `scause:         csr_reg[6]  <= csr_out;
                `stval:          csr_reg[7]  <= csr_out;
                `sip:            csr_reg[8]  <= csr_out;

                `satp:           csr_reg[9]  <= csr_out;
                                                   
                `mvendorid:      csr_reg[10] <= csr_out;
                `marchid:        csr_reg[11] <= csr_out;
                `mimpid:         csr_reg[12] <= csr_out;
                `mhartid:        csr_reg[13] <= csr_out;
                `mconfigptr:     csr_reg[14] <= csr_out;

                `mstatus:        csr_reg[15] <= csr_out;
                `misa:           csr_reg[16] <= csr_out;
                `medeleg:        csr_reg[17] <= csr_out;
                `mideleg:        csr_reg[18] <= csr_out;
                `mie:            csr_reg[19] <= csr_out;
                `mtvec:          csr_reg[20] <= csr_out;
                `mcounteren:     csr_reg[21] <= csr_out;

                `mscratch:       csr_reg[22] <= csr_out;
                `mepc:           csr_reg[23] <= csr_out;
                `mcause:         csr_reg[24] <= csr_out;
                `mtval:          csr_reg[25] <= csr_out;
                `mip:            csr_reg[26] <= csr_out;
                `mtinst:         csr_reg[27] <= csr_out;
                `mtval2:         csr_reg[28] <= csr_out;

                `menvcfg:        csr_reg[29] <= csr_out;
                `mseccfg:        csr_reg[30] <= csr_out;

            `ifdef csr_fp
                `fflags:         csr_reg[31] <= csr_out;
                `frm:            csr_reg[32] <= csr_out;
                `fcsr:           csr_reg[33] <= csr_out;
            `endif

            endcase
        end
    end

endmodule
