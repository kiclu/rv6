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

`include "../hdl/config.vh"

`define TRANSACTION_COUNT 1

`timescale 1ns/1ps
module tb_cmem();

    reg                  [63:0] b_addr_w;
    reg                  [ 2:0] b_len_w;
    reg                  [63:0] b_wdata_w;
    reg                         b_wr_w;
    reg     [`IMEM_BLK_LEN-1:0] b_addr_i;
    wire       [`IMEM_LINE-1:0] b_data_i;
    reg                         b_rd_i;
    wire                        b_dv_i;
    reg     [`DMEM_BLK_LEN-1:0] b_addr_d;
    wire       [`DMEM_LINE-1:0] b_rdata_d;
    reg                         b_rd_d;
    wire                        b_dv_d;
    wire    [`CMEM_BLK_LEN-1:0] b_addr_c;
    reg        [`CMEM_LINE-1:0] b_rdata_c;
    wire                        b_rd_c;
    reg                         b_dv_c;
    reg     [`CMEM_BLK_LEN-1:0] inv_addr;
    reg                         inv;
    wire                        stall_cmem;
    reg                         rst_n;
    reg                         clk;

    cmem dut (
        .b_addr_w       (b_addr_w       ),
        .b_len_w        (b_len_w        ),
        .b_wdata_w      (b_wdata_w      ),
        .b_wr_w         (b_wr_w         ),
        .b_addr_i       (b_addr_i       ),
        .b_data_i       (b_data_i       ),
        .b_rd_i         (b_rd_i         ),
        .b_dv_i         (b_dv_i         ),
        .b_addr_d       (b_addr_d       ),
        .b_rdata_d      (b_rdata_d      ),
        .b_rd_d         (b_rd_d         ),
        .b_dv_d         (b_dv_d         ),
        .b_addr_c       (b_addr_c       ),
        .b_rdata_c      (b_rdata_c      ),
        .b_rd_c         (b_rd_c         ),
        .b_dv_c         (b_dv_c         ),
        .inv_addr       (inv_addr       ),
        .inv            (inv            ),
        .stall_cmem     (stall_cmem     ),
        .rst_n          (rst_n          ),
        .clk            (clk            )
    );

    // initial signal values
    initial begin
        b_addr_w    = 0;
        b_len_w     = 'bZ;
        b_wdata_w   = 'bZ;
        b_wr_w      = 0;
        b_addr_i    = 0;
        b_rd_i      = 0;
        b_addr_d    = 0;
        b_rd_d      = 0;
        b_rdata_c   = 'bZ;
        b_dv_c      = 0;
        inv_addr    = 'bZ;
        inv         = 0;
        rst_n       = 0;
        #80
        rst_n       = 1;
    end

    // clock generation
    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end

    initial begin
        #160

        while(!b_rd_c) #20;

        #160;
        b_rdata_c   = $random();
        b_dv_c      = 1;
        #20
        b_rdata_c   = 'bZ;
        b_dv_c      = 0;
    end

    initial begin
        repeat(`TRANSACTION_COUNT) begin
            #320;
            b_addr_d    = $random();
            b_rd_d      = 1;

            while(!b_dv_d) #20;
            #20;

            b_rd_d      = 0;
        end
        #2000
        $stop();
    end

endmodule
