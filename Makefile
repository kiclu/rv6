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
HEX_SOURCES_C = $(shell find ${DIR_C} -name "*.c")
HEX_SOURCES_S = $(shell find ${DIR_C} -name "*.S")

hex: ${HEX_TARGETS} ${HEX_SOURCES_C} ${HEX_SOURCES_S}
	@echo "Makefile: Compiling hex targets finished successfully\n"

%.hex: ${HEX_SOURCES_C} ${HEX_SOURCES_S}
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

sim_all: ${SIM_MODULES} | hex
	@echo "vsim: Testbench simulations finished successfully\n"

sim_hart: | hex
	@cd test/auto/ && ./auto

cov_%: test/%.sv
	@echo "vsim: Running coverage simulation for ${<}"
	@cd simulation/ &&\
	vsim -c rv6 -do 'quit -sim; vlog -coveropt 3 +cover +acc $(addprefix ../,${SOURCES_SYN}); vsim -coverage -vopt work.$(basename $(notdir $<)) -c -do "coverage same -onexit -directive -codeAll cov_$(basename $(notdir $<)).ucdb; run -all"; vcover report -html cov_$(basename $(notdir $<)).ucdb; quit -f'
	@echo "vsim: Coverage simulation for ${<} successfully completed\n"

# Recursive clean
CLEAN_C = $(addsuffix _clean,${HEX_DIRS})

%_clean: %
	@echo "Makefile: clean: ${<}"
	@cd ${<} && make clean
	@echo ""

# Clean all
clean: ${CLEAN_C}
