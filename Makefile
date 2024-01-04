# Simulation / Synthesis source files & targets
DIR_SYN   = hdl
DIR_SIM   = test

DIR_VCD	  = vcd
DIR_VVP	  = vvp

SOURCES_SYN = $(addprefix ${DIR_SYN}/,$(shell find ${DIR_SYN} -name "*.v" -printf "%P "))
SOURCES_SIM = $(addprefix ${DIR_SIM}/,$(shell find ${DIR_SIM} -name "*.sv" -printf "%P "))

all: syn_all ut

# Compile all source files
syn_all: ${SOURCES_SYN}
	@echo "Makefile: Compiling synthesis modules"
	@cd simulation/ && vsim -c tb_hart -do 'quit -sim; project open rv6; project compileall; quit -f;'
	@echo "Makefile: Compiled sysntesis modules successfully\n"

ut: | ${SOURCES_SYN} ${SOURCES_SIM}
	@cd simulation/ && vsim -c tb_hart -do 'run -all; quit -f;'

clean:
	rm -rf simulation/*.trace
	rm -rf simulation/*.dromajo.log
