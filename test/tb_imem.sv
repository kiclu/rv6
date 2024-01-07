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

 `include "../hdl/config.v"

 `timescale 1ns/1ps
 module tb_imem();

    reg                  [63:0] pc;
    wire                 [31:0] ir;
    wire    [`IMEM_BLK_LEN-1:0] b_addr_i;
    reg        [`IMEM_LINE-1:0] b_data_i;
    wire                        b_rd_i;
    reg                         b_dv_i;
    reg                         stall;
    wire                        stall_imem;
    reg                         rst_n;
    reg                         clk;

    imem dut (
        .pc             (pc             ),
        .ir             (ir             ),
        .b_addr_i       (b_addr_i       ),
        .b_data_i       (b_data_i       ),
        .b_rd_i         (b_rd_i         ),
        .b_dv_i         (b_dv_i         ),
        .stall          (stall          ),
        .stall_imem     (stall_imem     ),
        .rst_n          (rst_n          ),
        .clk            (clk            )
    );

    // initial signal values
    initial begin
        pc          = 64'h8000_0000;
        b_data_i    = 'bZ;
        b_dv_i      = 0;
        stall       = 0;
        rst_n       = 0;
        #80
        rst_n       = 1;
    end

    // clock generator
    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end

    initial begin
        #160
        repeat(50) begin
            integer d;

            // random delay
            d <= $random() % 30;
            for(integer i = 0; i < d; ++i) #20;

        end

        $stop();
    end

    always @(posedge clk) begin
        if(b_rd_i) begin
        end
        else begin
            b_data_i <= 'bZ;
            b_dv_i   <= 0;
        end
    end

 endmodule
