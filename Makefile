export RISCV_TESTS		  = ${PWD}/tools/riscv-tests/target/share/riscv-tests/isa/
export DROMAJO 		   	  = ${PWD}/tools/dromajo/build/dromajo
export DROMAJO_COSIM_TEST = ${PWD}/tools/dromajo/build/dromajo_cosim_test

# Simulation

.PHONY: rtl vsim_tb_% vsim_tb_%_c

rtl:
	@${MAKE} -C sim ${@}

vsim_tb_%:
	@${MAKE} -C sim ${@}

vsim_tb_%_c:
	@${MAKE} -C sim ${@}

# Tools

.PHONY: tools

tools:
	@${MAKE} -C tools all

# Clean

.PHONY: clean

clean:
	@${MAKE} -C sim clean
