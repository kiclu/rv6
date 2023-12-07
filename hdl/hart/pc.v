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

module pc(
    output reg [63:0] pc,

    input             jalr_taken,
    input      [63:0] jalr_addr,

    input             pr_miss,
    input      [63:0] br_addr,

    input             jal_taken,
    input      [63:0] jal_addr,

    input             pr_taken,
    input      [12:0] pr_offs,

    input             stall,

    input             rst_n,

    input             clk
);

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) pc <= 64'h80000000;
        else if(!stall) begin
            if(pr_miss) pc <= br_addr;
            else if(jalr_taken) pc <= jalr_addr;
            else if(jal_taken) pc <= jal_addr;
            else if(pr_taken) pc <= pc + {{51{pr_offs[12]}}, pr_offs};
            else pc <= pc + 4;
        end
    end

endmodule
