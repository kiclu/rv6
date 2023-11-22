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

`define core_count 6

`define phy_addr 48

module rv6(
    output [`phy_addr-1:0] addr,
    input [15:0] data_in,
    output [15:0] data_out,

    output r,
    output w,

    input dbv,

    input rst_n,
    input clk
);

    wire [63:0] b_addr_i;
    wire b_rd_i;
    wire b_dv_i = dbv && b_rd_i;
    
    wire [63:0] b_addr;

    wire b_rd;
    wire b_dv = dbv && !b_rd_i;

    wire [`phy_addr-1:0] b_data_out;
    wire b_wr;

    assign addr = b_rd_i ? b_addr_i[`phy_addr-1:0] : b_addr[`phy_addr-1:0];
    assign r = b_rd_i || b_rd;
    assign w = b_wr && !r;

    hart #(.HART_ID(0)) inst_hart (
        .b_addr_i(b_addr_i),
        .b_data_i(data_in),
        .b_rd_i(b_rd_i),
        .b_dv_i(b_dv_i),

        .b_addr(b_addr),

        .b_data_in(data_in),
        .b_rd(b_rd),
        .b_dv(b_dv),

        .b_data_out(data_out),
        .b_wr(b_wr),

        .rst_n(rst_n),
        
        .clk(clk)
    );

    //genvar h_id;
    //generate
    //    for(h_id = 0; h_id < `core_count; h_id = h_id + 1) begin
    //        hart #(.HART_ID(h_id)) inst_hart (
    //            .b_addr_i(),
    //            .b_data_i(),
    //            .b_rd_i(),
    //            .b_dv_i(),

    //            .b_addr(),

    //            .b_data_in(),
    //            .b_rd(),
    //            .b_dv(),

    //            .b_data_out(),
    //            .b_wr(),

    //            .rst_n(rst_n),

    //            .clk(clk)
    //        );
    //    end
    //endgenerate
    

endmodule
