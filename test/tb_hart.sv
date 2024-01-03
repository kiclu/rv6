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

`include "../hdl/config.v"

`define tb_entry    64'h8000_0000
`define tb_mem_size 64'h10_0000

`timescale 1ns/1ps

module tb_hart;

    wire             [63:0] h_addr;
    reg    [`hmem_line-1:0] h_data_in;
    wire                    h_rd;
    reg                     h_dv;
    wire   [`hmem_line-1:0] h_data_out;
    wire                    h_wr;
    reg                     h_irq_e;
    reg                     h_irq_t;
    reg                     h_irq_s;
    reg              [63:0] h_inv_addr;
    reg                     h_inv;
    wire                    h_amo_req;
    reg                     h_amo_ack;
    reg                     h_rst_n;
    wire                    h_clk;

    hart #(.HART_ID(0)) dut (
        .h_addr         (h_addr         ),
        .h_data_in      (h_data_in      ),
        .h_rd           (h_rd           ),
        .h_dv           (h_dv           ),
        .h_data_out     (h_data_out     ),
        .h_wr           (h_wr           ),
        .h_irq_e        (h_irq_e        ),
        .h_irq_t        (h_irq_t        ),
        .h_irq_s        (h_irq_s        ),
        .h_inv_addr     (h_inv_addr     ),
        .h_inv          (h_inv          ),
        .h_amo_req      (h_amo_req      ),
        .h_amo_ack      (h_amo_ack      ),
        .h_rst_n        (h_rst_n        ),
        .h_clk          (h_clk          )
    );

    // initial signal values
    initial begin
        h_data_in   = 64'bZ;
        h_dv        = 0;
        h_irq_e     = 0;
        h_irq_t     = 0;
        h_irq_s     = 0;
        h_inv_addr  = 64'bZ;
        h_inv       = 0;
        h_amo_ack   = 0;
    end

    // reset signal
    initial begin
        h_rst_n = 0;
        #80 h_rst_n = 1;
    end

    // clock generator
    reg clk;
    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end
    assign h_clk = clk;

    /* MEMORY MODEL */

    reg [7:0] mem [`tb_entry : `tb_entry+`tb_mem_size-1];

    // initialize memory
    task read_hex(string filename);
        $readmemh(filename, mem, `tb_entry);
        for(integer i = `tb_entry; i < `tb_entry+`tb_mem_size; ++i) begin
            if(mem[i] === 8'hX) mem[i] = 8'h00;
        end
    endtask

    // memory read op
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

    // memory write op
    always @(posedge clk) begin
        if(h_wr) begin
            for(integer i = 0; i < `hmem_line/8; ++i) begin
                mem[h_addr + i] = h_data_out[8*i +: 8];
            end
        end
    end

    /* MONITOR */

    integer fd;
    initial begin
        fd = $fopen("trace", "w");
        $fdisplay(
            fd,
"0 3 0x0000000000010000 (0xf1402573) x10 0x0000000000000000
0 3 0x0000000000010004 (0x00050663)
0 3 0x0000000000010010 (0x00000597) x11 0x0000000000010010
0 3 0x0000000000010014 (0x0f058593) x11 0x0000000000010100
0 3 0x0000000000010018 (0x60300413) x 8 0x0000000000000603
0 3 0x000000000001001c (0x7b041073)
0 3 0x0000000000010020 (0x0010041b) x 8 0x0000000000000001
0 3 0x0000000000010024 (0x01f41413) x 8 0x0000000080000000
0 3 0x0000000000010028 (0x7b141073)
0 3 0x000000000001002c (0x7b200073)"
         );
    end

    string _elf = "/opt/riscv/target/share/riscv-tests/isa/rv64ui-p-xor";

    initial begin
        dromajo_cosim(_elf);
    end

