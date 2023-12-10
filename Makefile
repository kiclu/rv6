# Simulation / Synthesis source files & targets
DIR_SYN   = hdl
DIR_SIM   = test

DIR_VCD	  = vcd
DIR_VVP	  = vvp

SOURCES_SYN = $(addprefix ${DIR_SYN}/,$(shell find ${DIR_SYN} -name "*.v" -printf "%P "))
SOURCES_SIM = $(addprefix ${DIR_SIM}/,$(shell find ${DIR_SIM} -name "*.sv" -printf "%P "))

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

all: hex syn_all sim_all sim_hart

# Compile all source files
syn_all: ${SOURCES_SYN}
	@echo "Makefile: Compiling synthesis modules"
	cd simulation/ && vsim -c tb_hart -do 'quit -sim; project open rv6; project compileall; quit -f;'
	@echo "Makefile: Compiled sysntesis modules successfully\n"

# Run testbench simulation
%_sim: test/%.sv
	@echo "vsim: Running testbench ${<} simulation"
	cd simulation/ && vsim -c $(basename $(notdir ${<})) -do 'run -all; quit -f;'
	@echo "vsim: Testbench ${<} simulation finished successfully\n"

SIM_MODULES = $(addsuffix _sim,$(basename $(shell find ${DIR_SIM} -name "*.sv" -printf "%P ")))

sim_all: ${SIM_MODULES}
	@echo "vsim: Testbench simulations finished successfully\n"

sim_hart:
	@cd test/auto/ && ./run_hart_tests

# Recursive clean
CLEAN_C = $(addsuffix _clean,${HEX_DIRS})

%_clean: %
	@echo "Makefile: clean: ${<}"
	@cd ${<} && make clean
	@echo ""

# Clean all
clean: ${CLEAN_C}
