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
`define hex_path "../test/c/fib/fib.hex"
`endif

`define tb_mem_size  32'h0001_0000
`define tb_mem_entry 32'h8000_0000

`include "../hdl/config.v"
`include "../hdl/hart/csr.v"

`define DEBUG_FETCH

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

    // memory bus
    always @(posedge clk) begin
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
        if(h_wr) begin
            for(integer i = 0; i < `hmem_line/8; ++i) begin
                mem[h_addr + i] = h_data_out[8*i +: 8];
            end
        end
    end

    // amo handshake
    always @(*) begin
        if(h_amo_req) h_amo_ack <= #160 1;
        else h_amo_ack <= #0 0;
    end

`ifdef DEBUG_RETIRE
    // print destination register and value on instruction retire
    always @(posedge clk) begin
        if(!dut.stall_wb && dut.wr && dut.rd) begin
            $display("RETIRE @%8t: %8s : rd=%4s, d=%h",
                $time(),
                decode_ir(dut.bmw_ir),
                decode_r(dut.bmw_ir[11:7]),
                dut.d
            );
        end
    end
`endif


`ifdef DEBUG_FORWARD
    reg [31:0] wb_fw_ir;
    always @(posedge clk) if(!dut.stall_wb) wb_fw_ir <= dut.bmw_ir;

    // print forwarding in pipeline
    always @(posedge clk) begin
        if(dut.a_fw || dut.b_fw) begin
            $display("====================");
            $display("FORWARD @%8t : %s %s, %s, %s", $time, decode_ir(dut.bdx_ir), decode_r(dut.bdx_ir[11:7]), decode_r(dut.bdx_ir[19:15]), decode_r(dut.bdx_ir[24:20]));
            if(dut.a_fw) begin
                case(dut.s_mx_a_fw)
                    0: begin
                        $display("a_fw_ex:  %s %s, %s, %s", decode_ir(dut.bxm_ir), decode_r(dut.bxm_ir[11:7]), decode_r(dut.bxm_ir[19:15]), decode_r(dut.bxm_ir[24:20]));
                    end
                    1: begin
                        $display("a_fw_mem: %s %s, %s, %s", decode_ir(dut.bmw_ir), decode_r(dut.bmw_ir[11:7]), decode_r(dut.bmw_ir[19:15]), decode_r(dut.bmw_ir[24:20]));
                    end
                    2: begin
                        $display("a_fw_wb:  %s %s, %s, %s", decode_ir(wb_fw_ir), decode_r(wb_fw_ir), decode_r(wb_fw_ir), decode_r(wb_fw_ir));
                    end
                endcase
            end
            if(dut.b_fw) begin
                case(dut.s_mx_b_fw)
                    0: begin
                        $display("b_fw_ex:  %s %s, %s, %s", decode_ir(dut.bxm_ir), decode_r(dut.bxm_ir[11:7]), decode_r(dut.bxm_ir[19:15]), decode_r(dut.bxm_ir[24:20]));
                    end
                    1: begin
                        $display("b_fw_mem: %s %s, %s, %s", decode_ir(dut.bmw_ir), decode_r(dut.bmw_ir[11:7]), decode_r(dut.bmw_ir[19:15]), decode_r(dut.bmw_ir[24:20]));
                    end
                    2: begin
                        $display("b_fw_wb:  %s %s, %s, %s", decode_ir(wb_fw_ir), decode_r(wb_fw_ir), decode_r(wb_fw_ir), decode_r(wb_fw_ir));
                    end
                endcase
            end
            $display("====================");
        end
    end
`endif

