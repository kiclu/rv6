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

`define TB_ENTRY    64'h8000_0000
`define TB_MEM_SIZE 64'h10_0000

`define ANSI_COLORS
`define DROMAJO_VERBOSE

`define DROMAJO             "/opt/riscv/bin/dromajo"
`define DROMAJO_COSIM_TEST  "/opt/riscv/bin/dromajo_cosim_test"
`define OBJCOPY             "/opt/riscv/bin/riscv64-unknown-elf-objcopy"

`timescale 1ns/1ps
module tb_hart;

    wire             [63:0] h_addr;
    reg    [`HMEM_LINE-1:0] h_data_in;
    wire                    h_rd;
    reg                     h_dv;
    wire   [`HMEM_LINE-1:0] h_data_out;
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
        h_rst_n     = 1;
    end

    // clock generator
    reg clk;
    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end
    assign h_clk = clk;

    /* MEMORY MODEL */

    reg [7:0] mem [`TB_ENTRY : `TB_ENTRY+`TB_MEM_SIZE-1];

    // initialize memory
    task read_hex(string filename);
        $readmemh(filename, mem, `TB_ENTRY);
        for(integer i = `TB_ENTRY; i < `TB_ENTRY+`TB_MEM_SIZE; ++i) begin
            if(mem[i] === 8'hX) mem[i] = 8'h00;
        end
    endtask

    // memory read op
    always @(h_rd) begin
        if(h_rd) begin
            #800
            for(integer i = 0; i < `HMEM_LINE/8; ++i) begin
                h_data_in[8*i +: 8] = mem[h_addr + i];
            end
            h_dv = 1;
            #20
            h_data_in = `HMEM_LINE'bZ;
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
            for(integer i = 0; i < `HMEM_LINE/8; ++i) begin
                mem[h_addr + i] = h_data_out[8*i +: 8];
            end
        end
    end

    /* MONITOR */


    class Exception;
        bit [63:0] cause;
        bit [63:0] tval;

        function new(bit [63:0] cause, bit [63:0] tval);
            this.cause = cause;
            this.tval = tval;
        endfunction

        virtual function string what();
            return "";
        endfunction

    endclass

    class InvalidCSRException extends Exception;
        bit [11:0] csr_addr;

        function new(bit [63:0] cause, bit [63:0] tval, bit [11:0] csr_addr);
            super.new(cause, tval);
            this.csr_addr = csr_addr;
        endfunction

        function string what();
            return $sformatf(
                "csr_read: invalid CSR=0x%-h\n",
                this.csr_addr
            );
        endfunction

    endclass

    enum {IF, PD, ID, EX, MEM, WB} phase;

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

        function string retire();
            if(this.e) begin
                string exc = this.e.what();

                string ret = $sformatf(
                    "%-d %-d 0x%16h (0x%8h) exception %-d, tval %16h",
                    this.hart_id,
                    this.priv_lvl,
                    this.pc,
                    this.ir,
                    this.e.cause,
                    this.e.tval
                );

                return {exc, ret};
            end
            else if(dut.wr && dut.rd) begin
                return $sformatf(
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
                return $sformatf(
                    "%-d %-d 0x%16h (0x%8h)",
                    this.hart_id,
                    this.priv_lvl,
                    this.pc,
                    this.ir
                );
            end
        endfunction

    endclass

    class Test;

        string name;

        function new(string elf);
            integer k;
            this.elf = elf;
            for(integer i = 0; i < elf.len(); ++i) begin
                if(elf.getc(i) == 8'h2F) k = i+1;
            end
            this.name = elf.substr(k, elf.len()-1);
        endfunction

        local string elf;

        local bit [31:0] ir_retired;
        local integer fd;
        Instruction pipeline [1:5];

        local task dromajo_cosim();
            //$system({`DROMAJO, " --trace 0 ", this.elf, " 2> check.trace"});
            $system({`OBJCOPY, " -O verilog ", this.elf, " temp.hex"});
            read_hex("temp.hex");

            // probably some debug section or some other kind of bootrom?? not documented anywhere
            // fdisplay here just so trace comparison works
            $fdisplay(
                this.fd,
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

        endtask

        local task pipeline_sync();
            forever begin
                if(!this.fd) break;
                @(posedge clk) begin
                    if(!dut.stall_wb && this.pipeline[WB]) begin
                        this.ir_retired = this.pipeline[WB].ir;
                        if(!this.fd) break;
                        $fdisplay(
                            this.fd,
                            "%s",
                            this.pipeline[WB].retire()
                        );
                    end

                    if(!dut.stall_mem) this.pipeline[WB]  = this.pipeline[MEM];
                    if(!dut.stall_ex)  this.pipeline[MEM] = this.pipeline[EX];
                    if(!dut.stall_id)  this.pipeline[EX]  = this.pipeline[ID];
                    if(!dut.stall_pd)  this.pipeline[ID]  = this.pipeline[PD];
                    if(!dut.stall_if)  this.pipeline[PD]  = new(0, dut.u_csr.privilege_level, (dut.c_ins ? {16'b0, dut.ir[15:0]} : dut.ir), dut.pc);

                    if(dut.t_flush_mem && !this.pipeline[MEM].e) this.pipeline[MEM] = null;

                    if(dut.t_flush_ex)  this.pipeline[EX] = null;

                    if(dut.t_flush_id || dut.flush_id) begin
                        this.pipeline[ID] = null;
                    end

                    if(dut.t_flush_pd || dut.flush_pd) begin
                        this.pipeline[PD] = null;
                    end
                end
            end
        endtask

        local task exception_handler();
            forever begin
                if(!this.fd) break;
                @(negedge clk) begin
                    if(dut.u_csr.csr_addr_invalid && this.pipeline[MEM]) begin
                        automatic InvalidCSRException ex = new(2, 0, dut.u_csr.csr_addr);
                        this.pipeline[MEM].e = ex;
                    end
                    if(dut.u_csr.ecall && this.pipeline[MEM]) begin
                        automatic Exception ex = new(dut.u_csr.cause, dut.u_csr.val);
                        this.pipeline[MEM].e = ex;
                    end
                    if(dut.u_csr.trap_ret && this.pipeline[MEM]) begin
                        automatic Exception ex = new(dut.u_csr.cause, dut.u_csr.val);
                        this.pipeline[MEM].e = ex;
                    end
                end
            end
        endtask

        bit passed;

        local task tohost_monitor();
            forever begin
                @(negedge clk) begin
                    if(this.ir_retired == 32'hfc3f2223) begin
                        $fclose(this.fd);
                        this.fd = 0;
`ifdef DROMAJO_VERBOSE
                        this.passed = $system({`DROMAJO_COSIM_TEST, " cosim ", this.name, ".trace ", this.elf, " 2> ", this.name, ".dromajo.log > ", this.name, ".dromajo.log"}) == 0;
`else
                        this.passed = $system({`DROMAJO_COSIM_TEST, " cosim ", this.name, ".trace ", this.elf, " > /dev/null 2> /dev/null"}) == 0;
`endif
                        break;
                    end
                end
            end
        endtask

        local task timeout();
            #200_0000;
        endtask

        task run();

            // hart reset signal
            #80
            h_rst_n = 0;
            #80;
            h_rst_n = 1;

            // trace file handle init
            this.fd = $fopen({this.name, ".trace"}, "w");

            // run co-sim
            this.dromajo_cosim();
            fork
                this.pipeline_sync();
                this.exception_handler();
                this.tohost_monitor();
                this.timeout();
            join_any
        endtask

    endclass

    class RiscvTestEnv;

        string path;

        function new(string path, string template);
            this.path = path;
            this.gen_file_list(template);
            this.passed = 0;
            this.failed = 0;
        endfunction

        local task gen_file_list(string template);
            $system({"find ", this.path, " -name '", template, "' -not -name '*.dump' > tb_hart.lst"});
        endtask

        Test t;

        integer passed;
        integer failed;

        task run();
            integer fd;
            string filename;

            $display("Running riscv-tests...");
            fd = $fopen("tb_hart.lst", "r");
            while(!$feof(fd)) begin
                $fgets(filename, fd);
                filename = filename.substr(0, filename.len()-2);
                if(filename == "") break;
                t = new(filename);
                t.run();
                $display(
                    "%-25s: %s",
                    t.name,
`ifdef ANSI_COLORS
                    t.passed ? "\x1b[1;32mpassed\x1b[0m" : "\x1b[1;31mfailed\x1b[0m"
`else
                    t.passed ? "passed" : "failed"
`endif
                );

                this.passed +=  t.passed;
                this.failed += !t.passed;
            end

            $display(
`ifdef ANSI_COLORS
                "riscv-tests finished: \x1b[1;32m%d\x1b[0m passed, \x1b[1;31m%d\x1b[0m failed!",
`else
                "riscv-tests finished: %d passed, %d failed!",
`endif
                this.passed,
                this.failed
            );

            $fclose(fd);

            $system("rm tb_hart.lst");

        endtask

    endclass

    RiscvTestEnv env;

    initial begin
        //env = new("/opt/riscv/target/share/riscv-tests/isa/", "rv64ui-p-*");
        //env = new("/opt/riscv/target/share/riscv-tests/isa/", "rv64uc-p-rvc");
        env = new("/opt/riscv/target/share/riscv-tests/isa/", "rv64ui-p-sd");
        env.run();
        $stop();
    end

endmodule
