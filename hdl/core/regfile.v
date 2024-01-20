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

module regfile (
    output  [63:0] rs1_data,
    input   [ 4:0] rs1,

    output  [63:0] rs2_data,
    input   [ 4:0] rs2,

    input   [63:0] rd_data,
    input   [ 4:0] rd,
    input          we,

    input          rst_n,
    input          clk
);

    (* ram_style = "registers" *)
    reg [63:0] reg_data [1:31];

    /* REGISTER OUTPUT */

    wire [63:0] reg_data_out [0:31];
    genvar i;
    generate
        for(i = 1; i < 32; i = i + 1) begin
            assign reg_data_out[i] = reg_data[i];
        end
    endgenerate
    assign reg_data_out[0] = 64'b0;

    /* OUTPUT MUX */

    assign rs1_data = reg_data_out[rs1];
    assign rs2_data = reg_data_out[rs2];

    /* REGISTER WRITE */

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) begin : regfile_reset
            integer i;
            for(i = 1; i < 32; i = i + 1) reg_data[i] <= 64'b0;
        end
        else if(we) reg_data[rd] <= rd_data;
    end

endmodule
