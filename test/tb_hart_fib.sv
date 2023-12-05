`ifdef __ICARUS__
    `define program_hex_path "test/c/fib/fib.hex"
    `define mem_final_path   "test/out/tb_hart_fib_mem.hex"
    `define finish(X) $finish(X)
`else
    `define program_hex_path "../test/c/fib/fib.hex"
    `define mem_final_path   "../test/out/tb_hart_fib_mem.hex"
    `define finish(X) $stop(X)
`endif

`include "../hdl/config.v"

`timescale 1ns/1ps
module tb_hart_fib();

/*
    wire           [63:0] b_addr_i;
    reg  [`hmem_line-1:0] b_data_i;
    wire                  b_rd_i;
    reg                   b_dv_i;

    wire           [63:0] b_addr;

    reg  [`hmem_line-1:0] b_data_in;
    wire                  b_rd;
    reg                   b_dv;

    wire [`hmem_line-1:0] b_data_out;
    wire                  b_wr;

    reg                   rst_n;
    reg                   clk;
*/

    wire [63:0] h_addr;

    reg [`hmem_line-1:0] h_data_in;
    wire h_rd;
    reg h_dv;

    wire [`hmem_line-1:0] h_data_out;
    wire h_wr;

    reg [63:0] inv_addr;
    reg inv;

    reg rst_n;
    reg clk;

    reg [7:0] rom [0:4095];
    reg [7:0] ram [0:32767];

    initial begin
        inv_addr  = 64'h0;
        inv       = 1'b0;

        h_data_in = `dmem_line'bZ;
        h_dv      = 1'b0;

        rst_n     = 1'b0;

        clk       = 1'b1;

        forever #10 clk = ~clk;
    end

    initial $readmemh(`program_hex_path, rom, 0);

    initial begin
        for(integer i = 0; i < 4096; ++i) begin
            if(rom[i] === 8'bxxxxxxxx) rom[i] = 8'b0;
        end
        for(integer i = 0; i < 32768; ++i) ram[i] = 8'b0;
    end

    initial begin
        #40
        rst_n = 1'b1;
        #20000
        $writememh(`mem_final_path, ram, 0);
        `finish();
    end

    always @(posedge clk) begin
        if(h_rd) begin
            #320
            if(h_addr < 64'h8000_0000) begin
                for(integer i = 0; i < `hmem_line/8; ++i) begin
                    h_data_in[8*i +: 8] = ram[h_addr + i];
                end
            end
            else begin
                for(integer i = 0; i < `hmem_line/8; ++i) begin
                    h_data_in[8*i +: 8] = rom[h_addr + i - 64'h8000_0000];
                end
            end
            h_dv = 1;
            #20
            h_data_in = `hmem_line'bZ;
            h_dv      = 0;
        end
        if(h_wr) begin
            for(integer i = 0; i < `hmem_line/8; ++i) begin
                ram[h_addr + i] = h_data_out[8*i +: 8];
            end
        end
    end

    hart dut(
        .h_addr(h_addr),

        .h_data_in(h_data_in),
        .h_rd(h_rd),
        .h_dv(h_dv),

        .h_data_out(h_data_out),
        .h_wr(h_wr),

        .inv_addr(inv_addr),
        .inv(inv),

        .rst_n(rst_n),

        .clk(clk)
    );

endmodule
