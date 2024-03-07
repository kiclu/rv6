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

module cmem (
    // write bus
    input                   [63:0] b_addr_w,
    input                   [63:0] b_wdata_w,
    input                   [ 1:0] b_len_w,
    input                          b_wr_w,

    // imem read bus
    input      [`IMEM_BLK_LEN-1:0] b_addr_i,
    output reg [   `IMEM_LINE-1:0] b_data_i,
    input                          b_rd_i,
    output reg                     b_dv_i,

    // dmem read bus
    input      [`DMEM_BLK_LEN-1:0] b_addr_d,
    output reg [   `DMEM_LINE-1:0] b_rdata_d,
    input                          b_rd_d,
    output reg                     b_dv_d,

    // external bus
    output reg [`CMEM_BLK_LEN-1:0] b_addr_c,
    input      [   `CMEM_LINE-1:0] b_rdata_c,
    output reg                     b_rd_c,
    input                          b_dv_c,

    // cache invalidation
    input      [`CMEM_BLK_LEN-1:0] b_inv_addr_c,
    input                          inv,

    // control signals
    input                          rst_n,
    input                          clk
);

`ifdef  CMEM_SET_ASSOC

    wire [   `CMEM_TAG_LEN-1:0] addr_i_tag  = b_addr_i[`CMEM_I_ADDR_TAG_RANGE ];
    wire [   `CMEM_SET_LEN-1:0] addr_i_set  = b_addr_i[`CMEM_I_ADDR_SET_RANGE ];
    wire [`CMEM_I_OFFS_LEN-1:0] addr_i_offs = b_addr_i[`CMEM_I_ADDR_OFFS_RANGE];

    wire [   `CMEM_TAG_LEN-1:0] addr_d_tag  = b_addr_d[`CMEM_D_ADDR_TAG_RANGE ];
    wire [   `CMEM_SET_LEN-1:0] addr_d_set  = b_addr_d[`CMEM_D_ADDR_SET_RANGE ];
    wire [`CMEM_D_OFFS_LEN-1:0] addr_d_offs = b_addr_d[`CMEM_D_ADDR_OFFS_RANGE];

    wire [   `CMEM_TAG_LEN-1:0] addr_w_tag  = b_addr_w[`CMEM_W_ADDR_TAG_RANGE ];
    wire [   `CMEM_SET_LEN-1:0] addr_w_set  = b_addr_w[`CMEM_W_ADDR_SET_RANGE ];
    wire [`CMEM_W_OFFS_LEN-1:0] addr_w_offs = b_addr_w[`CMEM_W_ADDR_OFFS_RANGE];

    (* ram_style = "block" *)
    reg  [   `CMEM_LINE-1:0] data [0:`CMEM_LINES-1];
    reg  [`CMEM_TAG_LEN-1:0] tag  [0:`CMEM_LINES-1];
    reg                      v    [0:`CMEM_LINES-1];

    reg  [`CMEM_WAY_LEN-1:0] re;
    reg  hit_i;
    reg  hit_d;
    reg  hit_w;

    /* BRAM WRITE */

    reg  [`CMEM_TAG_LEN-1:0] tag_d;
    reg  [`CMEM_SET_LEN-1:0] set_d;
    reg  [`CMEM_WAY_LEN-1:0] way_d;
    reg  [   `CMEM_LINE-1:0] d;
    reg  wre;
    always @(posedge clk) if(wre) data[`CMEM_WAYS * set_d + way_d] <= d;

    /* BRAM READ I */

    reg  [`CMEM_TAG_LEN-1:0] tag_qi;
    reg  [`CMEM_SET_LEN-1:0] set_qi;
    reg  [`CMEM_WAY_LEN-1:0] way_qi;
    reg  [   `CMEM_LINE-1:0] qi;
    reg  rde_i;
    always @(posedge clk) if(rde_i) qi <= data[`CMEM_WAYS * set_qi + way_qi];

    /* BRAM READ D */

    reg  [`CMEM_TAG_LEN-1:0] tag_qd;
    reg  [`CMEM_SET_LEN-1:0] set_qd;
    reg  [`CMEM_WAY_LEN-1:0] way_qd;
    reg  [   `CMEM_LINE-1:0] qd;
    reg  rde_d;
    always @(posedge clk) if(rde_d) qd <= data[`CMEM_WAYS * set_qd + way_qd];

    /* READ BUFFER */

    reg  [`CMEM_TAG_LEN-1:0] rb_tag_i;
    reg  [`CMEM_SET_LEN-1:0] rb_set_i;
    reg                      rb_v_i;

    wire rb_hit_i = rb_v_i && rb_tag_i == addr_i_tag && rb_set_i == addr_i_set;

    reg  [`CMEM_TAG_LEN-1:0] rb_tag_d;
    reg  [`CMEM_SET_LEN-1:0] rb_set_d;
    reg                      rb_v_d;

    wire rb_hit_d = rb_v_d && rb_tag_d == addr_d_tag && rb_set_d == addr_d_set;
    wire rb_hit_w = rb_v_d && rb_tag_d == addr_w_tag && rb_set_d == addr_w_set;

    /* WRITE BUFFER */

    reg  [ `CMEM_TAG_LEN-1:0] wb_tag;
    reg  [ `CMEM_SET_LEN-1:0] wb_set;
    reg  [`CMEM_OFFS_LEN-1:0] wb_offs;
    reg  [              63:0] wb_data;
    reg  [               1:0] wb_len;
    reg  wr_pend;

    /* FSM */

    reg  [3:0] ld_cnt;

    reg  [1:0] cmem_fsm_state;
    reg  [1:0] cmem_fsm_state_next;

    `define CMEM_S_READY 2'd0
    `define CMEM_S_FETCH 2'd1
    `define CMEM_S_LOAD  2'd2
    `define CMEM_S_WRITE 2'd3

    reg  [1:0] pend;
    reg  [1:0] pend_next;

    `define PEND_NOP    2'd0
    `define PEND_RD_I   2'd1
    `define PEND_RD_D   2'd2
    `define PEND_WR_D   2'd3

    always @(*) begin
        // TODO: latch inference
        b_rd_c  = 0;
        rde_i   = 0;
        rde_d   = 0;
        wre     = 0;

        pend_next = pend;
        cmem_fsm_state_next = cmem_fsm_state;
        case(cmem_fsm_state)
            `CMEM_S_READY: begin
                if(b_rd_i &&    !hit_i && !pend_next) cmem_fsm_state_next = `CMEM_S_FETCH;
                if(b_rd_i &&     hit_i && !pend_next) cmem_fsm_state_next = `CMEM_S_LOAD;
                if(b_rd_i &&  rb_hit_i && !pend_next) cmem_fsm_state_next = `CMEM_S_READY;
                if(cmem_fsm_state_next && !pend_next) pend_next = `PEND_RD_I;

                if(b_rd_d &&    !hit_d && !pend_next) cmem_fsm_state_next = `CMEM_S_FETCH;
                if(b_rd_d &&     hit_d && !pend_next) cmem_fsm_state_next = `CMEM_S_LOAD;
                if(b_rd_d &&  rb_hit_d && !pend_next) cmem_fsm_state_next = `CMEM_S_READY;
                if(cmem_fsm_state_next && !pend_next) pend_next = `PEND_RD_D;

                if(b_wr_w &&    !hit_d && !pend_next) cmem_fsm_state_next = `CMEM_S_FETCH;
                if(b_wr_w &&     hit_d && !pend_next) cmem_fsm_state_next = `CMEM_S_LOAD;
                if(b_wr_w &&  rb_hit_w && !pend_next) cmem_fsm_state_next = `CMEM_S_WRITE;
                if(cmem_fsm_state_next && !pend_next) pend_next = `PEND_WR_D;
            end
            `CMEM_S_FETCH: begin
                b_rd_c = 1;
                wre    = b_dv_c;

                if(b_dv_c) cmem_fsm_state_next = `CMEM_S_LOAD;
            end
            `CMEM_S_LOAD: begin
                if(pend == `PEND_RD_I) rde_i = ld_cnt == `CMEM_READ_VALID_DELAY;
                else rde_d = ld_cnt == `CMEM_READ_VALID_DELAY;

                pend_next = pend == `PEND_WR_D ? `PEND_WR_D : `PEND_NOP;
                if(!ld_cnt) cmem_fsm_state_next = pend == `PEND_WR_D ? `CMEM_S_WRITE : `CMEM_S_READY;
            end
            `CMEM_S_WRITE: begin
                wre = 1;
                pend_next = `PEND_NOP;
                cmem_fsm_state_next = `CMEM_S_READY;
            end
        endcase
    end

    /* FSM UPDATE */

    always @(posedge clk) begin
        if(!rst_n) cmem_fsm_state <= `CMEM_S_READY;
        else cmem_fsm_state <= cmem_fsm_state_next;
    end

    /* PENDING OP UPDATE */

    always @(posedge clk) begin
        if(!rst_n) pend <= `PEND_NOP;
        else pend <= pend_next;
    end

    /* READ BUFFER */

    always @(posedge clk) begin
        if(!rst_n) begin
            rb_tag_i <= 0;
            rb_set_i <= 0;
            rb_v_i   <= 0;
        end
        else if(cmem_fsm_state == `CMEM_S_LOAD && pend == `PEND_RD_I) begin
            rb_tag_i <= addr_i_tag;
            rb_set_i <= addr_i_set;
            rb_v_i   <= 1;
        end
    end

    always @(posedge clk) begin
        if(!rst_n) begin
            rb_tag_d <= 0;
            rb_set_d <= 0;
            rb_v_d   <= 0;
        end
        else if(cmem_fsm_state == `CMEM_S_WRITE) rb_v_d <= 0;
        else if(cmem_fsm_state == `CMEM_S_LOAD) begin
            if(pend == `PEND_RD_D) begin
                rb_tag_d <= addr_d_tag;
                rb_set_d <= addr_d_set;
                rb_v_d   <= 1;
            end
            if(pend == `PEND_WR_D) begin
                rb_tag_d <= wb_tag;
                rb_set_d <= wb_set;
                rb_v_d   <= 1;
            end
        end
        ld_cnt <= cmem_fsm_state == `CMEM_S_LOAD ? ld_cnt - 1 : `CMEM_READ_VALID_DELAY;
    end

    /* WRITE BUFFER */

    always @(posedge clk) begin
        if(!rst_n || cmem_fsm_state == `CMEM_S_WRITE) begin
            wb_tag  <= 0;
            wb_set  <= 0;
            wb_offs <= 0;
            wb_data <= 0;
            wb_len  <= 0;
            wr_pend <= 0;
        end
        else if(b_wr_w && cmem_fsm_state == `CMEM_S_READY) begin
            wb_tag  <= addr_w_tag;
            wb_set  <= addr_w_set;
            wb_offs <= addr_w_offs;
            wb_data <= b_wdata_w;
            wb_len  <= b_len_w;
            wr_pend <= 1;
        end
    end

    /* REQUEST ADDRESS */

    always @(*) begin
        b_addr_c = 0;
        case(pend_next)
            `PEND_RD_I: b_addr_c = {addr_i_tag, addr_i_set};
            `PEND_RD_D: b_addr_c = {addr_d_tag, addr_d_set};
            `PEND_WR_D: b_addr_c = {addr_d_tag, addr_d_set};
        endcase
    end

    /* METADATA UPDATE */

    always @(posedge clk) begin
        if(!rst_n) begin : cmem_reset
            integer i;
            for(i = 0; i < `CMEM_LINES; i = i + 1) begin
                tag[i] <= 0;
                v  [i] <= 0;
            end
        end
        else begin
            if(wre && cmem_fsm_state == `CMEM_S_FETCH) begin
                tag[`CMEM_WAYS * set_d + way_d] <= tag_d;
                v  [`CMEM_WAYS * set_d + way_d] <= 1;
            end
        end
    end

    /* INPUT MUX */

    always @(*) begin
        if(cmem_fsm_state == `CMEM_S_WRITE) begin
            d = qd;
            case(wb_len)
                2'b00: d[8*wb_offs +:  8] = wb_data[ 7:0];
                2'b01: d[8*wb_offs +: 16] = wb_data[15:0];
                2'b10: d[8*wb_offs +: 32] = wb_data[31:0];
                2'b11: d[8*wb_offs +: 64] = wb_data[63:0];
            endcase
        end
        else d = b_rdata_c;
    end

    /* OUTPUT MUX */

    always @(*) begin
        b_data_i  = qi[`IMEM_LINE*addr_i_offs +: `IMEM_LINE];
        b_dv_i = rb_hit_i;
    end

    always @(*) begin
        b_rdata_d = qd[`DMEM_LINE*addr_d_offs +: `DMEM_LINE];
        b_dv_d = rb_hit_d;
    end

    /* HIT DETECTION */

    always @(*) begin : cmem_cache_hit
        integer w;

        way_qi = 'bZ; hit_i = 0;
        for(w = 0; w < `CMEM_WAYS; w = w + 1) begin
            if(tag[`CMEM_WAYS * set_qi + w] == tag_qi && v[`CMEM_WAYS * set_qi + w]) begin
                way_qi = w; hit_i = 1;
            end
        end

        way_qd = 'bZ; hit_d = 0;
        for(w = 0; w < `CMEM_WAYS; w = w + 1) begin
            if(tag[`CMEM_WAYS * set_qd + w] == tag_qd && v[`CMEM_WAYS * set_qd + w]) begin
                way_qd = w; hit_d = 1;
            end
        end

        hit_w = 0;
        for(w = 0; w < `CMEM_WAYS; w = w + 1) begin
            if(tag[`CMEM_WAYS * wb_set + w] == wb_tag && v[`CMEM_WAYS * wb_set + w]) begin
                if(pend_next == `PEND_WR_D) way_qd = w;
                hit_w = 1;
            end
        end
    end

    /* BRAM READ */

    always @(*) begin
        tag_qi = addr_i_tag;
        set_qi = addr_i_set;
    end

    always @(*) begin
        tag_qd = pend == `PEND_WR_D ? wb_tag : addr_d_tag;
        set_qd = pend == `PEND_WR_D ? wb_set : addr_d_set;
    end

    /* BRAM WRITE */

    always @(*) begin
        tag_d = 'bZ; set_d = 'bZ;
        case(pend)
            `PEND_RD_I: begin
                tag_d = addr_i_tag;
                set_d = addr_i_set;
            end
            `PEND_RD_D: begin
                tag_d = addr_d_tag;
                set_d = addr_d_set;
            end
            `PEND_WR_D: begin
                tag_d = wb_tag;
                set_d = wb_set;
            end
        endcase
    end

    always @(*) begin
        way_d = cmem_fsm_state == `CMEM_S_WRITE ? way_qd : re;
    end

`endif//CMEM_SET_ASSOC

    // TODO:
    /* REPLACEMENT POLICY */

    always @(posedge clk) re <= $random() % `CMEM_WAYS;

endmodule
