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

module bpu(
    input      [63:0] pc,
    input      [31:0] ir,

    output            jal_taken,
    output     [63:0] jal_addr,

    output            pr_taken,
    output     [12:0] pr_offs,

    input             rst_n
);

`ifdef bpu_static_taken
    // static branch prediction, all jumps taken
    assign pr_taken = ir[6:0] == 7'b1100011;
`endif

`ifdef bpu_static_ntaken
    // static branch prediction, all jumps not taken
    assign pr_taken = 0;
`endif

`ifdef bpu_static_btaken
    // static branch prediction, backward jumps taken, forward jumps not taken
    assign pr_taken = ir[6:0] == 7'b1100011 && ir[31];
`endif


    assign pr_offs  = {ir[31], ir[7], ir[30:25], ir[11:8], 1'b0};

    wire        j_taken   = ir[6:0] == 7'b1101111;
    wire        j_taken_c = ir[15:13] == 3'b101 && ir[1:0] == 2'b01;

    wire [63:0] j_addr    = pc + {{43{ir[31]}}, ir[31], ir[19:12], ir[20], ir[30:21], 1'b0};
    wire [63:0] j_addr_c  = pc + {{52{ir[12]}}, ir[12], ir[8], ir[10:9], ir[6], ir[7], ir[2], ir[11], ir[5:3], 1'b0};

    assign jal_taken = j_taken | j_taken_c;
    assign jal_addr  = j_taken ? j_addr : j_addr_c;

endmodule
