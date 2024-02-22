# Simulation

.PHONY: rtl vsim_tb_% vsim_tb_%_c

rtl:
	@${MAKE} -C sim ${@}

vsim_tb_%:
	@${MAKE} -C sim ${@} ELF=${ELF}

vsim_tb_%_c:
	@${MAKE} -C sim ${@} ELF=${ELF}

# Clean

.PHONY: clean

clean:
	@${MAKE} -C sim clean
