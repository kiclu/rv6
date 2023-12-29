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

// default hex path
`ifndef hex_path

`define hex_path "../test/c/fib/fib.hex"            // test 0
//`define hex_path "../test/c/fib_c/fib_c.hex"        // test 1
//`define hex_path "../test/c/mhartid/mhartid.hex"    // test 2
//`define hex_path "../test/c/deadbeef/deadbeef.hex"  // test 3
//`define hex_path "../test/c/shift/shift.hex"        // test 4

//`define hex_path "../../../temp/dromajo/riscv-simple-tests/rv64ua-p-amoadd_d.hex"

//`define hex_path "../test/c/ecall/ecall.hex"
//`define hex_path "../test/c/ima/ima.hex"
`endif

`define tb_mem_size  32'h0001_0000
`define tb_mem_entry 64'h8000_0000

`define DROMOJO_TRACE
`define AMO_ENABLE
`define REG_TRACE

`include "../hdl/config.v"

`timescale 1ns/1ps
module tb_hart();
    wire           [63:0] h_addr;

    reg  [`hmem_line-1:0] h_data_in;
    wire                  h_rd;
    reg                   h_dv;

    wire [`hmem_line-1:0] h_data_out;
    wire                  h_wr;

    reg            [63:0] h_inv_addr;
    reg                   h_inv;

    wire                  h_amo_req;
    reg                   h_amo_ack;

    reg                   h_rst_n;
    reg                   h_clk;

    hart #(.HART_ID(0)) dut(
        .h_addr(h_addr),

        .h_data_in(h_data_in),
        .h_rd(h_rd),
        .h_dv(h_dv),

        .h_data_out(h_data_out),
        .h_wr(h_wr),

        .h_inv_addr(h_inv_addr),
        .h_inv(h_inv),

        .h_amo_req(h_amo_req),
        .h_amo_ack(h_amo_ack),

        .h_rst_n(h_rst_n),

        .h_clk(h_clk)
    );

    reg [7:0] mem [`tb_mem_entry : `tb_mem_entry+`tb_mem_size-1];
    initial begin
        $readmemh(`hex_path, mem, `tb_mem_entry);
        for(integer i = `tb_mem_entry; i < `tb_mem_entry+`tb_mem_size; ++i) begin
            if(mem[i] === 8'hX) mem[i] <= 8'h00;
        end
    end

    initial forever #10 h_clk = ~h_clk;
    wire clk = h_clk;

    initial begin
        h_data_in <= `hmem_line'hZ;
        h_dv <= 0;
        h_inv_addr <= 64'hZ;
        h_inv <= 0;
        h_amo_ack <= 0;
        h_rst_n <= 0;
        h_clk <= 1;
        #80
        h_rst_n <= 1;
    end

    // data in
    always @(h_rd) begin
        if(h_rd) begin
            #800
            for(integer i = 0; i < `hmem_line/8; ++i) begin
                h_data_in[8*i +: 8] = mem[h_addr + i];
            end
            h_dv = 1;
            #20
            h_data_in = `hmem_line'bZ;
            h_dv = 0;
        end
        else begin
            h_data_in = 'bZ;
            h_dv = 0;
        end
    end

    // data out
    always @(posedge clk) begin
        if(h_wr) begin
            for(integer i = 0; i < `hmem_line/8; ++i) begin
                mem[h_addr + i] = h_data_out[8*i +: 8];
            end
        end
    end

`ifdef AMO_ENABLE
    // amo handshake
    always @(*) begin
        if(h_amo_req) h_amo_ack <= #160 1;
        else h_amo_ack <= #0 0;
    end
`endif

`ifdef DROMOJO_TRACE
    int fd;
    initial fd = $fopen("trace", "w");

    reg [63:0] bmw_pc;
    always @(posedge clk) begin
        if(!dut.stall_mem) begin
            bmw_pc <= dut.bxm_pc;
        end
    end

    reg init = 0;

    // print destination register and value on instruction retire
    always @(posedge clk) begin
        if(bmw_pc == `tb_mem_entry) init = 1;
        if(init) begin
            if(!dut.stall_wb && dut.wr && dut.rd) begin
                $fdisplay(
                    fd,
                    "0 %1d 0x%016h (0x%08h) x%2d 0x%016h",
                    dut.u_csr.privilege_level,
                    bmw_pc,
                    dut.bmw_ir,
                    dut.rd,
                    dut.d
                );
            end
            else if(!dut.stall_wb) begin
                $fdisplay(
                    fd,
                    "0 %1d 0x%016h (0x%08h)",
                    dut.u_csr.privilege_level,
                    bmw_pc,
                    dut.bmw_ir,
                );
            end
        end
    end
`endif

`ifdef MEM_TRACE
    reg [63:0] addr;
    reg [2:0] cnt;

    always @(posedge clk) begin
        if(h_wr) begin
            cnt <= 7'd7;
            addr <= h_addr;
        end
        if(cnt == 3'd1) begin
            $display("WRITE: addr=%h", addr);
            for(integer i = `hmem_line/8 - 1; i >= 0; --i) begin
                $display("MEM[%h] = %h", addr+i, mem[addr+i]);
            end
        end
        if(cnt) cnt <= cnt - 1;
    end
`endif

    /* SIMULATION CONTROL */

`ifdef REG_TRACE
    function automatic string decode_r(logic [4:0] r);
        case(r)
            5'd0:  return "zero";
            5'd1:  return "ra";
            5'd2:  return "sp";
            5'd3:  return "gp";
            5'd4:  return "tp";
            5'd5:  return "t0";
            5'd6:  return "t1";
            5'd7:  return "t2";
            5'd8:  return "fp";
            5'd9:  return "s1";
            5'd10: return "a0";
            5'd11: return "a1";
            5'd12: return "a2";
            5'd13: return "a3";
            5'd14: return "a4";
            5'd15: return "a5";
            5'd16: return "a6";
            5'd17: return "a7";
            5'd18: return "s2";
            5'd19: return "s3";
            5'd20: return "s4";
            5'd21: return "s5";
            5'd22: return "s6";
            5'd23: return "s7";
            5'd24: return "s8";
            5'd25: return "s9";
            5'd26: return "s10";
            5'd27: return "s11";
            5'd28: return "t3";
            5'd29: return "t4";
            5'd30: return "t5";
            5'd31: return "t6";
            default: return "xx";
        endcase
    endfunction
`endif

    task end_sim();
`ifdef REG_TRACE
        $display("hex_p=%s", `hex_path);
        $display("end_time=%0t", $time());
        for(integer i = 1; i < 32; ++i) begin
            $display("%0s=0x%0h", decode_r(i), dut.u_regfile.register[i]);
        end
`endif
        $stop();
    endtask

    initial #200000 end_sim();
    always @(*) if(dut.bmw_ir === 32'h0000006f) end_sim();

endmodule
