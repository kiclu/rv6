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
 * Configurable, write-allocated L1 data cache with write-through policy
 */

`include "../config.v"

module dmem(
    input                    [63:0] addr,
    input                    [ 2:0] len,

    input                    [63:0] data_in,
    input                           wr,

    output reg               [63:0] data_out,
    input                           rd,

    // misaligned access
    output                          ld_ma,
    output                          st_ma,

    // external bus signals
    output reg  [`DMEM_BLK_LEN-1:0] b_addr_d,

    input          [`DMEM_LINE-1:0] b_data_in_d,
    output reg                      b_rd_d,
    input                           b_dv_d,

    // cache invalidaton
    input       [`DMEM_BLK_LEN-1:0] inv_addr,
    input                           inv,

    // control signals
    output                          stall_dmem,
    input                           rst_n,
    input                           clk
);

`ifdef  DMEM_SET_ASSOC

    wire [ `DMEM_TAG_LEN-1:0] addr_tag  = addr[`DMEM_ADDR_TAG_RANGE ];
    wire [ `DMEM_SET_LEN-1:0] addr_set  = addr[`DMEM_ADDR_SET_RANGE ];
    wire [`DMEM_OFFS_LEN-1:0] addr_offs = addr[`DMEM_ADDR_OFFS_RANGE];

    (* ram_style = "block" *)
    reg  [   `DMEM_LINE-1:0] data [0:`DMEM_LINES-1];
    reg  [`DMEM_TAG_LEN-1:0] tag  [0:`DMEM_LINES-1];
    reg                      v    [0:`DMEM_LINES-1];

    reg  [`DMEM_WAY_LEN-1:0] re;
    reg  hit;

    /* BRAM WRITE */

    reg  [`DMEM_TAG_LEN-1:0] tag_d;
    reg  [`DMEM_SET_LEN-1:0] set_d;
    reg  [`DMEM_WAY_LEN-1:0] way_d;
    reg  [   `DMEM_LINE-1:0] d;
    reg  wre;
    always @(posedge clk) if(wre) data[`DMEM_WAYS * set_d + way_d] <= d;

    /* BRAM READ */

    reg  [`DMEM_TAG_LEN-1:0] tag_q;
    reg  [`DMEM_SET_LEN-1:0] set_q;
    reg  [`DMEM_WAY_LEN-1:0] way_q;
    reg  [   `DMEM_LINE-1:0] q;
    reg  rde;
    always @(posedge clk) if(rde) q <= data[`DMEM_WAYS * set_q + way_q];

    /* WRITE BUFFER */

    reg  [`DMEM_TAG_LEN-1:0] wb_tag;
    reg  [`DMEM_TAG_LEN-1:0] wb_set;
    reg  [   `DMEM_LINE-1:0] wb_data;
    reg  [              2:0] wb_len;
    reg  wr_pend;

    /* READ BUFFER */

    reg  [`DMEM_TAG_LEN-1:0] rb_tag;
    reg  [`DMEM_SET_LEN-1:0] rb_set;
    reg                      rb_v;

    wire rb_hit = rb_tag == addr_tag && rb_set == addr_set;

    /* FSM */

    reg  [3:0] ld_cnt;

    reg  [1:0] dmem_fsm_state;
    reg  [1:0] dmem_fsm_state_next;

    `define S_READY 2'd0
    `define S_FETCH 2'd1
    `define S_LOAD  2'd2
    `define S_WRITE 2'd3

    always @(*) begin
        wre     = 0;
        rde     = 0;
        b_rd_d  = 0;
        way_d   = way_q;
        dmem_fsm_state_next = dmem_fsm_state;
        case(dmem_fsm_state)
            `S_READY: begin
                if(rd &&   !hit) dmem_fsm_state_next = `S_FETCH;
                if(wr &&   !hit) dmem_fsm_state_next = `S_FETCH;

                if(rd &&    hit) dmem_fsm_state_next = `S_LOAD;
                if(wr &&    hit) dmem_fsm_state_next = `S_LOAD;

                if(rd && rb_hit) dmem_fsm_state_next = `S_READY;
                if(wr && rb_hit) dmem_fsm_state_next = `S_WRITE;
            end
            `S_FETCH: begin
                b_rd_d  = 1;
                way_d   = re;
                wre     = b_dv_d;

                if(b_dv_d) dmem_fsm_state_next = `S_LOAD;
            end
            `S_LOAD: begin
                rde = ld_cnt == `DMEM_READ_VALID_DELAY;

                if(!ld_cnt) dmem_fsm_state_next = wr_pend ? `S_WRITE : `S_READY;
            end
            `S_WRITE: begin
                wre     = 1;

                dmem_fsm_state_next = `S_READY;
            end
        endcase
    end

    // FSM state update
    always @(posedge clk) begin
        if(!rst_n) dmem_fsm_state  <= `S_READY;
        else dmem_fsm_state <= dmem_fsm_state_next;
    end

    // read buffer
    always @(posedge clk) begin
        if(dmem_fsm_state == `S_WRITE) rb_v <= 0;
        if(dmem_fsm_state == `S_LOAD) begin
            rb_tag <= wr_pend ? wb_tag : addr_tag;
            rb_set <= wr_pend ? wb_set : addr_set;
            rb_v   <= 1;
        end
        ld_cnt <= dmem_fsm_state == `S_LOAD ? ld_cnt - 1 : `DMEM_READ_VALID_DELAY;
    end

    // write buffer
    always @(posedge clk) begin
        if(!rst_n || dmem_fsm_state == `S_WRITE) wr_pend <= 0;
        else if(wr && dmem_fsm_state == `S_READY) begin
            wb_tag  <= addr_tag;
            wb_set  <= addr_set;
            wb_data <= data_in;
            wb_len  <= len;
            wr_pend <= 1;
        end
    end

    // L2 request address
    always @(posedge clk) begin
        if(dmem_fsm_state == `S_FETCH) begin
            b_addr_d <= wr_pend ? {wb_tag, wb_set} : {addr_tag, addr_set};
        end
    end

    // cache metadata update
    always @(posedge clk) begin
        if(!rst_n) begin : dmem_reset
            integer i;
            for(i = 0; i < `DMEM_LINES; i = i + 1) begin
                tag[i] <= 0;
                v  [i] <= 0;
            end
        end
        else begin
            if(wre && dmem_fsm_state == `S_FETCH) begin
                tag[`DMEM_WAYS * set_d + way_d] <= tag_d;
                v  [`DMEM_WAYS * set_d + way_d] <= 1;
            end
        end
    end

    // input mux
    always @(*) begin
        if(dmem_fsm_state == `S_FETCH) d = b_data_in_d;
        else begin
            d = q;
            case(wb_len[1:0])
                2'b00: d[8*addr_offs +:  8] = wb_data[ 7:0];
                2'b01: d[8*addr_offs +: 16] = wb_data[15:0];
                2'b10: d[8*addr_offs +: 32] = wb_data[31:0];
                2'b11: d[8*addr_offs +: 64] = wb_data[63:0];
            endcase
        end
    end

    // output mux
    always @(*) begin
        case(len)
            3'b000: data_out =   $signed(q[8*addr_offs +:  8]);
            3'b001: data_out =   $signed(q[8*addr_offs +: 16]);
            3'b010: data_out =   $signed(q[8*addr_offs +: 32]);
            3'b011: data_out =   $signed(q[8*addr_offs +: 64]);
            3'b100: data_out = $unsigned(q[8*addr_offs +:  8]);
            3'b101: data_out = $unsigned(q[8*addr_offs +: 16]);
            3'b110: data_out = $unsigned(q[8*addr_offs +: 32]);
            3'b111: data_out = $unsigned(q[8*addr_offs +: 64]);
        endcase
    end

    // cache hit detection
    always @(*) begin : dmem_cache_hit
        integer w;
        way_q = 'bZ; hit = 0;
        for(w = 0; w < `DMEM_WAYS; w = w + 1) begin
            if(tag[`DMEM_WAYS * set_q + w] == tag_q && v[`DMEM_WAYS * set_q + w]) begin
                way_q = w; hit = 1;
            end
        end
    end

    // BRAM write address
    always @(*) begin
        tag_d = wr_pend ? wb_tag : addr_tag;
        set_d = wr_pend ? wb_set : addr_set;
    end

    // BRAM read address
    always @(*) begin
        tag_q = wr_pend ? wb_tag : addr_tag;
        set_q = wr_pend ? wb_set : addr_set;
    end

    assign stall_dmem = (rd && dmem_fsm_state_next) || (wr && wr_pend);

`endif//DMEM_SET_ASSOC

    // TODO:
    /* REPLACEMENT POLICY */

    always @(posedge clk) re <= $random() % `DMEM_SETS;

    // TODO:
    /* MISALIGNED ACCESS DETECTION */

endmodule
