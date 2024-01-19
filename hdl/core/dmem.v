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

`include "../config.vh"

module dmem(
    input                    [63:0] addr,
    input                    [ 2:0] len,

    output reg               [63:0] rdata,
    input                           rd,

    input                    [63:0] wdata,
    input                           wr,

    // misaligned access
    output                          ld_ma,
    output                          st_ma,

    // external bus signals
    output reg  [`DMEM_BLK_LEN-1:0] b_addr_d,

    input          [`DMEM_LINE-1:0] b_rdata_d,
    output reg                      b_rd_d,
    input                           b_dv_d,

    // cache invalidaton
    input       [`DMEM_BLK_LEN-1:0] b_inv_addr_d,
    input                           inv,

    // control signals
    output                          stall_dmem,
    input                           stall_mem,
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

    reg  [ `DMEM_TAG_LEN-1:0] wb_tag;
    reg  [ `DMEM_SET_LEN-1:0] wb_set;
    reg  [`DMEM_OFFS_LEN-1:0] wb_offs;
    reg  [              63:0] wb_data;
    reg  [               1:0] wb_len;
    reg  wr_pend;

    /* READ BUFFER */

    reg  [`DMEM_TAG_LEN-1:0] rb_tag;
    reg  [`DMEM_SET_LEN-1:0] rb_set;
    reg                      rb_v;

    wire rb_hit = rb_tag == addr_tag && rb_set == addr_set && rb_v;

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

    /* FSM UPDATE */

    always @(posedge clk) begin
        if(!rst_n) dmem_fsm_state  <= `S_READY;
        else dmem_fsm_state <= dmem_fsm_state_next;
    end

    /* READ BUFFER */

    always @(posedge clk) begin
        if(!rst_n) begin
            rb_tag  <= 0;
            rb_set  <= 0;
            rb_v    <= 0;
        end
        else begin
            if(dmem_fsm_state == `S_WRITE) rb_v <= 0;
            if(dmem_fsm_state == `S_LOAD) begin
                rb_tag <= wr_pend ? wb_tag : addr_tag;
                rb_set <= wr_pend ? wb_set : addr_set;
                rb_v   <= 1;
            end
        end
        ld_cnt <= dmem_fsm_state == `S_LOAD ? ld_cnt - 1 : `DMEM_READ_VALID_DELAY;
    end

    /* WRITE BUFFER */

    wire wr_nstall = wr && !stall_mem;
    reg wr_nstall_d;
    always @(posedge clk) wr_nstall_d <= wr_nstall;
    wire wr_nstall_re = wr_nstall && !wr_nstall_d;

    always @(posedge clk) begin
        if(!rst_n || dmem_fsm_state == `S_WRITE) wr_pend <= 0;
        else if(wr_nstall_re && !rb_hit) begin
            wb_tag  <= addr_tag;
            wb_set  <= addr_set;
            wb_offs <= addr_offs;
            wb_data <= wdata;
            wb_len  <= len;
            wr_pend <= 1;
        end
    end

    /* REQUEST ADDRESS */

    //always @(posedge clk) begin
    //    if(dmem_fsm_state == `S_FETCH) begin
    //        b_addr_d <= wr_pend ? {wb_tag, wb_set} : {addr_tag, addr_set};
    //    end
    //end

    always @(*) begin
        b_addr_d = wr_pend ? {wb_tag, wb_set} : {addr_tag, addr_set};
    end

    /* METADATA UPDATE */

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

    /* INPUT MUX */

    always @(*) begin
        if(dmem_fsm_state == `S_FETCH) d = b_rdata_d;
        else if(wr_pend) begin
            d = q;
            case(wb_len)
                2'b00: d[8*wb_offs +:  8] = wb_data[ 7:0];
                2'b01: d[8*wb_offs +: 16] = wb_data[15:0];
                2'b10: d[8*wb_offs +: 32] = wb_data[31:0];
                2'b11: d[8*wb_offs +: 64] = wb_data[63:0];
            endcase
        end
        else begin
            d = q;
            case(len)
                2'b00: d[8*addr_offs +:  8] = wdata[ 7:0];
                2'b01: d[8*addr_offs +: 16] = wdata[15:0];
                2'b10: d[8*addr_offs +: 32] = wdata[31:0];
                2'b11: d[8*addr_offs +: 64] = wdata[63:0];
            endcase
        end
    end

    /* OUTPUT MUX */

    always @(*) begin
        case(len)
            3'b000: rdata =   $signed(q[8*addr_offs +:  8]);
            3'b001: rdata =   $signed(q[8*addr_offs +: 16]);
            3'b010: rdata =   $signed(q[8*addr_offs +: 32]);
            3'b011: rdata =   $signed(q[8*addr_offs +: 64]);
            3'b100: rdata = $unsigned(q[8*addr_offs +:  8]);
            3'b101: rdata = $unsigned(q[8*addr_offs +: 16]);
            3'b110: rdata = $unsigned(q[8*addr_offs +: 32]);
            3'b111: rdata = $unsigned(q[8*addr_offs +: 64]);
        endcase
    end

    /* HIT DETECTION */

    always @(*) begin : dmem_cache_hit
        integer w;
        way_q = 'bZ; hit = 0;
        for(w = 0; w < `DMEM_WAYS; w = w + 1) begin
            if(tag[`DMEM_WAYS * set_q + w] == tag_q && v[`DMEM_WAYS * set_q + w]) begin
                way_q = w; hit = 1;
            end
        end
    end

    /* BRAM READ */

    always @(*) begin
        tag_q = wr_pend ? wb_tag : addr_tag;
        set_q = wr_pend ? wb_set : addr_set;
    end

    /* BRAM WRITE */

    always @(*) begin
        tag_d = wr_pend ? wb_tag : addr_tag;
        set_d = wr_pend ? wb_set : addr_set;
    end

    assign stall_dmem = (rd && dmem_fsm_state_next) || ((rd ||wr) && wr_pend) || (dmem_fsm_state == `S_READY && dmem_fsm_state_next == `S_WRITE);

`endif//DMEM_SET_ASSOC

    // TODO:
    /* REPLACEMENT POLICY */

    always @(posedge clk) re <= $random() % `DMEM_WAYS;

    /* MISALIGNED ACCESS DETECTION */

`ifdef  DMEM_MA_NONE
    // DEBUG PURPOSES ONLY
    wire ma = 0;
`endif//DMEM_MA_NONE

`ifdef  DMEM_MA_CACHE_LINE
    reg  [63:0] ma_addr;
    wire [`DMEM_TAG_LEN-1:0] ma_addr_tag = ma_addr[`DMEM_ADDR_TAG_RANGE];
    wire [`DMEM_SET_LEN-1:0] ma_addr_set = ma_addr[`DMEM_ADDR_SET_RANGE];
    wire ma = ma_addr_tag != addr_tag || ma_addr_set != addr_set;

    always @(*) begin
        case(len[1:0])
            2'b00: ma_addr = addr + 0;
            2'b01: ma_addr = addr + 1;
            2'b10: ma_addr = addr + 3;
            2'b11: ma_addr = addr + 7;
        endcase
    end
`endif//DMEM_MA_CACHE_LINE

`ifdef  DMEM_MA_NATURAL
    reg ma;
    always @(*) begin
        case(len[1:0])
            2'b00: ma = 0;
            2'b01: ma = |addr[0:0];
            2'b10: ma = |addr[1:0];
            2'b11: ma = |addr[3:0];
        endcase
    end
`endif//DMEM_MA_NATURAL

    assign ld_ma = ma && rd;
    assign st_ma = ma && wr;

endmodule
