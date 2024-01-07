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

/* CACHE PARAMETERS */

`define IMEM_SET_ASSOC
`define IMEM_LINE               128
`define IMEM_SETS               2
`define IMEM_WAYS               2
`define IMEM_READ_VALID_DELAY   2

`define DMEM_SET_ASSOC
`define DMEM_LINE               128
`define DMEM_SETS               2
`define DMEM_WAYS               2
`define DMEM_READ_VALID_DELAY   2

`define HMEM_SET_ASSOC
`define HMEM_LINE               256
`define HMEM_SETS               2
`define HMEM_WAYS               2
`define HMEM_READ_VALID_DELAY   2

/* BRANCH PREDICTION */

`define BPU_STATIC_BTAKEN

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

`ifdef  HMEM_SET_ASSOC
`define HMEM_LINES              `HMEM_SETS * `HMEM_WAYS
`define HMEM_SET_LEN            $clog2(`HMEM_SETS)
`define HMEM_WAY_LEN            $clog2(`HMEM_WAYS)
`define HMEM_OFFS_LEN           $clog2(`HMEM_LINE/8)
`define HMEM_BLK_LEN            (`XLEN - `HMEM_OFFS_LEN                )
`define HMEM_TAG_LEN            (`XLEN - `HMEM_OFFS_LEN - `HMEM_SET_LEN)
`define HMEM_ADDR_TAG_RANGE     `XLEN                 - 1 -: `HMEM_TAG_LEN
`define HMEM_ADDR_SET_RANGE     `XLEN - `HMEM_TAG_LEN - 1 -: `HMEM_SET_LEN
`define HMEM_ADDR_OFFS_RANGE    `XLEN - `HMEM_BLK_LEN - 1 -: `HMEM_OFFS_LEN
`endif//HMEM_SET_ASSOC

/*----------------------------------------------------------------------------*/
