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

`define imem_read_valid_delay 2'd3

module imem(
    input                [63:0] pc,
    output reg           [31:0] ir,

    output               [63:0] b_addr_i,
    input      [`imem_line-1:0] b_data_i,
    output reg                  b_rd_i,
    input                       b_dv_i,

    // control signals
    input                       stall,
    output reg                  stall_imem,
    input                       rst_n,
    input                       clk
);

    reg [63:0] addr;
    assign b_addr_i = {addr[63:`imem_offs_len], {`imem_offs_len{1'b0}}};

    wire [ `imem_tag_len-1:0] addr_tag  = addr[63:64-`imem_tag_len];
    wire [ `imem_set_len-1:0] addr_set  = addr[`imem_set_len+`imem_offs_len-1:`imem_offs_len];
    wire [`imem_offs_len-1:0] addr_offs = addr[`imem_offs_len-1:0];

    localparam imem_size = `imem_sets * `imem_ways;

    (* ram_style = "block" *)
    reg  [    `imem_line-1:0] data [0: imem_size-1];
    reg  [ `imem_tag_len-1:0] tag  [0:`imem_sets-1][0:`imem_ways-1];
    reg                       v    [0:`imem_sets-1][0:`imem_ways-1];

    // replacement entry
    reg [`imem_way_len-1:0] re [0:`imem_sets-1];

    reg hit;
    reg ma;
    reg [`imem_line-1:0] cache_line_out;

    /* READ BUFFER */

    reg [`imem_tag_len-1:0] l_tag;
    reg [`imem_set_len-1:0] l_set;
    reg [   `imem_line-1:0] l_data;

    wire l_hit = l_tag == addr_tag && l_set == addr_set;

    /* MISALIGNED BUFFER */

    wire [63:0] addr_2 = addr + 63'd2;

    wire [ `imem_tag_len-1:0] addr_2_tag  = addr_2[63:64-`imem_tag_len];
    wire [ `imem_set_len-1:0] addr_2_set  = addr_2[`imem_set_len+`imem_offs_len-1:`imem_offs_len];

    reg [`imem_tag_len-1:0] ma_tag;
    reg [`imem_set_len-1:0] ma_set;
    reg [   `imem_line-1:0] ma_data;

    wire ma_hit = !ma || (ma_tag == addr_2_tag && ma_set == addr_2_set);

    /* CACHE READ */

    reg [`imem_set_len-1:0] set_q;
    reg [`imem_way_len-1:0] way_q;
    reg                     rde;
    always @(posedge clk) if(rde) cache_line_out <= data[`imem_ways*set_q + way_q];

    /* CACHE WRITE */

    reg [`imem_set_len-1:0] set_d;
    reg [`imem_way_len-1:0] way_d;
    reg                     wre;
    always @(posedge clk) if(wre) data[`imem_ways*set_d + way_d] <= b_data_i;

    /* FSM */

    reg [2:0] imem_fsm;
    reg [2:0] imem_fsm_next;
    reg [1:0] ld_cnt;

    reg ma_d;
    always @(posedge clk) ma_d <= ma;
    wire ma_re = ma & !ma_d;

    always @(*) begin
        addr = pc;
        b_rd_i = 0;
        set_d = 0;
        way_d = 0;
        set_q = 0;
        wre = 0;
        rde = 0;
        stall_imem = 1;

        imem_fsm_next = imem_fsm;
        case(imem_fsm)
            // READY
            3'd0: begin
                if(!hit) imem_fsm_next = 3'd1;
                if( hit) imem_fsm_next = 3'd2;
                if(l_hit &&  ma) imem_fsm_next = 3'd3;
                if(l_hit && !ma) imem_fsm_next = 3'd0;
                stall_imem = !l_hit || !ma_hit;
            end
            // FETCH
            3'd1: begin
                addr   = pc;
                b_rd_i = 1;
                set_d  = addr_set;
                way_d  = re[addr_set];
                wre    = b_dv_i;

                if(b_dv_i && !ma) imem_fsm_next = 3'd0;
                if(b_dv_i &&  ma) imem_fsm_next = 3'd3;
            end
            // LOAD
            3'd2: begin
                rde = ld_cnt == `imem_read_valid_delay;
                set_q = addr_set;
                if(ld_cnt == 2'd0 && !ma) imem_fsm_next = 3'd0;
                if(ld_cnt == 2'd0 &&  ma) imem_fsm_next = 3'd3;
            end
            // MA
            3'd3: begin
                addr = pc+2;
                if(!hit) imem_fsm_next = 3'd4;
                if( hit) imem_fsm_next = 3'd5;
            end
            // FETCH MA
            3'd4: begin
                b_rd_i = 1;
                addr = pc+2;

                if(b_dv_i) imem_fsm_next = 3'd0;
            end
            // LOAD MA
            3'd5: begin
                addr = pc+2;
                rde = ld_cnt == `imem_read_valid_delay;
                if(ld_cnt == 2'd0) imem_fsm_next = 3'd0;
            end
        endcase
    end

    always @(posedge clk) begin
        if(!rst_n) begin
            imem_fsm <= 3'd0;
            ld_cnt <= `imem_read_valid_delay;
            l_tag <= 0;
            l_set <= 0;
            ma_tag <= 0;
            ma_set <= 0;
        end
        else begin
            case(imem_fsm)
                // READY
                3'd0: begin
                    imem_fsm <= imem_fsm_next;
                end
                // FETCH
                3'd1: begin
                    if(b_dv_i) begin
                        l_tag  <= addr_tag;
                        l_set  <= addr_set;
                        l_data <= b_data_i;
                    end
                    imem_fsm <= imem_fsm_next;
                end
                // LOAD
                3'd2: begin
                    if(ld_cnt == 2'd0) begin
                        l_tag  <= addr_tag;
                        l_set  <= addr_set;
                        l_data <= cache_line_out;
                        ld_cnt <= `imem_read_valid_delay;
                    end
                    else ld_cnt <= ld_cnt - 1;
                    imem_fsm <= imem_fsm_next;
                end
                // MA
                3'd3: begin
                    imem_fsm <= imem_fsm_next;
                end
                // FETCH MA
                3'd4: begin
                    if(b_dv_i) begin
                        ma_tag <= addr_tag;
                        ma_set <= addr_set;
                        ma_data <= b_data_i;
                    end
                    imem_fsm <= imem_fsm_next;
                end
                // LOAD MA
                3'd5: begin
                    if(ld_cnt == 2'd0) begin
                        ma_tag <= addr_tag;
                        ma_set <= addr_set;
                        ma_data <= cache_line_out;
                        ld_cnt  <= `imem_read_valid_delay;
                    end
                    else ld_cnt <= ld_cnt - 1;
                    imem_fsm <= imem_fsm_next;
                end
            endcase
        end
    end

    /* HIT DETECTION */

    always @(*) begin : imem_cache_hit_check
        integer i;
        hit = 0; way_q = 0;
        for(i = 0; i < `imem_ways; i = i + 1) begin
            if((tag[addr_set][i] == addr_tag) && v[addr_set][i]) begin
                way_q = i; hit = 1;
            end
        end
    end

    /* MISALIGNED ACCESS DETECTION */

    always @(*) ma = addr[63:`imem_offs_len] != addr_2[63:`imem_offs_len];

    /* REPLACEMENT POLICY */

    // LRU tree
    localparam lru_size = `imem_ways - 1;
    reg [`imem_ways-1:0] lru_tree [0:`imem_sets-1];

    // find replacement entry and update LRU tree
    always @(posedge clk) begin
        if(!rst_n) begin : imem_clr_lru
            integer i;
            for(i = 0; i < `imem_sets; i = i + 1) lru_tree[i] = {lru_size{1'b1}};
        end
        else if(!stall) begin : imem_lru_update
            integer l, i, i_parent;
            i = (hit ? way_q : re[addr_set]) + lru_size;
            for(l = 0; l < $clog2(`imem_ways); l = l + 1) begin
                i_parent = (i[0] ? i-1 : i-2) >> 1;
                lru_tree[addr_set][i_parent] = !i[0];
                i = i_parent;
            end
        end
    end

    always @(posedge clk) begin
        if(!rst_n) begin :imem_clr_re
            integer i;
            for(i = 0; i < `imem_sets; i = i + 1) re[i] = {`imem_way_len{1'b0}};
        end
        else if(!stall) begin : imem_re_update
            integer l, i;
            i = 0;
            for(l = 0; l < $clog2(`imem_ways); l = l + 1) begin
                i = lru_tree[addr_set][i] ? (i<<1)+1 : (i<<1)+2;
            end
            re[addr_set] = i - `imem_ways + 1;
        end
    end

    /* CACHE METADATA UPDATE */

    always @(posedge clk) begin
        if(!rst_n) begin : imem_clr
            integer s, e;
            for(s = 0; s < `imem_sets; s = s + 1) begin
                for(e = 0; e < `imem_ways; e = e + 1) begin
                    v[s][e] <= 0;
                end
            end
        end
        else if(wre) begin
            v  [set_d][re[set_d]] <= 1'b1;
            tag[set_d][re[set_d]] <= addr_tag;
        end
    end

    /* INSTRUCTION REGISTER */

    always @(*) begin
        ir = 32'bZ; // TODO: remove
        if(imem_fsm == 3'd0 && !ma) begin
            ir = l_data[8*addr_offs +: 32];
        end
        if(imem_fsm == 3'd0 &&  ma) begin
            ir = {ma_data[15:0], l_data[8*addr_offs +: 16]};
        end
    end

endmodule