`define dromajo             "/opt/riscv/bin/dromajo"
`define dromajo_cosim_test  "/opt/riscv/bin/dromajo_cosim_test"
`define objcopy             "/opt/riscv/bin/riscv64-unknown-elf-objcopy"

    task dromajo_cosim(string elf);
        $system({`dromajo, " --trace 0 ", elf, " 2> check.trace"});
        $system({`objcopy, " -O verilog ", elf, " temp.hex"});
        read_hex("temp.hex");
    endtask


    class Exception;
        bit [63:0] cause;
        bit [63:0] tval;

        function new(bit [63:0] cause, bit [63:0] tval);
            this.cause = cause;
            this.tval = tval;
        endfunction

        virtual function what();
        endfunction

    endclass

    class InvalidCSRException extends Exception;
        bit [11:0] csr_addr;

        function new(bit [63:0] cause, bit [63:0] tval, bit [11:0] csr_addr);
            super.new(cause, tval);
            this.csr_addr = csr_addr;
        endfunction

        function what();
            $fdisplay(
                fd,
                "csr_read: invalid CSR=0x%-h",
                csr_addr
            );
        endfunction
    endclass

    bit [31:0] ir_retired;

    class Instruction;
        bit [31:0] ir;
        bit [63:0] pc;

        bit [63:0] hart_id;
        bit [ 1:0] priv_lvl;

        Exception e;

        function new(bit [63:0] hart_id, bit[1:0] priv_lvl, bit [31:0] ir, bit [63:0] pc);
            this.hart_id = hart_id;
            this.priv_lvl = priv_lvl;

            this.ir = ir;
            this.pc = pc;

            this.e = null;
        endfunction

        function retire();
            if(this.e) begin
                this.e.what();

                $fdisplay(
                    fd,
                    "%-d %-d 0x%16h (0x%8h) exception %-d, tval %16h",
                    this.hart_id,
                    this.priv_lvl,
                    this.pc,
                    this.ir,
                    this.e.cause,
                    this.e.tval
                );
            end
            else if(dut.wr && dut.rd) begin
                $fdisplay(
                    fd,
                    "%-d %-d 0x%16h (0x%8h) x%2d 0x%16h",
                    this.hart_id,
                    this.priv_lvl,
                    this.pc,
                    this.ir,
                    dut.rd,
                    dut.d
                );
            end
            else begin
                $fdisplay(
                    fd,
                    "%-d %-d 0x%16h (0x%8h)",
                    this.hart_id,
                    this.priv_lvl,
                    this.pc,
                    this.ir,
                );
            end
            ir_retired = this.ir;
        endfunction

    endclass

    enum {IF, PD, ID, EX, MEM, WB} phase;
    Instruction pipeline [1:5];

    always @(posedge clk) begin
        if(!dut.stall_wb && pipeline[WB]) pipeline[WB].retire();

        if(!dut.stall_mem) pipeline[WB]  = pipeline[MEM];
        if(!dut.stall_ex)  pipeline[MEM] = pipeline[EX];
        if(!dut.stall_id)  pipeline[EX]  = pipeline[ID];
        if(!dut.stall_pd)  pipeline[ID]  = pipeline[PD];
        if(!dut.stall_if)  pipeline[PD]  = new(0, dut.u_csr.privilege_level, dut.ir, dut.pc);

        if(dut.t_flush_mem && !pipeline[MEM].e) pipeline[MEM] = null;

        if(dut.t_flush_ex)  pipeline[EX] = null;

        if(dut.t_flush_id || dut.flush_id) begin
            pipeline[ID] = null;
        end

        if(dut.t_flush_pd || dut.flush_pd) begin
            pipeline[PD] = null;
        end
    end

    always @(negedge clk) begin
        if(dut.u_csr.csr_addr_invalid && pipeline[MEM]) begin
            automatic InvalidCSRException ex = new(2, 0, dut.u_csr.csr_addr);
            pipeline[MEM].e = ex;
        end

        if(dut.u_csr.ecall && pipeline[MEM]) begin
            automatic Exception ex = new(dut.u_csr.cause, dut.u_csr.val);
            pipeline[MEM].e = ex;
        end
    end

    always @(negedge clk) begin
        // end sim if write_tohost
        if(ir_retired == 32'hfc3f2223) begin
            $fclose(fd);
            $system({`dromajo_cosim_test, " cosim trace ", _elf});
            $stop();
        end
    end

endmodule