`ifdef DEBUG_FETCH
    always @(posedge clk) begin
        if(!dut.stall_wb && dut.wr && dut.rd) begin
            $display(
                "IR@IF @%8t: %8s : PC=%8h, IR=%8h",
                $time(),
                decode_ir(dut.ir),
                dut.pc,
                dut.ir
            );
        end
    end
`endif

    /* PC INFO */

    wire stall_pc = dut.u_pc.stall;
    always @(posedge clk) begin
        if(dut.u_pc.trap) $display("PC    @%8t: TRAP, nPC=%h", $time(), dut.u_pc.trap_addr);
        else if(dut.u_pc.pr_miss) $display("PC    @%8t: BRANCH PREDICT MISS, nPC=%h", $time(), dut.u_pc.br_addr);
        else if(dut.u_pc.jalr_taken) $display("PC    @%8t: JALR TAKEN, nPC=%h", $time(), dut.u_pc.jalr_addr);
        else if(dut.u_pc.jal_taken && !stall_pc) $display("PC    @%8t: JAL TAKEN, nPC=%h", $time(), dut.u_pc.jal_addr);
        else if(dut.u_pc.pr_taken && !stall_pc) $display("");
        //else if(!stall) $display("");
    end


    /* CSR INFO */

    always @(posedge dut.u_csr.csr_addr_invalid) begin
        $display("CSR   @%8t: csr_addr_invalid: %s(%h)!", $time(), decode_csr(), dut.u_csr.csr_addr);
    end

    always @(posedge dut.u_csr.csr_wr_invalid) begin
        $display("CSR   @%8t: csr_wr_invalid: %s", $time(), decode_csr());
    end

    always @(posedge dut.u_csr.csr_pr_invalid) begin
        $display("CSR   @%8t: csr_pr_invalid: %s!", $time(), decode_csr());
    end

    always @(dut.u_csr.csr_reg) begin
        $display("CSR   @%8t: t%0s=%0h", $time(), decode_csr(), dut.u_csr.ncsr);
    end


    /* SIMULATION CONTROL */

    task end_sim();
        $display("hex_p=%s", `hex_path);
        $display("end_time=%0t", $time());
        for(integer i = 1; i < 32; ++i) begin
            $display("%0s=0x%0h", decode_r(i), dut.u_regfile.register[i]);
        end
        $stop();
    endtask

    initial #20000 end_sim();
    always @(*) if(dut.bmw_ir === 32'h0000006f) end_sim();


    /* FUNCTIONS */

    // decode instruction register to op string
    function automatic string decode_ir(logic [31:0] ir);
        priority casez(ir[6:0])
            7'b0110111: return "lui";
            7'b0010111: return "auipc";
            7'b1101111: return "jal";
            7'b1100111: return "jalr";
            7'b1100011: begin
                case(ir[14:12])
                    3'b000: return "beq";
                    3'b001: return "bne";
                    3'b100: return "blt";
                    3'b101: return "bge";
                    3'b110: return "bltu";
                    3'b111: return "bgeu";
                endcase
            end
            7'b0000011: begin
                case(ir[14:12])
                    3'b000: return "lb";
                    3'b001: return "lh";
                    3'b010: return "lw";
                    3'b011: return "ld";
                    3'b100: return "lbu";
                    3'b101: return "lhu";
                    3'b110: return "lwu";
                endcase
            end
            7'b0100011: begin
                case(ir[14:12])
                    3'b000: return "sb";
                    3'b001: return "sh";
                    3'b010: return "sw";
                    3'b011: return "sd";
                endcase
            end
            7'b0010011: begin
                case(ir[14:12])
                    3'b000: return "addi";
                    3'b001: return "slli";
                    3'b010: return "slti";
                    3'b011: return "sltiu";
                    3'b100: return "xori";
                    3'b101: return ir[30] ? "srai" : "srli";
                    3'b110: return "ori";
                    3'b111: return "andi";
                endcase
            end
            7'b0110011: begin
                case(ir[14:12])
                    3'b000: return ir[30] ? "sub" : "add";
                    3'b001: return "sll";
                    3'b010: return "slt";
                    3'b011: return "sltu";
                    3'b100: return "xor";
                    3'b101: return ir[30] ? "sra" : "srl";
                    3'b110: return "or";
                    3'b111: return "and";
                endcase
            end
            // addiw/slliw/srliw/sraiw
            7'b0011011: begin
                case(ir[14:12])
                    3'b000: return "addiw";
                    3'b001: return "slliw";
                    3'b101: return ir[30] ? "sraiw" : "srliw";
                endcase
            end
            // addw/subw...
            7'b0111011: begin
                case(ir[14:12])
                    3'b000: return ir[30] ? "subw" : "addw";
                    3'b001: return "sllw";
                    3'b101: return ir[30] ? "sraw" : "srlw";
                endcase
            end
            default: return "invalid opcode";
        endcase
    endfunction

    // decode register to string
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

    function automatic string decode_csr();
        case(dut.u_csr.csr_addr)
            `sstatus:       return "sstatus";
            `sie:           return "sie";
            `stvec:         return "stvec";
            `scounteren:    return "scounteren";
            `sscratch:      return "sscratch";
            `sepc:          return "sepc";
            `scause:        return "scause";
            `stval:         return "stval";
            `sip:           return "sip";
            `satp:          return "satp";
            `mvendorid:     return "mvendorid";
            `marchid:       return "marchid";
            `mimpid:        return "mimpid";
            `mhartid:       return "mhartid";
            `mconfigptr:    return "mconfigptr";
            `mstatus:       return "mstatus";
            `misa:          return "misa";
            `medeleg:       return "medeleg";
            `mideleg:       return "mideleg";
            `mie:           return "mie";
            `mtvec:         return "mtvec";
            `mcounteren:    return "mcounteren";
            `mscratch:      return "mscratch";
            `mepc:          return "mepc";
            `mcause:        return "mcause";
            `mtval:         return "mtval";
            `mip:           return "mip";
            `mtinst:        return "mtinst";
            `mtval:         return "mtval2";
            `menvcfg:       return "menvcfg";
            `mseccfg:       return "mseccfg";
            `fflags:        return "fflags";
            `frm:           return "frm";
            `fcsr:          return "fcsr";
            default: return "invalid CSR";
        endcase
    endfunction

endmodule
