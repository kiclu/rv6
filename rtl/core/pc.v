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

module pc (
    output reg [63:0] pc,

    input             t_taken,
    input      [63:0] t_addr,

    input             jalr_taken,
    input      [63:0] jalr_addr,

    input             pr_miss,
    input      [63:0] br_addr,

    input             jal_taken,
    input      [63:0] jal_addr,

    input             pr_taken,
    input      [12:0] pr_offs,

    input             c_ins,
    input             fence_i,
    input             stall_if,
    input             rst_n,
    input             clk
);

    wire [63:0] pr_addr = pc + {{51{pr_offs[12]}}, pr_offs};
    wire [63:0] n_pc    = pc + (c_ins ? 64'h2 : 64'h4);

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) pc <= `RESET_VECTOR;
        else if(t_taken)            pc <= t_addr;
        else if(jalr_taken)         pc <= jalr_addr;
        else if(fence_i && pr_miss) pc <= br_addr;
        else if(!stall_if) begin
            if(pr_miss)             pc <= br_addr;
            else if(jal_taken)      pc <= jal_addr;
            else if(pr_taken)       pc <= pr_addr;
            else                    pc <= n_pc;
        end
    end

endmodule
