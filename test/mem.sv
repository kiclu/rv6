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

`define TB_MEM_START_ADDR   64'h8000_0000
`define TB_MEM_SIZE         64'h10_0000
`define TB_MEM_DELAY        8

module mem (
    input                 [63:0] addr,
    input                 [63:0] wdata,
    output      [`CMEM_LINE-1:0] rdata,
    input                 [ 1:0] len,
    input                        rd,
    input                        wr,
    output                       dv,
    input                        rst_n,
    input                        clk
);

    /* READ RISING EDGE */

    reg rd_d;
    always @(posedge clk) rd_d <= rd;
    assign rd_re = rd && !rd_d;

    /* WRITE RISING EDGE */

    reg wr_d;
    always @(posedge clk) wr_d <= wr;
    assign wr_re = wr && !wr_d;

    /* MEMORY MODEL */

    reg  [7:0] mem [`TB_MEM_START_ADDR:`TB_MEM_START_ADDR+`TB_MEM_SIZE];

    reg  [`CMEM_LINE-1:0] data_out_buffer [0:`TB_MEM_DELAY-1];
    reg                   data_valid [0:`TB_MEM_DELAY-1];

    always @(posedge clk) begin
        if(!rst_n) begin
            for(integer i = 0; i < `TB_MEM_DELAY; ++i) begin
                data_out_buffer[i]  <= 'bZ;
                data_valid[i]       <= 0;
            end
        end
        else begin
            if(wr_re) begin
                //$display(
                //    "WRITE: %-16h @ %-16h; len=%3b",
                //    wdata,
                //    addr,
                //    len
                //);
                for(integer i = 0; i < (2**len); ++i) begin
                    mem[addr + i] <= wdata[8*i +: 8];
                end
            end

            if(rd_re) begin
                //$display(
                //    "READ: @ %-16h",
                //    addr
                //);
                for(integer i = 0; i < `CMEM_LINE/8; ++i) begin
                    data_out_buffer[`TB_MEM_DELAY-1][8*i +: 8] <= mem[addr + i];
                end
                data_valid[`TB_MEM_DELAY-1] <= 1;
            end
            else begin
                data_out_buffer[`TB_MEM_DELAY-1] <= 'bZ;
                data_valid     [`TB_MEM_DELAY-1] <= 0;
            end

            for(integer i = 0; i < `TB_MEM_DELAY - 1; ++i) begin
                data_out_buffer[i]  <= data_out_buffer[i+1];
                data_valid[i]       <= data_valid[i+1];
            end
        end
    end

    assign rdata = data_out_buffer[0];
    assign dv    = data_valid[0];

    task read_hex(string filename);
        $readmemh(filename, mem, `TB_MEM_START_ADDR);
        for(integer i = 0; i < `TB_MEM_SIZE; ++i) begin
            if(mem[i] === 8'hX) mem[i] <= 8'h00;
        end
    endtask

endmodule
