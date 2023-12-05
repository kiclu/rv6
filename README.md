# RV6
Multi-core RISC-V application processor.

## Table of Contents
- [Hart Architecture](https://github.com/kiclu/rv6#hart-architecture)
- [Project Structure](https://github.com/kiclu/rv6#project-structure)
- [License](https://github.com/kiclu/rv6#license)

## Hart Architecture
<img src="./doc/hart-schematic.png">

## Project Structure
```
.
├─ doc/             # Documentation files
├─ hdl/             # Synthesis source files
│   ├─ hart/            # Hart top-level & submodules
│   │   ├─ alu.v                # Integer ALU
│   │   ├─ bpu.v                # Branch Prediction Unit
│   │   ├─ br_alu.v             # Branch ALU
│   │   ├─ cu.v                 # Control Unit
│   │   ├─ dmem.v               # Data Memory (L1d cache)
│   │   ├─ hart.v               # Core top-level module
│   │   ├─ hmem.v               # Hart Memory (L2 cache)
│   │   ├─ imem.v               # Instruction Memory (L1i cache)
│   │   ├─ pc.v                 # Program Counter
│   │   ├─ pd.v                 # Instruction Pre-Decoder
│   │   └─ regfile.v            # Register File
│   ├─ config.v         # Configuration include file
│   └─ rv6.v            # Top-level CPU module
├─ simulation/      # ModelSim project files
├─ synthesis/       # Vivado & Quartus II project files
├─ test/            # Testbench source files
│   ├─ c/               # C source files for verification purposes
│   │  ├─ default/          # Template verification program
│   │  └─ fib/              # Fibonacci sequence calculator
│   ├─ tb_hart.sv       # Hart verification template
│   └─ tb_hart_fib.sv   # Fibonacci sequence calculator testbench
├─ LICENSE
├─ Makefile
└─ README.md
```

## License
The hardware is licensed under the [CERN Open Hardware Licence Version 2 - Strongly Reciprocal](https://ohwr.org/cern_ohl_s_v2.txt).
