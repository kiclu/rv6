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

V_FLAGS		= -g2001 -Wall -tnull
SV_FLAGS    = -g2012 -DDEBUG

# Generate program hex files for testbench inputs
DIR_C = test/c

HEX_MAKEFILES = $(addprefix ${DIR_C}/,$(shell find ${DIR_C} -name "Makefile" -printf "%P "))
HEX_TARGETS   = $(join $(dir ${HEX_MAKEFILES}),$(notdir ${HEX_MAKEFILES:/Makefile=.hex}))
HEX_DIRS      = $(dir ${HEX_MAKEFILES})

hex_all: ${HEX_TARGETS}
	@echo "Makefile: Compiling hex targets finished successfully\n"

%.hex:
	@echo "Makefile: Compiling ${@}"
	@cd $(dir ${@}) && make all
	@echo "Makefile: Compiled ${@} successfully\n"

# Generate testbenches and run them
all: ${SOURCES_SYN} ${VVP} ${VCD}

${DIR_VVP}/%.vvp: %.sv | ${DIR_VVP} hex_all syncheck
	@echo "Makefile: Compiling testbench ${<}"
	@mkdir -p $(dir ${@})
	${VC} ${SV_FLAGS} -o ${@} ${<} ${SOURCES_SYN}
	@echo "Makefile: Compiled ${@} successfully\n"

${DIR_VVP}:
	@mkdir -p ${DIR_VVP}

${DIR_VCD}/%.vcd: ${DIR_VVP}/%.vvp | ${DIR_VCD}
	@echo "Makefile: Simulating testbench ${<}"
	@mkdir -p $(dir ${@})
	${VS} ${<}
	@echo "Makefile: Testbench ${<} simulation finished\n"

${DIR_VCD}:
	@mkdir -p ${DIR_VCD}
	@mkdir -p test/out/

# Compile all synthesis source files with verbose flag
syncheck: ${SOURCES_SYN}
	@echo "Makefile: Compiling synthesis modules"
	${VC} ${V_FLAGS} ${^}
	@echo "Makefile: Compiled sysntesis modules successfully\n"

# Recursive clean
CLEAN_C = $(addsuffix clean,${HEX_DIRS})

%clean: %
	@echo "Makefile: clean: ${<}"
	@cd ${<} && make clean
	@echo ""

# Clean all
clean: ${CLEAN_C}
	@echo "Makefile: clean"
	rm -rf ${DIR_VVP} ${DIR_VCD}
	@echo ""
