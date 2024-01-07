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
 module tb_dmem();

    reg                  [63:0] addr;
    reg                  [ 2:0] len;
    reg                  [63:0] data_in;
    reg                         wr;
    wire                 [63:0] data_out;
    reg                         rd;
    wire                        ld_ma;
    wire                        st_ma;
    wire    [`DMEM_BLK_LEN-1:0] b_addr_d;
    reg        [`DMEM_LINE-1:0] b_data_in_d;
    wire                        b_rd_d;
    reg                         b_dv_d;
    reg     [`DMEM_BLK_LEN-1:0] inv_addr;
    reg                         inv;
    wire                        stall_dmem;
    reg                         rst_n;
    reg                         clk;

    dmem dut (
        .addr           (addr           ),
        .len            (len            ),
        .data_in        (data_in        ),
        .wr             (wr             ),
        .data_out       (data_out       ),
        .rd             (rd             ),
        .ld_ma          (ld_ma          ),
        .st_ma          (st_ma          ),
        .b_addr_d       (b_addr_d       ),
        .b_data_in_d    (b_data_in_d    ),
        .b_rd_d         (b_rd_d         ),
        .b_dv_d         (b_dv_d         ),
        .inv_addr       (inv_addr       ),
        .inv            (inv            ),
        .stall_dmem     (stall_dmem     ),
        .rst_n          (rst_n          ),
        .clk            (clk            )
    );

    // initial signal values
    initial begin
        addr        = 64'bZ;
        len         = 3'b0;
        data_in     = 64'bZ;
        wr          = 0;
        rd          = 0;
        b_data_in_d = 'bZ;
        b_dv_d      = 0;
        inv_addr    = 'bZ;
        inv         = 0;
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
            bit r_wn;

            addr <= {$random(), $random()};
            len  <= $random();

            // read / ~write
            r_wn <= $random() % 2;

            // random delay
            d <= $random() % 30;
            for(integer i = 0; i < d; ++i) #20;

            if(r_wn) begin
                // READ
                rd <= 1;
                while(stall_dmem) #20;
                #20
                rd <= 0;
            end
            else begin
                // WRITE
                data_in <= {$random, $random};

                wr <= 1;
                while(stall_dmem) #20;
                #20
                wr <= 0;
            end
        end

        $stop();
    end

    always @(posedge clk) begin
        if(b_rd_d) begin
            #80
            b_data_in_d <= $random();
            b_dv_d      <= 1;
            #20
            b_data_in_d <= 'bZ;
            b_dv_d      <= 0;
            #40
            b_data_in_d <= 'bZ;
            b_dv_d      <= 0;
        end
        else begin
            b_data_in_d <= 'bZ;
            b_dv_d      <= 0;
        end
    end

 endmodule
