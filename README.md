# RV6
**RV6** is configurable, 64-bit, multi-core application processor implemented in Verilog HDL, based on [RISC-V instruction set](https://riscv.org).

## Table of Contents
- [Features](https://github.com/kiclu/rv6#features)
- [Compatibility](https://github.com/kiclu/rv6#compatibility)
- [Core Architecture](https://github.com/kiclu/rv6#core-architecture)
- [Project Structure](https://github.com/kiclu/rv6#project-structure)
- [Parameters](https://github.com/kiclu/rv6#parameters)
- [Prerequisites](https://github.com/kiclu/rv6#prerequisites)
- [License](https://github.com/kiclu/rv6#license)

## Features
- RV64IMAC_Zicsr ISA extenstions
- Optimized 6-stage, single-issue, in-order pipeline
- Machine, Supervisor & User privilege modes
- Three level cache hierarchy
- Branch prediction
- Instruction pre-decoding for compressed & atomic instruction support
- Parametrized branch prediction, cache size and associativity

## Compatibility
RV6 core is compatible with following RISC-V Foundation specifications:
- [RISC-V Instruction Set Manual - Volume I: Unprivileged ISA](https://github.com/kiclu/rv6/blob/master/doc/riscv-unprivileged-isa.pdf), version 20191213
- [RISC-V Instruction Set Manual - Volume II: Privileged Architecture](https://github.com/kiclu/rv6/blob/master/doc/riscv-privileged-isa.pdf), version 20211203

## Core Architecture
Pipeline is split into following 6 stages:
- Instruction Fetch (IF)
- Instruction Pre-Decode (PD)
- Instruction Decode (ID)
- Execute (EX)
- Memory (MEM)
- Write Back (WB)

<img src="./doc/hart-schematic.png">

### Instruction Fetch (IF)
During the Instruction Fetch stage one instruction is fetched from instruction memory and the program counter is updated.<br>
If fetched instruction is JAL, next PC is immediately calculated and updated.<br>
If fetched instruction is a branch instruction, Branch Prediction Unit (BPU) predicts if branch is taken, updates PC if prediction is positive and passes the prediction to following stages.

### Instruction Pre-Decode (PD)
In the Instruction Pre-Decode stage multi-cycle, atomic and compressed instructions are pre-decoded.<br>
Multi-cycle instructions are broken down into multiple single-cycle instructions.<br>
Atomic instructions are, after receiving a handshake from Central Control Unit (CCU), broken-down into multiple single-cycle instructions.
Handshake is mandatory to ensure atomicty, i.e. ensure that only one core is accessing and modifying data.<br>
Compressed instructions are expanded into their non-compressed form.

### Instruction Decode (ID)
During the Instruction Decode stage registers are accessed and/or immediate is multiplexed and sign-extended.<br>
After registers are decoded, Branch ALU checks if branch prediction from IF is valid and generates branch miss signal if it isn't.<br>
Also, during this stage, JALR control transfer instruction updates the Program Counter.

### Execute (EX)
During the Execute stage, result is calculated for ALU instructions, memory address is calculated for Load / Store instructions and
return address is calculated for control transfer instructions.

### Memory (MEM)
During the Memory stage, Data Memory is accessed for Load and Store instructions, as well as Control & Status Registers for CSR instructions.

### Write Back (WB)
During the Write Back stage, the result from previous stages is written back into the Register File.

## Project Structure
```
.
├─ doc/             # Documentation files
├─ rtl/             # Synthesis source files
│   ├─ core/            # Core top-level & submodules
│   │   ├─ alu.v            # Integer ALU
│   │   ├─ bpu.v            # Branch Prediction Unit
│   │   ├─ br_alu.v         # Branch ALU
│   │   ├─ cmem.v           # L2 cache
│   │   ├─ core.v           # Core top-level module
│   │   ├─ csr.v            # Control & Status Registers
│   │   ├─ cu.v             # Control Unit
│   │   ├─ dba.v            # Data Bus Arbiter
│   │   ├─ dmem.v           # L1d cache
│   │   ├─ imem.v           # L1i cache
│   │   ├─ pc.v             # Program Counter
│   │   ├─ pd.v             # Instruction Pre-Decoder
│   │   └─ regfile.v        # Register File
│   └─ config.vh        # Configuration include file
├─ sim/             # ModelSim project files
├─ tb/              # Testbench source files
├─ tools/
├─ LICENSE
├─ Makefile
└─ README.md
```

## Parameters
| Parameter                                                                 | Type          | Description                                                           |
|---------------------------------------------------------------------------|---------------|-----------------------------------------------------------------------|
|  **L1i cache**                                                            |               |                                                                       |
| `IMEM_SET_ASSOC` `IMEM_DIRECT` `IMEM_FULL_ASSOC`                          | ifdef flag    | L1i cache associativity                                               |
| `IMEM_LINE`                                                               | integer       | L1i cache line size in bits                                           |
| `IMEM_SETS`                                                               | integer       | L1i cache set count                                                   |
| `IMEM_WAYS`                                                               | integer       | L1i cache ways per set                                                |
| **L1d cache**                                                             |               |                                                                       |
| `DMEM_SET_ASSOC` `DMEM_DIRECT` `DMEM_FULL_ASSOC`                          | ifdef flag    | L1d cache associativity                                               |
| `DMEM_LINE`                                                               | integer       | L1d cache line size in bits                                           |
| `DMEM_SETS`                                                               | integer       | L1d cache set count                                                   |
| `DMEM_WAYS`                                                               | integer       | L1d cache ways per set                                                |
| **L2 cache**                                                              |               |                                                                       |
| `CMEM_SET_ASSOC` `CMEM_DIRECT` `CMEM_FULL_ASSOC`                          | ifdef flag    | L2 cache associativity                                                |
| `CMEM_LINE`                                                               | integer       | L2 cache line size in bits                                            |
| `CMEM_SETS`                                                               | integer       | L2 cache set count                                                    |
| `CMEM_WAYS`                                                               | integer       | L2 cache ways per set                                                 |
| **Branch Prediction**                                                     |               |                                                                       |
| `BPU_STATIC_TAKEN`                                                        | ifdef flag    | Branch predict static taken                                           |
| `BPU_STATIC_NTAKEN`                                                       | ifdef flag    | Branch predict static not taken                                       |
| `BPU_STATIC_BTAKEN`                                                       | ifdef flag    | Branch predict static backward taken                                  |
| **Misaligned Access**                                                     |               |                                                                       |
| `DMEM_MA_CACHE_LINE`                                                      | ifdef flag    | L1d misaligned access exception on cache line boundary violation      |
| `DMEM_MA_NATURAL`                                                         | ifdef flag    | L1d misaligned access exception on natural alignment violation        |

*Parameters labeled with `ifdef flag` type are mutually exclusive

## Prerequisites
- [riscv-collab/riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain)
- [riscv-software-src/riscv-tests](https://github.com/riscv-software-src/riscv-tests)
- [chipsalliance/dromajo](https://github.com/chipsalliance/dromajo)

## License
The hardware is licensed under the [CERN Open Hardware Licence Version 2 - Strongly Reciprocal](https://ohwr.org/cern_ohl_s_v2.txt).
