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

/*
 * Configurable L1 instruction cache
 */

`include "../config.v"

module imem(
    input                    [63:0] pc,
    output reg               [31:0] ir,

    output reg  [`IMEM_BLK_LEN-1:0] b_addr_i,
    input          [`IMEM_LINE-1:0] b_data_i,
    output reg                      b_rd_i,
    input                           b_dv_i,

    output reg                      stall_imem,
    input                           rst_n,
    input                           clk
);

`ifdef  IMEM_SET_ASSOC

    wire [63:0] addr;

    wire [ `IMEM_TAG_LEN-1:0] addr_tag  = addr[`IMEM_ADDR_TAG_RANGE ];
    wire [ `IMEM_SET_LEN-1:0] addr_set  = addr[`IMEM_ADDR_SET_RANGE ];
    wire [`IMEM_OFFS_LEN-1:0] addr_offs = addr[`IMEM_ADDR_OFFS_RANGE];

    (* ram_style = "block" *)
    reg  [   `IMEM_LINE-1:0] data [0:`IMEM_LINES-1];
    reg  [`IMEM_TAG_LEN-1:0] tag  [0:`IMEM_LINES-1];
    reg                      v    [0:`IMEM_LINES-1];

    reg  [`IMEM_WAY_LEN-1:0] re;
    reg                      hit;

    /* BRAM WRITE */

    reg  [`IMEM_TAG_LEN-1:0] tag_d;
    reg  [`IMEM_SET_LEN-1:0] set_d;
    reg  [`IMEM_WAY_LEN-1:0] way_d;
    reg  [   `IMEM_LINE-1:0] d;
    reg                      wre;
    always @(posedge clk) if(wre) data[`IMEM_WAYS * set_d + way_d] <= d;

    /* BRAM READ */

    reg  [`IMEM_TAG_LEN-1:0] tag_q;
    reg  [`IMEM_SET_LEN-1:0] set_q;
    reg  [`IMEM_WAY_LEN-1:0] way_q;
    reg  [   `IMEM_LINE-1:0] q;
    reg                      rde;
    always @(posedge clk) if(rde) q <= data[`IMEM_WAYS * set_q + way_q];

    /* READ BUFFER */

    reg  [`IMEM_TAG_LEN-1:0] rb_tag;
    reg  [`IMEM_SET_LEN-1:0] rb_set;
    reg                      rb_v;

    wire rb_hit = rb_tag == addr_tag && rb_set == addr_set;

    /* MISALIGNED ACCESS */

    wire [63:0] ma_pc = pc + 2;
    reg  [15:0] ma_reg;
    reg         ma_pend;
    reg         ma_acc;
    wire        ma;

    /* FSM */

    reg  [3:0] ld_cnt;

    reg  [1:0] imem_fsm_state;
    reg  [1:0] imem_fsm_state_next;

    `define S_READY 2'd0
    `define S_FETCH 2'd1
    `define S_LOAD  2'd2
    `define S_MA    2'd3

    /* FSM */

    always @(*) begin
        b_rd_i  = 0;
        wre     = 0;
        rde     = 0;
        way_d   = 0;

        imem_fsm_state_next = imem_fsm_state;
        case(imem_fsm_state)
            `S_READY: begin
                if(!hit) imem_fsm_state_next = `S_FETCH;
                if( hit) imem_fsm_state_next = `S_LOAD;
                if(rb_hit && !ma) imem_fsm_state_next = `S_READY;
                if(rb_hit &&  ma) imem_fsm_state_next = `S_MA;
            end
            `S_FETCH: begin
                b_rd_i  = 1;
                way_d   = re;
                wre     = b_dv_i;

                if(b_dv_i) imem_fsm_state_next = ma_pend ? `S_MA : `S_LOAD;
            end
            `S_LOAD: begin
                rde = ld_cnt == `IMEM_READ_VALID_DELAY;

                if(!ld_cnt) imem_fsm_state_next = ma_pend ? `S_MA : `S_READY;
            end
            `S_MA: begin
                imem_fsm_state_next = hit ? `S_LOAD : `S_FETCH;
            end
        endcase
    end

    // FSM state update
    always @(posedge clk) begin
        if(!rst_n) imem_fsm_state <= `S_READY;
        else imem_fsm_state <= imem_fsm_state_next;
    end

    // read buffer
    always @(posedge clk) begin
        if(ld_cnt == 0 && imem_fsm_state == `S_LOAD) begin
            rb_tag  <= addr_tag;
            rb_set  <= addr_set;
            rb_v    <= 1;
        end
        ld_cnt <= imem_fsm_state == `S_LOAD ? ld_cnt - 1 : `IMEM_READ_VALID_DELAY;
    end

    // L2 request address
    always @(posedge clk) begin
        if(imem_fsm_state == `S_FETCH) begin
            b_addr_i <= {addr_tag, addr_set};
        end
    end

    // cache metadata update
    always @(posedge clk) begin
        if(!rst_n) begin : imem_reset
            integer i;
            for(i = 0; i < `IMEM_LINES; i = i + 1) begin
                tag[i] <= 0;
                v  [i] <= 0;
            end
        end
        else begin
            if(wre) begin
                tag[`IMEM_WAYS * set_d + way_d] <= tag_d;
                v  [`IMEM_WAYS * set_d + way_d] <= 1;
            end
        end
    end

    // input mux
    always @(*) d = b_data_i;

    // output mux
    always @(*) begin
        if(ma) ir = {q[15:0], ma_reg};
        else ir = q[8*addr_offs +: 32];
    end

    // cache hit detection
    always @(*) begin : imem_cache_hit
        integer w;
        way_q = 'bZ; hit = 0;
        for(w = 0; w < `IMEM_WAYS; w = w + 1) begin
            if(tag[`IMEM_WAYS * set_q + w] == tag_q && v[`IMEM_WAYS * set_q + w]) begin
                way_q = w; hit = 1;
            end
        end
    end

    // BRAM write address
    always @(*) begin
        tag_d = addr_tag;
        set_d = addr_set;
    end

    // BRAM read address
    always @(*) begin
        tag_q = addr_tag;
        set_q = addr_set;
    end

    // misaligned access
    always @(posedge clk) begin
        if(imem_fsm_state == `S_READY) begin
            ma_pend <= ma;
        end
        else if(imem_fsm_state == `S_MA) begin
            ma_reg  <= q[`IMEM_LINE-1 -: 16];
            ma_pend <= 0;
            ma_acc  <= 1;
        end
        else if(imem_fsm_state_next == `S_READY) begin
            ma_pend <= 0;
            ma_acc  <= 0;
        end
    end

    assign ma = ma_pc[63 -: `IMEM_BLK_LEN] != pc[63 -: `IMEM_BLK_LEN];
    assign addr = ma_acc ? ma_pc : pc;

`endif//IMEM_SET_ASSOC

    assign stall_imem = imem_fsm_state != `S_READY || imem_fsm_state_next != `S_READY;

    // TODO:
    /* REPLACEMENT ENTRY */

    always @(posedge clk) re <= $random() % `DMEM_SETS;

endmodule
