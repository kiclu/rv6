`timescale 1ns/1ps
module tb_hart();

    wire [  63:0] b_addr_i;
    reg  [1023:0] b_data_i;
    wire          b_rd_i;
    reg           b_dv_i;

    wire [  63:0] b_addr;

    reg  [1023:0] b_data_in;
    wire          b_rd;
    reg           b_dv;

    wire [1023:0] b_data_out;
    wire          b_wr;

    reg           rst_n;

    reg           clk;

    initial begin
        b_data_i  = 1024'bZ;
        b_dv_i    = 1'b0;

        b_data_in = 1024'bZ;
        b_dv      = 1'b0;

        rst_n     = 1'b0;

        clk       = 1'b1;

        forever #10 clk = ~clk;
    end


    reg [7:0] rom [0:4096];
    reg [7:0] ram [0:4096];

    initial begin
        $readmemh("../test/program/rv6.hex", rom, 0);
    end

    initial begin
        $dumpfile("vcd/tb_hart.vcd");
        $dumpvars(0, tb_hart);
        #20
        rst_n = 1'b1;
        #100000
        $stop();
    end

    always @(posedge clk) begin
        if(b_rd_i) begin
            #80
            for(integer i = 0; i < 128; ++i) begin
                b_data_i[8*i+7 -: 8] = rom[b_addr_i + i - 64'h80000000];
            end
            b_dv_i = 1;
            #20
            b_data_i = 1024'bZ;
            b_dv_i   = 0;
        end
        if(b_rd) begin
            #80
            for(integer i = 0; i < 128; ++i) begin
                b_data_in[8*i+7 -: 8] = 8'b0; //ram[b_addr + i];
            end
            b_dv = 1;
            #20
            b_data_in = 1024'bZ;
            b_dv      = 0;
        end
        if(b_wr) begin
            for(integer i = 0; i < 128; ++i) begin
                ram[b_addr + i] <= b_data_out[8*i+7 -: 8];
            end
        end
    end

    hart dut(
        .b_addr_i(b_addr_i),
        .b_data_i(b_data_i),
        .b_rd_i(b_rd_i),
        .b_dv_i(b_dv_i),

        .b_addr(b_addr),

        .b_data_in(b_data_in),
        .b_rd(b_rd),
        .b_dv(b_dv),

        .b_data_out(b_data_out),
        .b_wr(b_wr),

        .rst_n(rst_n),

        .clk(clk)
    );

endmodule
