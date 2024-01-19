# Simulation / Synthesis source files & targets
DIR_SYN   = hdl
DIR_SIM   = test

DIR_VCD	  = vcd
DIR_VVP	  = vvp

SOURCES_SYN = $(addprefix ${DIR_SYN}/,$(shell find ${DIR_SYN} -name "*.v" -printf "%P "))
SOURCES_SIM = $(addprefix ${DIR_SIM}/,$(shell find ${DIR_SIM} -name "*.sv" -printf "%P "))

#all: unit_test unit_test_report

# Compile all source files
syn_all: ${SOURCES_SYN}
	@echo "Makefile: Compiling synthesis modules"
	@cd simulation/ && vsim -c tb_core -do 'quit -sim; project open rv6; project compileall; quit -f;'
	@echo "Makefile: Compiled sysntesis modules successfully\n"

core_unit_test: | ${SOURCES_SYN} ${SOURCES_SIM}
	# compile
	@cd simulation/ && vsim -c tb_core -do 'quit -sim; project open rv6; project compileall; vlog -work work ../test/tb_core.sv +define+ANSI_COLORS +define+DROMAJO_VERBOSE; quit -f;'
	# run simulation
	@cd simulation/ && vsim -c tb_core -do 'run -all; quit -f;'

core_unit_test_report: syn_all | ${SOURCES_SYN} ${SOURCES_SIM}
	@echo Writing report file
	@cd simulation/ && vsim -c tb_core -do 'run -all; quit -f' > unit_test_report
	@echo Report file written successfully

clean:
	rm -rf simulation/trace/*.trace
	rm -rf simulation/dromajo/*.dromajo.log
