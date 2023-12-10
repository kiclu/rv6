`define hex_path "../test/c/fib/fib.hex"

`define tb_mem_size  32'h0001_0000
`define tb_mem_entry 32'h8000_0000

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
    always @(posedge clk) begin
        if(h_amo_req) #160 h_amo_ack <= 1;
        else h_amo_ack <= 0;
    end

    // print destination register and value on instruction retire
    always @(posedge clk) begin
        if(!dut.stall_wb && dut.wr && dut.rd) begin
            $display("@%8t: %8s : rd=%4s, d=%h",
                $time(),
                decode_ir(dut.bmw_ir),
                decode_r(dut.bmw_ir[11:7]),
                dut.d
            );
        end
    end

    reg [31:0] wb_fw_ir;
    always @(posedge clk) if(!dut.stall_wb) wb_fw_ir <= dut.bmw_ir;

    // print forwarding in pipeline
    always @(posedge clk) begin
        if(dut.a_fw || dut.b_fw) begin
            $display("====================");
            $display("FORWARD @ %8t : %s %s, %s, %s", $time, decode_ir(dut.bdx_ir), decode_r(dut.bdx_ir[11:7]), decode_r(dut.bdx_ir[19:15]), decode_r(dut.bdx_ir[24:20]));
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

    function string decode_r(logic [4:0] r);
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

    function string decode_ir(logic [31:0] ir);
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

    task end_sim();
        $display("t6=%d", dut.u_regfile.register[31]);
        $stop();
    endtask

    initial #20000 end_sim();
    always @(*) if(dut.bmw_ir === 32'h0000006f) end_sim();

endmodule
