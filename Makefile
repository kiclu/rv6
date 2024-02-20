# Simulation

.PHONY: vsim_tb_% vsim_tb_%_c

vsim_tb_%:
	${MAKE} -C sim ${@} ELF=${ELF}

vsim_tb_%_c:
	${MAKE} -C sim ${@} ELF=${ELF}

# Clean

.PHONY: clean

clean:
	${MAKE} -C sim clean
