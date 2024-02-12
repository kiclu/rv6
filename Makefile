# Simulation / Synthesis source files & targets
DIR_SYN   = hdl
DIR_SIM   = test

PWD = $(shell pwd)

SOURCES_SYN = $(addprefix ${PWD}/${DIR_SYN}/,$(shell find ${DIR_SYN} -name "*.v" -printf "%P "))
SOURCES_SIM = $(addprefix ${PWD}/${DIR_SIM}/,$(shell find ${DIR_SIM} -name "*.sv" -printf "%P "))

VLOG_FLAGS_SYN 			= -incr
VLOG_FLAGS_SIM 			= -sv -incr +define+ANSI_COLORS +define+DROMAJO_VERBOSE
VLOG_FLAGS_SIM_REPORT 	= -sv -incr

# Compile all source files
compile_syn: ${SOURCES_SYN}
	@echo "Makefile: Compiling synthesis modules"
	@cd simulation/ && vlog ${VLOG_FLAGS_SYN} ${SOURCES_SYN}
	@echo "Makefile: Compiled synthesis modules successfully\n"

compile_sim: ${SOURCES_SYN} ${SOURCES_SIM}
	@echo "Makefile: Compiling simulation modules"
	@cd simulation/ && vlog ${VLOG_FLAGS_SIM} ${SOURCES_SIM}
	@echo "Makefile: Compiled simulation modules successfully\n"

compile_sim_report:
	@cd simulation/ && vlog ${VLOG_FLAGS_SIM_REPORT} ${SOURCES_SIM}

core_unit_test: compile_syn compile_sim
	@mkdir -p simulation/dromajo/
	@mkdir -p simulation/trace/
	@cd simulation/ && vsim -c tb_core -do 'run -all; quit -f;'

core_unit_test_report: compile_syn compile_sim_report
	@echo Writing report file
	@mkdir -p simulation/dromajo/
	@mkdir -p simulation/trace/
	@mkdir -p simulation/reports/
	@cd simulation/ && vsim -c tb_core -do 'run -all; quit -f' > core_unit_test_report
	@echo Report file written successfully

clean:
	rm -rf simulation/trace/*.trace
	rm -rf simulation/dromajo/*.dromajo.log
