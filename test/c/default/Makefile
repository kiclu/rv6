DIR_SRC 	= src
DIR_INCLUDE = include
DIR_BUILD 	= build

TARGET_ELF  = default.elf
TARGET_ASM  = default.asm
TARGET_HEX  = default.hex

TOOLPREFIX = riscv64-unknown-elf-

CC 		= ${TOOLPREFIX}gcc
CXX 	= ${TOOLPREFIX}g++
AS 		= ${TOOLPREFIX}as
LD 		= ${TOOLPREFIX}ld
OBJCOPY = ${TOOLPREFIX}objcopy
OBJDUMP = ${TOOLPREFIX}objdump

LDSCRIPT = ldscript.ld

ASFLAGS = -march=rv64i -mabi=lp64
CFLAGS  = -march=rv64i -mabi=lp64 -mcmodel=medany -MMD -MP -MF"${@:%.o=%.d}"

SOURCES_S = $(shell find . -name "*.S" -printf "%P ")
OBJECTS += $(addprefix ${DIR_BUILD}/,${SOURCES_S:.S=.o})
SOURCES_C = $(shell find . -name "*.c" -printf "%P ")
OBJECTS += $(addprefix ${DIR_BUILD}/,${SOURCES_C:.c=.o})

all: ${TARGET_ELF} ${TARGET_ASM} ${TARGET_HEX}

${TARGET_ELF}: ${OBJECTS} | ${LDSCRIPT}
	${LD} ${LDFLAGS} -T ${LDSCRIPT} -o ${@} ${OBJECTS}

${TARGET_ASM}: ${TARGET_ELF}
	${OBJDUMP} -D ${<} > ${@}

${TARGET_HEX}: ${TARGET_ELF}
	${OBJCOPY} -O verilog ${<} ${@}

${DIR_BUILD}/%.o: %.S Makefile | ${DIR_BUILD}
	@mkdir -p $(dir ${@})
	${AS} -c ${ASFLAGS} -o ${@} ${<}

${DIR_BUILD}/%.o: %.c Makefile | ${DIR_BUILD}
	@mkdir -p $(dir ${@})
	${CC} -c ${CFLAGS} -o ${@} ${<}

${DIR_BUILD}:
	@mkdir ${@}

clean:
	rm -rf ${DIR_BUILD}
	rm -f ${TARGET_ELF} ${TARGET_ASM} ${TARGET_HEX}

-include $(wildcard ${DIR_BUILD}/*.d)
