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

/*----------------------------------------------------------------------------*/

`define RESET_VECTOR            64'h8000_0000

/*----------------------------------------------------------------------------*/

/* CACHE PARAMETERS */

`define EXT_MMAP_RANGE          64'h8000_0000

// L1i cache
`define IMEM_SET_ASSOC
`define IMEM_LINE               256
`define IMEM_SETS               2
`define IMEM_WAYS               2
`define IMEM_READ_VALID_DELAY   2

// L1d cache
`define DMEM_SET_ASSOC
`define DMEM_LINE               256
`define DMEM_SETS               2
`define DMEM_WAYS               2
`define DMEM_READ_VALID_DELAY   2

// L2 cache
`define CMEM_SET_ASSOC
`define CMEM_LINE               512
`define CMEM_SETS               2
`define CMEM_WAYS               2
`define CMEM_READ_VALID_DELAY   2

/*----------------------------------------------------------------------------*/

/* CACHE MISALIGNED DATA */

`define DMEM_MA_NATURAL

/*----------------------------------------------------------------------------*/

/* BRANCH PREDICTION */

`define BPU_STATIC_BTAKEN

/*----------------------------------------------------------------------------*/

/* OPCODES */

`define OP_LUI      7'b0110111
`define OP_AUIPC    7'b0010111
`define OP_JAL      7'b1101111
`define OP_JALR     7'b1100111
`define OP_BRANCH   7'b1100011
`define OP_LOAD     7'b0000011
`define OP_STORE    7'b0100011
`define OP_ALRI     7'b0010011
`define OP_ALRR     7'b0110011
`define OP_ALRIW    7'b0011011
`define OP_ALRRW    7'b0111011
`define OP_AMO      7'b0101111
`define OP_FENCE    7'b0001111
`define OP_SYSTEM   7'b1110011

/*----------------------------------------------------------------------------*/

`define XLEN                    64

`ifdef  IMEM_SET_ASSOC
`define IMEM_LINES              `IMEM_SETS * `IMEM_WAYS
`define IMEM_SET_LEN            $clog2(`IMEM_SETS)
`define IMEM_WAY_LEN            $clog2(`IMEM_WAYS)
`define IMEM_OFFS_LEN           $clog2(`IMEM_LINE/8)
`define IMEM_BLK_LEN            (`XLEN - `IMEM_OFFS_LEN                )
`define IMEM_TAG_LEN            (`XLEN - `IMEM_OFFS_LEN - `IMEM_SET_LEN)
`define IMEM_ADDR_TAG_RANGE     `XLEN                 - 1 -: `IMEM_TAG_LEN
`define IMEM_ADDR_SET_RANGE     `XLEN - `IMEM_TAG_LEN - 1 -: `IMEM_SET_LEN
`define IMEM_ADDR_OFFS_RANGE    `XLEN - `IMEM_BLK_LEN - 1 -: `IMEM_OFFS_LEN
`endif//IMEM_SET_ASSOC

/*----------------------------------------------------------------------------*/

`ifdef  DMEM_SET_ASSOC
`define DMEM_LINES              `DMEM_SETS * `DMEM_WAYS
`define DMEM_SET_LEN            $clog2(`DMEM_SETS)
`define DMEM_WAY_LEN            $clog2(`DMEM_WAYS)
`define DMEM_OFFS_LEN           $clog2(`DMEM_LINE/8)
`define DMEM_BLK_LEN            (`XLEN - `DMEM_OFFS_LEN                )
`define DMEM_TAG_LEN            (`XLEN - `DMEM_OFFS_LEN - `DMEM_SET_LEN)
`define DMEM_ADDR_TAG_RANGE     `XLEN                 - 1 -: `DMEM_TAG_LEN
`define DMEM_ADDR_SET_RANGE     `XLEN - `DMEM_TAG_LEN - 1 -: `DMEM_SET_LEN
`define DMEM_ADDR_OFFS_RANGE    `XLEN - `DMEM_BLK_LEN - 1 -: `DMEM_OFFS_LEN
`endif//DMEM_SET_ASSOC

/*----------------------------------------------------------------------------*/

`ifdef  CMEM_SET_ASSOC
`define CMEM_LINES              `CMEM_SETS * `CMEM_WAYS
`define CMEM_SET_LEN            $clog2(`CMEM_SETS)
`define CMEM_WAY_LEN            $clog2(`CMEM_WAYS)
`define CMEM_OFFS_LEN           $clog2(`CMEM_LINE/8)
`define CMEM_TAG_LEN            (`XLEN - `CMEM_OFFS_LEN - `CMEM_SET_LEN)
`define CMEM_BLK_LEN            `CMEM_TAG_LEN + `CMEM_SET_LEN

`define CMEM_I_OFFS_LEN         `CMEM_OFFS_LEN - `IMEM_OFFS_LEN
`define CMEM_I_ADDR_TAG_RANGE   `IMEM_BLK_LEN                 - 1 -: `CMEM_TAG_LEN
`define CMEM_I_ADDR_SET_RANGE   `IMEM_BLK_LEN - `CMEM_TAG_LEN - 1 -: `CMEM_SET_LEN
`define CMEM_I_ADDR_OFFS_RANGE  `CMEM_I_OFFS_LEN - 1 : 0

`define CMEM_D_OFFS_LEN         `CMEM_OFFS_LEN - `DMEM_OFFS_LEN
`define CMEM_D_ADDR_TAG_RANGE   `DMEM_BLK_LEN                 - 1 -: `CMEM_TAG_LEN
`define CMEM_D_ADDR_SET_RANGE   `DMEM_BLK_LEN - `CMEM_TAG_LEN - 1 -: `CMEM_SET_LEN
`define CMEM_D_ADDR_OFFS_RANGE  `CMEM_D_OFFS_LEN - 1 : 0

`define CMEM_W_OFFS_LEN         `CMEM_OFFS_LEN
`define CMEM_W_ADDR_TAG_RANGE   `XLEN                 - 1 -: `CMEM_TAG_LEN
`define CMEM_W_ADDR_SET_RANGE   `XLEN - `CMEM_TAG_LEN - 1 -: `CMEM_SET_LEN
`define CMEM_W_ADDR_OFFS_RANGE  `CMEM_W_OFFS_LEN - 1 : 0

`endif//CMEM_SET_ASSOC

/*----------------------------------------------------------------------------*/
