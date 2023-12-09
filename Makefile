# Simulation / Synthesis source files & targets
VC = iverilog
VS = vvp

DIR_SYN   = hdl
DIR_SIM   = test

DIR_VCD	  = vcd
DIR_VVP	  = vvp

SOURCES_SYN = $(addprefix ${DIR_SYN}/,$(shell find ${DIR_SYN} -name "*.v" -printf "%P "))
SOURCES_SIM = $(addprefix ${DIR_SIM}/,$(shell find ${DIR_SIM} -name "*.sv" -printf "%P "))

VVP	  = $(addprefix ${DIR_VVP}/,${SOURCES_SIM:.sv=.vvp})
VCD   = $(addprefix ${DIR_VCD}/,${SOURCES_SIM:.sv=.vcd})

V_FLAGS		= -g2001 -Wall -tnull -Ihdl/hart/
SV_FLAGS    = -g2012 -DDEBUG -Ihdl/hart/

# Generate program hex files for testbench inputs
DIR_C = test/c

HEX_MAKEFILES = $(addprefix ${DIR_C}/,$(shell find ${DIR_C} -name "Makefile" -printf "%P "))
HEX_TARGETS   = $(join $(dir ${HEX_MAKEFILES}),$(notdir ${HEX_MAKEFILES:/Makefile=.hex}))
HEX_DIRS      = $(dir ${HEX_MAKEFILES})

hex: ${HEX_TARGETS}
	@echo "Makefile: Compiling hex targets finished successfully\n"

%.hex:
	@echo "Makefile: Compiling ${@}"
	@cd $(dir ${@}) && make all
	@echo "Makefile: Compiled ${@} successfully\n"

all: hex syn_all sim_all

# Run testbench simulation
sim_all:
	@echo "vsim: Running testbench simulation"
	cd simulation/ && vsim -c tb_hart -do 'run -all; quit -f;'
	@echo "vsim: Testbench simulation finished successfully\n"

# Compile all source files
syn_all: ${SOURCES_SYN}
	@echo "Makefile: Compiling synthesis modules"
	cd simulation/ && vsim -c tb_hart -do 'quit -sim; project open rv6; project compileall; quit -f;'
	@echo "Makefile: Compiled sysntesis modules successfully\n"

# Recursive clean
CLEAN_C = $(addsuffix clean,${HEX_DIRS})

%clean: %
	@echo "Makefile: clean: ${<}"
	@cd ${<} && make clean
	@echo ""

# Clean all
clean: ${CLEAN_C}
