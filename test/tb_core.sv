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

`define TB_ENTRY    64'h8000_0000
`define TB_MEM_SIZE 64'h10_0000

`define DROMAJO             "/opt/riscv/bin/dromajo"
`define DROMAJO_COSIM_TEST  "/opt/riscv/bin/dromajo_cosim_test"
`define OBJCOPY             "/opt/riscv/bin/riscv64-unknown-elf-objcopy"

`timescale 1ns/1ps
module tb_core();

    wire             [63:0] c_addr;
    wire                    c_ext;
    reg    [`CMEM_LINE-1:0] c_rdata;
    wire                    c_rd;
    reg                     c_dv;
    wire             [63:0] c_wdata;
    wire             [ 1:0] c_len;
    wire                    c_wr;
    reg                     c_irq_e;
    reg                     c_irq_t;
    reg                     c_irq_s;
    reg              [63:0] c_inv_addr;
    reg                     c_inv;
    wire                    c_amo_req;
    reg                     c_amo_ack;
    reg                     c_rst_n;
    wire                    c_clk;

    rv6_core #(.HART_ID(0)) dut (
        .c_addr         (c_addr         ),
        .c_ext          (c_ext          ),
        .c_rdata        (c_rdata        ),
        .c_rd           (c_rd           ),
        .c_dv           (c_dv           ),
        .c_wdata        (c_wdata        ),
        .c_len          (c_len          ),
        .c_wr           (c_wr           ),
        .c_irq_e        (c_irq_e        ),
        .c_irq_t        (c_irq_t        ),
        .c_irq_s        (c_irq_s        ),
        .c_inv_addr     (c_inv_addr     ),
        .c_inv          (c_inv          ),
        .c_amo_req      (c_amo_req      ),
        .c_amo_ack      (c_amo_ack      ),
        .c_rst_n        (c_rst_n        ),
        .c_clk          (c_clk          )
    );

    // initial signal values
    initial begin
        c_rdata     = 64'bZ;
        c_dv        = 0;
        c_irq_e     = 0;
        c_irq_t     = 0;
        c_irq_s     = 0;
        c_inv_addr  = 64'bZ;
        c_inv       = 0;
        c_amo_ack   = 0;
        c_rst_n     = 1;
    end

    // clock generator
    reg clk;
    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end
    assign c_clk = clk;

    /* MEMORY MODEL */

    mem tb_mem (
        .addr           (c_addr         ),
        .wdata          (c_wdata        ),
        .rdata          (c_rdata        ),
        .len            (c_len          ),
        .rd             (c_rd           ),
        .wr             (c_wr           ),
        .dv             (c_dv           ),
        .rst_n          (c_rst_n        ),
        .clk            (c_clk          )
    );

    /* MONITOR */

    class Exception;
        bit [63:0] cause;
        bit [63:0] tval;

        function new(input bit [63:0] cause, input bit [63:0] tval);
            this.cause = cause;
            this.tval = tval;
        endfunction

        virtual function string what();
            return "";
        endfunction

    endclass

    class InvalidCSRException extends Exception;
        bit [11:0] csr_addr;

        function new(input bit [63:0] cause, input bit [63:0] tval, input bit [11:0] csr_addr);
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

        function new(input bit [63:0] hart_id, input bit[1:0] priv_lvl, input bit [31:0] ir, input bit [63:0] pc);
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

        function new(input string elf);
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
            tb_mem.read_hex("temp.hex");

            // dromajo runs debug mode bootrom at 0x10000
            // there's no debug mode implemented on this core so this section
            // is just skipped, but trace still has to be printed for trace comparison
            $fdisplay(
                this.fd,
"0 3 0x0000000000010000 (0xf1402573) x10 0x0000000000000000\n\
0 3 0x0000000000010004 (0x00050663)\n\
0 3 0x0000000000010010 (0x00000597) x11 0x0000000000010010\n\
0 3 0x0000000000010014 (0x0f058593) x11 0x0000000000010100\n\
0 3 0x0000000000010018 (0x60300413) x 8 0x0000000000000603\n\
0 3 0x000000000001001c (0x7b041073)\n\
0 3 0x0000000000010020 (0x0010041b) x 8 0x0000000000000001\n\
0 3 0x0000000000010024 (0x01f41413) x 8 0x0000000080000000\n\
0 3 0x0000000000010028 (0x7b141073)\n\
0 3 0x000000000001002c (0x7b200073)"
            );

        endtask

        local task pipeline_sync();
            forever begin
                if(!this.fd) break;
                @(posedge clk) begin
                    /* DEBUG START */
                    // if($time() == 31200000ps) begin
                    //     $display("DEBUG START");
                    //     $display("IR = %08h", this.pipeline[WB].ir);
                    //     $display("DEBUG END");
                    // end
                    /* DEBUG END */
                    if(!dut.stall_wb && this.pipeline[WB] != null) begin
                        this.ir_retired = this.pipeline[WB].ir;
                        if(!this.fd) break;
                        if(this.pipeline[WB] && this.pipeline[WB].ir != dut.bmw_ir && !this.pipeline[WB].e) begin
                            // TODO: fix a bug where pipeline record in this
                            // testbench doesn't align with core pipeline
                            this.pipeline[WB].ir = dut.bmw_ir;
                            //$display("ir mismatch @ %t", $time());
                        end
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

                    if(this.pipeline[MEM]) begin
                        if(dut.t_flush_mem && !this.pipeline[MEM].e) this.pipeline[MEM] = null;
                    end

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
            c_rst_n = 0;
            #80;
            c_rst_n = 1;

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

        function new(input string path);
            this.path = path;
            this.passed = 0;
            this.failed = 0;
        endfunction

        task gen_file_list(input string template);
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
        env = new("/opt/riscv/target/share/riscv-tests/isa/");

        env.gen_file_list("rv64ui-p-*");
        //env.gen_file_list("rv64ui-p-sd");
        //env.gen_file_list("rv64ui-p-fence_i");
        //env.gen_file_list("rv64ui-p-ma_data");
        //env.gen_file_list("rv64ui-p-sh");
        //env.gen_file_list("rv64ui-p-sw");
        //env.gen_file_list("rv64ui-p-sb");
        //env.gen_file_list("rv64uc-p-rvc");

        env.run();
        $stop();
    end

endmodule
