DIR_WORK 	= work

DIR_RTL	 	= rtl
DIR_TB	 	= tb

DIR_TRACE	= trace
DIR_DROMAJO = dromajo

OPTS_RTL = -incr
OPTS_TB  = -incr -sv +define+ANSI_COLORS +define+DROMAJO_VERBOSE

SOURCES_RTL = $(shell find ../${DIR_RTL} -name "*.v"  -printf "%p ")
SOURCES_TB  = $(shell find ../${DIR_TB}  -name "*.sv" -printf "%p ")

.PHONY: rtl tb tb_% vsim_tb_% vsim_tb_%_c clean

${DIR_WORK}:
	vlib ${DIR_WORK}

rtl: | ${DIR_WORK}
	vlog ${OPTS_RTL} ${SOURCES_RTL}

tb:	 | ${DIR_WORK}
	vlog ${OPTS_TB} ${SOURCES_TB}

tb_%: rtl
	mkdir -p trace/
	vlog ${OPTS_TB} $(shell find ../${DIR_TB} -name "${@}.sv" -printf "%p ")

vsim_tb_%: tb_% | tb ${DIR_TRACE} ${DIR_DROMAJO}
	vsim ${<} -do 'core.do' -do 'run -all; view wave;'

vsim_tb_%_c: tb_% | tb ${DIR_TRACE} ${DIR_DROMAJO}
	vsim -c ${<} -do 'run -all; quit -f;'

clean:
	rm -rf ${DIR_WORK}
	rm -rf ${DIR_TRACE}
	rm -rf ${DIR_DROMAJO}
	rm -f transcript