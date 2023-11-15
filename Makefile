VC = iverilog
VS = vvp

TOPMODULE = rv64g

DIR_SYN   = hdl
DIR_SIM   = test
DIR_BUILD = build
DIR_VCD	  = vcd

SOURCES_SYN = $(shell find ${DIR_SYN} -name "*.v" -printf "%P ")
SOURCES_SIM = $(shell find ${DIR_SIM} -name "*.sv" -printf "%P ")

OBJECTS		= $(addprefix ${DIR_BUILD}/,${SOURCES_SIM:.sv=.o})
SIMULATIONS = $(addprefix ${DIR_VCD}/,${SOURCES_SIM:.sv=.vcd})

VCFLAGS     = -g2012 -Dvcicarus

all: ${OBJECTS} ${SIMULATIONS}

${DIR_BUILD}/%.o: ${DIR_SIM}/%.sv ${DIR_SYN} | ${DIR_BUILD} program
	${VC} ${VCFLAGS} -o ${@} ${<} $(addprefix ${DIR_SYN}/,${SOURCES_SYN})

${DIR_VCD}/%.vcd: ${DIR_BUILD}/%.o | ${DIR_VCD}
	${VS} ${<}

${DIR_BUILD}:
	@mkdir -p ${DIR_BUILD}

${DIR_VCD}:
	@mkdir -p ${DIR_VCD}

program:
	cd test/program/ && make all

clean:
	rm -rf ${DIR_BUILD}
	cd test/program/ && make clean
