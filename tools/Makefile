ifndef ROOT_DIR
	ROOT_DIR = ${PWD}/..
endif

.PHONY: all

all: riscv-tests/target dromajo/build

riscv-tests/target:
	@cd riscv-tests/ && git submodule update --init --recursive
	@cd riscv-tests/ && autoconf && ./configure --prefix=${ROOT_DIR}/tools/riscv-tests/target && make && make install

dromajo/build:
	@cd ${ROOT_DIR}/tools/dromajo/ && mkdir build/ && cd build/ && cmake -DCMAKE_BUILD_TYPE=Release .. && make

.PHONY: clean clean_riscv_tests clean_dromajo

clean: clean_riscv_tests clean_dromajo

clean_riscv_tests:
	@rm -rf riscv-tests/target

clean_dromajo:
	@rm -rf dromajo/build
