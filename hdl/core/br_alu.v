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

module br_alu (
    input      [63:0] pc,
    input      [31:0] ir,

    input      [63:0] r1,
    input      [63:0] r2,

    output            jalr_taken,
    output     [63:0] jalr_addr,

    output            pr_miss,
    output     [63:0] br_addr,

    input             pr_taken,

    input             stall
);

    // JALR
    assign jalr_taken = !stall && ir[6:0] == 7'b1100111;
    assign jalr_addr  = r1 + {{52{ir[31]}}, ir[31:21], 1'b0};

    // branch offset calculation
    wire [63:0] br_offs = {{51{ir[31]}}, ir[31], ir[7], ir[30:25], ir[11:8], 1'b0};

    // branch instruction check
    wire branch    = ir[6:0] == 7'b1100011;

    // branch prediction miss check
    reg brc = 0;
    assign pr_miss = (pr_taken != brc) && branch;
    assign br_addr = brc ? pc + br_offs : pc + 4;

    // branch condition evaluation
    wire signed [63:0] r1s = r1;
    wire signed [63:0] r2s = r2;
    always @(*) begin
        case(ir[14:12])
            3'b000:  brc <= (r1   ==  r2);
            3'b001:  brc <= (r1   !=  r2);
            3'b100:  brc <= (r1s  <   r2s);
            3'b101:  brc <= (r1s  >=  r2s);
            3'b110:  brc <= (r1   <   r2);
            3'b111:  brc <= (r1   >=  r2);
            default: brc <= 0;
        endcase
    end

endmodule
