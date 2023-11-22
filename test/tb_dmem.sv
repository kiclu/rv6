`ifdef __ICARUS__
    `define mem_final_path   "test/out/tb_dmem_mem.hex"
    `define finish(X) $finish(X)
`else
    `define mem_final_path   "../test/out/tb_dmem_mem.hex"
    `define finish(X) $stop(X)
`endif

`include "../hdl/config.v"

`timescale 1ns/1ps
module tb_dmem();

    reg            [63:0] addr;
    reg            [ 2:0] len;

    wire           [63:0] data_out;
    reg                   rd;

    reg            [63:0] data_in;
    reg                   wr;

    wire           [63:0] b_addr;

    reg  [`dmem_line-1:0] b_data_in;
    wire                  b_rd;
    reg                   b_dv;

    wire [`dmem_line-1:0] b_data_out;
    wire                  b_wr;

    reg                   clr_n;
    reg                   clk;

    reg [7:0] ram [0:32768];

    initial begin
        for(integer i = 0; i < 32768; ++i) begin
            if(ram[i] === 8'bxxxxxxxx) ram[i] = 8'b0;
        end
    end

    initial begin
        addr = {64{1'bZ}};
        len = 3'b000;

        rd = 0;

        data_in = {64{1'bZ}};
        wr = 0;

        b_data_in = {`dmem_line{1'bZ}};
        b_dv = 0;

        clr_n = 0;

        clk = 1;

        forever #10 clk = ~clk;
    end

    initial begin
        #40
        clr_n = 1'b1;
        #40
        addr = 64'h0;
        len = 3'b001;
        data_in = 64'hFF;
        wr = 1;
        #120
        wr = 0;
        #200
        addr = 64'h1000;
        len = 3'b000;
        rd = 1;
        #120
        rd = 0;
        #100
        addr = 64'h000;
        len = 3'b000;
        rd = 1;
        #80
        rd = 0;
        
        #200
        $writememh(`mem_final_path, ram, 0);
        `finish();
    end

    always @(posedge clk) begin
        if(b_rd) begin
            #80
            for(integer i = 0; i < `dmem_line/8; ++i) begin
                b_data_in[8*i +: 8] = ram[b_addr + i];
            end
            b_dv = 1;
            #20
            b_data_in = {`dmem_line{1'bZ}};
            b_dv      = 0;
        end
        if(b_wr) begin
            for(integer i = 0; i < `dmem_line/8; ++i) begin
                ram[b_addr + i] = b_data_out[8*i +: 8];
            end
        end
    end

    dmem dut(
        .addr(addr),
        .len(len),

        .data_out(data_out),
        .rd(rd),

        .data_in(data_in),
        .wr(wr),

        .b_addr(b_addr),

        .b_data_in(b_data_in),
        .b_rd(b_rd),
        .b_dv(b_dv),

        .b_data_out(b_data_out),
        .b_wr(b_wr),

        .clr_n(clr_n),

        .clk(clk)
    );

endmodule
