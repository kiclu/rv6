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

module pd(
    input      [63:0] pc_in,
    input      [31:0] ir_in,

    output reg [31:0] ir_out,

    output reg        amo_req,
    input             amo_ack,

    input             stall,

    input             rst_n,

    input             clk
);

    // AMO sequence counter
    reg [1:0] sc;

    // compressed instruction ir
    wire [4:0] rvc_ir = {ir_in[15:13], ir_in[1:0]};
    // compressed instruction register decode
    wire [4:0] rvc1 = {2'b0, ir_in[9:7]} + 5'd8;
    wire [4:0] rvc2 = {2'b0, ir_in[4:2]} + 5'd8;

    always @(*) begin
        ir_out <= ir_in;
        amo_req <= 0;

        /* AMO INSTRUCTIONS */
        case({ir_in[31:27], ir_in[6:0]})
            // lr.w
            12'b00010_0101111: begin
                // TODO
            end

            // sc.w
            12'b00011_0101111: begin
                // TODO
            end

            // amoswap.w
            12'b00001_0101111: begin
                case(sc)
                    2'b00: begin
                        amo_req <= 1;
                        ir_out <= {12'b0, ir_in[19:7], 7'b0000011};
                    end
                    2'b01: begin
                        amo_req <= 1;
                        ir_out <= {7'b0, ir_in[24:12], 5'b0, 7'b0100011};
                    end
                endcase
            end

            // amoadd.w
            12'b00000_0101111: begin
                case(sc)
                    2'b00: begin
                        amo_req <= 1;
                        ir_out <= {12'b0, ir_in[19:7], 7'b0000011};
                    end
                    2'b01: begin
                        amo_req <= 1;
                        ir_out <= {7'b0, ir_in[24:20], ir_in[11:7], 3'b000, ir_in[11:7], 7'b0110011};
                    end
                    2'b10: begin
                        amo_req <= 1;
                        ir_out <= {7'b0, ir_in[24:12], 5'b0, 7'b0100011};
                    end
                endcase
            end

            // amoxor.w
            12'b00100_0101111: begin
                case(sc)
                    2'b00: begin
                        amo_req <= 1;
                        ir_out <= {12'b0, ir_in[19:7], 7'b0000011};
                    end
                    2'b01: begin
                        amo_req <= 1;
                        ir_out <= {7'b0, ir_in[24:20], ir_in[11:7], 3'b100, ir_in[11:7], 7'b0110011};
                    end
                    2'b10: begin
                        amo_req <= 1;
                        ir_out <= {7'b0, ir_in[24:12], 5'b0, 7'b0100011};
                    end
                endcase
            end

            // amoand.w
            12'b01100_0101111: begin
                case(sc)
                    2'b00: begin
                        amo_req <= 1;
                        ir_out <= {12'b0, ir_in[19:7], 7'b0000011};
                    end
                    2'b01: begin
                        amo_req <= 1;
                        ir_out <= {7'b0, ir_in[24:20], ir_in[11:7], 3'b111, ir_in[11:7], 7'b0110011};
                    end
                    2'b10: begin
                        amo_req <= 1;
                        ir_out <= {7'b0, ir_in[24:12], 5'b0, 7'b0100011};
                    end
                endcase
            end

            // amoor.w
            12'b01000_0101111: begin
                case(sc)
                    2'b00: begin
                        amo_req <= 1;
                        ir_out <= {12'b0, ir_in[19:7], 7'b0000011};
                    end
                    2'b01: begin
                        amo_req <= 1;
                        ir_out <= {7'b0, ir_in[24:20], ir_in[11:7], 3'b110, ir_in[11:7], 7'b0110011};
                    end
                    2'b10: begin
                        amo_req <= 1;
                        ir_out <= {7'b0, ir_in[24:12], 5'b0, 7'b0100011};
                    end
                endcase
            end

            // amomin.w
            12'b10000_0101111: begin
                // TODO
            end

            // amomax.w
            12'b10100_0101111: begin
                // TODO
            end

            // amominu.w
            12'b11000_0101111: begin
                // TODO
            end

            // amomaxu.w
            12'b11100_0101111: begin
                // TODO
            end

        endcase

        /* COMPRESSED INSTRUCTIONS */
        case(rvc_ir)
            // c.addi4spn
            16'b00000: begin
                ir_out <= {2'b0, ir_in[10:7], ir_in[12:11], ir_in[5], ir_in[6], 2'b00, 5'b00010, 3'b000, rvc2, 7'b0010011};
            end

            // c.lw
            16'b01000: begin
                ir_out <= {6'b000000, ir_in[5], ir_in[12:10], ir_in[6], 2'b00, rvc1, 3'b010, rvc2, 7'b0000011};
            end

            // c.ld
            16'b01100: begin
                ir_out <= {5'b00000, ir_in[6:5], ir_in[12:10], 3'b000, rvc1, 3'b011, rvc2, 7'b0000011};
            end

            // c.sw
            16'b11000: begin
                ir_out <= {6'b000000, ir_in[5], ir_in[12], rvc2, rvc1, 3'b010, ir_in[11:10], ir_in[6], 2'b00, 7'b0100011};
            end

            // c.sd
            16'b11100: begin
                ir_out <= {4'b0000, ir_in[6:5], ir_in[12], rvc2, rvc1, 3'b011, ir_in[11:10], 3'b000, 7'b0100011};
            end

            // c.addi
            16'b00001: begin
                ir_out <= {{6{ir_in[12]}}, ir_in[12], ir_in[6:2], ir_in[11:7], 3'b000, ir_in[11:7], 7'b0010011};
            end

            // c.addiw
            16'b00101: begin
                ir_out <= {{6{ir_in[12]}}, ir_in[12], ir_in[6:2], ir_in[11:7], 3'b000, ir_in[11:7], 7'b0011011};
            end

            // c.li
            16'b01001: begin
                ir_out <= {{6{ir_in[12]}}, ir_in[12], ir_in[6:2], 5'b00000, 3'b000, ir_in[11:7], 7'b0010011};
            end

            // c.lui/addi16sp
            16'b01101: begin
                // addi16sp
                if(ir_in[11:7] == 5'b00010) begin
                    ir_out <= {{6{ir_in[12]}}, ir_in[12], ir_in[4:3], ir_in[5], ir_in[2], ir_in[6], 4'b0000, 5'b00010, 3'b000, 5'b00010, 7'b0010011};
                end
                // lui
                else begin
                    ir_out <= {{14{ir_in[12]}}, ir_in[12], ir_in[6:2], ir_in[11:7], 7'b0110111};
                end
            end

            // misc-alu
            16'b10001: begin
                case(ir_in[11:10])
                    // c.srli
                    2'b00: begin
                        ir_out <= {7'b0000000, ir_in[12], ir_in[6:2], rvc1, 3'b101, rvc1, 7'b0010011};
                    end

                    // c.srai
                    2'b01: begin
                        ir_out <= {7'b0100000, ir_in[12], ir_in[6:2], rvc1, 3'b101, rvc1, 7'b0010011};
                    end

                    // c.andi
                    2'b10: begin
                        ir_out <= {{6{ir_in[12]}}, ir_in[12], ir_in[6:2], rvc1, 3'b111, rvc1, 7'b0010011};
                    end

                    2'b11: begin
                        case({ir_in[12], ir_in[6:5]})
                            // c.sub
                            5'b000: begin
                                ir_out <= {7'b0100000, rvc2, rvc1, 3'b000, rvc1, 7'b0110011};
                            end
                            // c.xor
                            5'b001: begin
                                ir_out <= {7'b0000000, rvc2, rvc1, 3'b100, rvc1, 7'b0110011};
                            end
                            // c.or
                            5'b010: begin
                                ir_out <= {7'b0000000, rvc2, rvc1, 3'b110, rvc1, 7'b0110011};
                            end
                            // c.and
                            5'b011: begin
                                ir_out <= {7'b0000000, rvc2, rvc1, 3'b111, rvc1, 7'b0110011};
                            end
                            // c.subw
                            5'b100: begin
                                ir_out <= {7'b0100000, rvc2, rvc1, 3'b000, rvc1, 7'b0111011};
                            end
                            // c.addw
                            5'b101: begin
                                ir_out <= {7'b0000000, rvc2, rvc1, 3'b000, rvc1, 7'b0111011};
                            end

                        endcase
                    end

                endcase
            end

            // c.j
            16'b10101: begin
                ir_out <= {1'b0, ir_in[8], ir_in[10:9], ir_in[6], ir_in[7], ir_in[2], ir_in[11], ir_in[5:3], ir_in[12], 5'b00000, 7'b1101111};
            end

            // c.beqz
            16'b11001: begin
                ir_out <= {3'b000, ir_in[12], ir_in[6:5], ir_in[2], 5'b00000, rvc1, 3'b000, ir_in[11:10], ir_in[4:3], 1'b0, 7'b1100011};
            end

            // c.bnez
            16'b11101: begin
                ir_out <= {3'b000, ir_in[12], ir_in[6:5], ir_in[2], 5'b00000, rvc1, 3'b001, ir_in[11:10], ir_in[4:3], 1'b0, 7'b1100011};
            end

            // c.slli
            16'b00010: begin
                ir_out <= {7'b0000000, ir_in[12], ir_in[6:2], ir_in[11:7], 3'b001, ir_in[11:7], 7'b0010011};
            end

            // c.lwsp
            16'b01010: begin
                ir_out <= {4'b0000, ir_in[3:2], ir_in[12], ir_in[6:4], 2'b00, 5'b00010, 3'b010, ir_in[11:7], 7'b0000011};
            end

            // c.ldsp
            16'b01110: begin
                ir_out <= {6'b0, ir_in[4:2], ir_in[12], ir_in[6:5], 3'b000, 5'b00010, 3'b011, ir_in[11:7], 7'b0000011};
            end

            // c.j[al]r/mv/add
            16'b10010: begin
                if(!ir_in[12]) begin
                    // c.jr
                    if(ir_in[6:2] == 5'b00000) begin
                        ir_out <= {12'b000000000000, ir_in[11:7], 3'b000, 5'b00000, 7'b1100111};
                    end
                    // c.mv
                    else begin
                        ir_out <= {7'b0000000, ir_in[6:2], 5'b00000, 3'b000, ir_in[11:7], 7'b0110011};
                    end
                end
                else begin
                    // c.ebreak
                    if(ir_in[11:7] == 5'b00000 && ir_in[6:2] == 5'b00000) begin
                        ir_out <= 32'h00100073;
                    end
                    // c.jalr
                    else if(ir_in[6:2] == 5'b00000) begin
                        ir_out <= {12'b000000000000, ir_in[11:7], 3'b000, 5'b00001, 7'b1100111};
                    end
                    // c.add
                    else begin
                        ir_out <= {7'b0000000, ir_in[6:2], ir_in[11:7], 3'b000, ir_in[11:7], 7'b0110011};
                    end
                end
            end

            // c.swsp
            16'b11010: begin
                ir_out <= {4'b0000, ir_in[8:7], ir_in[12], ir_in[6:2], 5'b00010, 3'b010, ir_in[12:10], 2'b00, 7'b0100011};
            end

            // c.sdsp
            16'b11110: begin
                ir_out <= {3'b000, ir_in[9:7], ir_in[12], ir_in[6:2], 5'b00010, 3'b011, ir_in[12:11], 3'b000, 7'b0100011};
            end

        endcase
    end

    always @(posedge clk) begin
        if(!rst_n) sc <= 0;
        else if(!stall) begin
            if( amo_ack) sc <= sc + 1;
            if(!amo_req) sc <= 0;
        end
    end

endmodule
