# RV6
**RV6** is configurable, 64-bit, multi-core application processor implemented in Verilog HDL, based on [RISC-V instruction set](https://riscv.org).

## Table of Contents
- [Features](https://github.com/kiclu/rv6#features)
- [Compatibility](https://github.com/kiclu/rv6#compatibility)
- [Hart Architecture](https://github.com/kiclu/rv6#hart-architecture)
- [Project Structure](https://github.com/kiclu/rv6#project-structure)
- [Parameters](https://github.com/kiclu/rv6#parameters)
- [License](https://github.com/kiclu/rv6#license)

## Features
- RV64IMAC_Zicsr ISA extenstions
- Optimized 6-stage, single-issue, in-order pipeline
- Machine, Supervisor & User privilege modes
- Three level cache hierarchy
- Branch prediction
- Instruction pre-decoding for compressed & atomic instruction support
- Parametrized branch prediction, cache sizes and architectures

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
├─ hdl/             # Synthesis source files
│   ├─ hart/            # Hart top-level & submodules
│   │   ├─ alu.v            # Integer ALU
│   │   ├─ bpu.v            # Branch Prediction Unit
│   │   ├─ br_alu.v         # Branch ALU
│   │   ├─ csr.v            # Control & Status Registers
│   │   ├─ cu.v             # Control Unit
│   │   ├─ dmem.v           # Data Memory (L1d cache)
│   │   ├─ hart.v           # Core top-level module
│   │   ├─ hmem.v           # Hart Memory (L2 cache)
│   │   ├─ imem.v           # Instruction Memory (L1i cache)
│   │   ├─ pc.v             # Program Counter
│   │   ├─ pd.v             # Instruction Pre-Decoder
│   │   └─ regfile.v        # Register File
│   ├─ config.v         # Configuration include file
│   └─ rv6.v            # Top-level CPU module
├─ simulation/      # ModelSim project files
├─ synthesis/       # Vivado & Quartus II project files
├─ test/            # Testbench source files
│   ├─ auto/            # Automated tests
│   ├─ c/               # C source files for automated tests
│   └─ tb_hart.sv       # Hart testbench module
├─ LICENSE
├─ Makefile
└─ README.md
```

## Parameters
| Parameter                                                             	  | Type    	    | Description                                      	|
|---------------------------------------------------------------------------|---------------|---------------------------------------------------|
|  **Instruction memory (L1i cache)**                                       |               |                                                   |
| `imem_struct_set_assoc`  	                                                | ifdef flag    | L1i cache set associative architecture          	|
| `imem_struct_direct`                                                      | ifdef flag    | L1i cache direct mapped architecture              |
| `imem_struct_full_assoc`                                                  | ifdef flag    | L1i cache fully associative architecture          |
| `imem_line`                                                           	  | integer 	    | L1i cache line size in bits 	                    |
| `imem_sets`                                                           	  | integer 	    | L1i cache set count         	                    |
| `imem_ways`                                                           	  | integer 	    | L1i cache ways per set      	                    |
| **Data memory (L1d cache)**                                               |               |                                                   |
| `dmem_struct_set_assoc`  	                                                | ifdef flag    | L1d cache set associative architecture          	|
| `dmem_struct_direct`                                                      | ifdef flag    | L1d cache direct mapped architecture              |
| `dmem_struct_full_assoc`                                                  | ifdef flag    | L1d cache fully associative architecture          |
| `dmem_line`                                                           	  | integer 	    | L1d cache line size in bits 	                    |
| `dmem_sets`                                                           	  | integer 	    | L1d cache set count         	                    |
| `dmem_ways`                                                           	  | integer 	    | L1d cache ways per set      	                    |
| **HART memory (L2d cache)**                                               |               |                                                   |
| `hmem_struct_set_assoc`  	                                                | ifdef flag    | L2 cache set associative architecture          	  |
| `hmem_struct_direct`                                                      | ifdef flag    | L2 cache direct mapped architecture               |
| `hmem_struct_full_assoc`                                                  | ifdef flag    | L2 cache fully associative architecture           |
| `hmem_line`                                                           	  | integer 	    | L2 cache line size in bits 	                      |
| `hmem_sets`                                                           	  | integer 	    | L2 cache set count         	                      |
| `hmem_ways`                                                           	  | integer 	    | L2 cache ways per set      	                      |
| **Branch Prediction**                                                     |               |                                                   |
| `bpu_static_taken`                                                        | ifdef flag    | Branch predict static taken                       |
| `bpu_static_ntaken`                                                       | ifdef flag    | Branch predict static not taken                   |
| `bpu_static_btaken`                                                       | ifdef flag    | Branch predict static backward taken              |

*Parameters labeled with `ifdef flag` type are conditional compilation flags and are included in the project only if corresponding flag is defined in `config.v` file.

## License
The hardware is licensed under the [CERN Open Hardware Licence Version 2 - Strongly Reciprocal](https://ohwr.org/cern_ohl_s_v2.txt).
