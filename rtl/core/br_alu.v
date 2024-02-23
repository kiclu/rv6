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

module br_alu (
    input      [63:0] pc,
    input      [31:0] ir,

    input      [63:0] rs1_data,
    input      [63:0] rs2_data,

    output            jalr_taken,
    output     [63:0] jalr_addr,

    output            pr_miss,
    output     [63:0] br_addr,

    input             pr_taken,

    input             stall_id,
    input             rst_n
);

    // JALR
    assign jalr_taken = !stall_id && ir[6:0] == `OP_JALR;
    assign jalr_addr  = rs1_data + {{52{ir[31]}}, ir[31:21], 1'b0};

    // branch offset calculation
    wire [63:0] br_offs = {{51{ir[31]}}, ir[31], ir[7], ir[30:25], ir[11:8], 1'b0};

    // branch instruction check
    wire branch    = ir[6:0] == `OP_BRANCH;

    // branch prediction miss check
    reg brc;
    assign pr_miss = !stall_id && pr_taken != brc && branch;
    assign br_addr = brc ? pc + br_offs : pc + 4;

    // branch condition evaluation
    wire signed [63:0] rs1_data_s = rs1_data;
    wire signed [63:0] rs2_data_s = rs2_data;
    always @(*) begin
        case(ir[14:12])
            3'b000:  brc = (rs1_data   ==  rs2_data);
            3'b001:  brc = (rs1_data   !=  rs2_data);
            3'b100:  brc = (rs1_data_s <   rs2_data_s);
            3'b101:  brc = (rs1_data_s >=  rs2_data_s);
            3'b110:  brc = (rs1_data   <   rs2_data);
            3'b111:  brc = (rs1_data   >=  rs2_data);
            default: brc = 0;
        endcase
    end

endmodule
