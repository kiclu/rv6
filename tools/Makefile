all: riscv-tests/target dromajo/build

riscv-tests/target:
	@cd riscv-tests/ && git submodule update --init --recursive
	@cd riscv-tests/ && autoconf && ./configure --prefix=${PWD}/riscv-tests/target && make && make install

dromajo/build:
	@cd dromajo/ && mkdir build/ && cd build/ && cmake -DCMAKE_BUILD_TYPE=Release .. && make
