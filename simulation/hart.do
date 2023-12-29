onerror {resume}
quietly virtual signal -install /tb_hart/dut/u_dmem { /tb_hart/dut/u_dmem/addr[63:4]} aaddr_start
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_hart/h_addr
add wave -noupdate -radix hexadecimal /tb_hart/h_data_in
add wave -noupdate -radix hexadecimal /tb_hart/h_rd
add wave -noupdate -radix hexadecimal /tb_hart/h_dv
add wave -noupdate -radix hexadecimal /tb_hart/h_data_out
add wave -noupdate -radix hexadecimal /tb_hart/h_wr
add wave -noupdate -radix hexadecimal /tb_hart/h_inv_addr
add wave -noupdate -radix hexadecimal /tb_hart/h_inv
add wave -noupdate -radix hexadecimal /tb_hart/h_amo_req
add wave -noupdate -radix hexadecimal /tb_hart/h_amo_ack
add wave -noupdate -radix hexadecimal /tb_hart/h_rst_n
add wave -noupdate -radix hexadecimal /tb_hart/h_clk
add wave -noupdate -radix hexadecimal /tb_hart/dut/pc
add wave -noupdate -radix hexadecimal /tb_hart/dut/ir
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/ir
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_in
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_out
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_addr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_wr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_pr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/trap_addr
add wave -noupdate -group csr /tb_hart/dut/u_csr/trap_taken
add wave -noupdate -group csr /tb_hart/dut/u_csr/intr_s
add wave -noupdate -group csr /tb_hart/dut/u_csr/intr_t
add wave -noupdate -group csr /tb_hart/dut/u_csr/intr_e
add wave -noupdate -group csr /tb_hart/dut/u_csr/dmem_ld_ma
add wave -noupdate -group csr /tb_hart/dut/u_csr/dmem_st_ma
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_addr
add wave -noupdate -group csr -group reg -label mstatus/sstatus -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[0]}
add wave -noupdate -group csr -group reg -label mie/sie -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[1]}
add wave -noupdate -group csr -group reg -label stvec -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[2]}
add wave -noupdate -group csr -group reg -label scounteren -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[3]}
add wave -noupdate -group csr -group reg -label sscratch -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[4]}
add wave -noupdate -group csr -group reg -label sepc -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[5]}
add wave -noupdate -group csr -group reg -label scause -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[6]}
add wave -noupdate -group csr -group reg -label stval -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[7]}
add wave -noupdate -group csr -group reg -label mip/sip -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[8]}
add wave -noupdate -group csr -group reg -label satp -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[9]}
add wave -noupdate -group csr -group reg -label mvendorid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[10]}
add wave -noupdate -group csr -group reg -label marchid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[11]}
add wave -noupdate -group csr -group reg -label mimpid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[12]}
add wave -noupdate -group csr -group reg -label mhartid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[13]}
add wave -noupdate -group csr -group reg -label mconfigptr -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[14]}
add wave -noupdate -group csr -group reg -label misa -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[15]}
add wave -noupdate -group csr -group reg -label medeleg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[16]}
add wave -noupdate -group csr -group reg -label mideleg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[17]}
add wave -noupdate -group csr -group reg -label mtvec -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[18]}
add wave -noupdate -group csr -group reg -label mcounteren -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[19]}
add wave -noupdate -group csr -group reg -label mscratch -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[20]}
add wave -noupdate -group csr -group reg -label mepc -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[21]}
add wave -noupdate -group csr -group reg -label mcause -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[22]}
add wave -noupdate -group csr -group reg -label mtval -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[23]}
add wave -noupdate -group csr -group reg -label minst -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[24]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[25]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[26]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[27]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[28]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[29]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[30]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[31]}
add wave -noupdate -group csr -group reg -label mstatus/sstatus -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[0]}
add wave -noupdate -group csr -group reg -label mie/sie -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[1]}
add wave -noupdate -group csr -group reg -label stvec -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[2]}
add wave -noupdate -group csr -group reg -label scounteren -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[3]}
add wave -noupdate -group csr -group reg -label sscratch -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[4]}
add wave -noupdate -group csr -group reg -label sepc -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[5]}
add wave -noupdate -group csr -group reg -label scause -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[6]}
add wave -noupdate -group csr -group reg -label stval -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[7]}
add wave -noupdate -group csr -group reg -label mip/sip -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[8]}
add wave -noupdate -group csr -group reg -label satp -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[9]}
add wave -noupdate -group csr -group reg -label mvendorid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[10]}
add wave -noupdate -group csr -group reg -label marchid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[11]}
add wave -noupdate -group csr -group reg -label mimpid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[12]}
add wave -noupdate -group csr -group reg -label mhartid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[13]}
add wave -noupdate -group csr -group reg -label mconfigptr -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[14]}
add wave -noupdate -group csr -group reg -label misa -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[15]}
add wave -noupdate -group csr -group reg -label medeleg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[16]}
add wave -noupdate -group csr -group reg -label mideleg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[17]}
add wave -noupdate -group csr -group reg -label mtvec -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[18]}
add wave -noupdate -group csr -group reg -label mcounteren -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[19]}
add wave -noupdate -group csr -group reg -label mscratch -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[20]}
add wave -noupdate -group csr -group reg -label mepc -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[21]}
add wave -noupdate -group csr -group reg -label mcause -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[22]}
add wave -noupdate -group csr -group reg -label mtval -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[23]}
add wave -noupdate -group csr -group reg -label minst -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[24]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[25]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[26]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[27]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[28]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[29]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[30]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[31]}
add wave -noupdate -group csr -group reg -label mstatus/sstatus -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[0]}
add wave -noupdate -group csr -group reg -label mie/sie -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[1]}
add wave -noupdate -group csr -group reg -label stvec -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[2]}
add wave -noupdate -group csr -group reg -label scounteren -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[3]}
add wave -noupdate -group csr -group reg -label sscratch -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[4]}
add wave -noupdate -group csr -group reg -label sepc -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[5]}
add wave -noupdate -group csr -group reg -label scause -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[6]}
add wave -noupdate -group csr -group reg -label stval -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[7]}
add wave -noupdate -group csr -group reg -label mip/sip -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[8]}
add wave -noupdate -group csr -group reg -label satp -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[9]}
add wave -noupdate -group csr -group reg -label mvendorid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[10]}
add wave -noupdate -group csr -group reg -label marchid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[11]}
add wave -noupdate -group csr -group reg -label mimpid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[12]}
add wave -noupdate -group csr -group reg -label mhartid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[13]}
add wave -noupdate -group csr -group reg -label mconfigptr -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[14]}
add wave -noupdate -group csr -group reg -label misa -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[15]}
add wave -noupdate -group csr -group reg -label medeleg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[16]}
add wave -noupdate -group csr -group reg -label mideleg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[17]}
add wave -noupdate -group csr -group reg -label mtvec -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[18]}
add wave -noupdate -group csr -group reg -label mcounteren -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[19]}
add wave -noupdate -group csr -group reg -label mscratch -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[20]}
add wave -noupdate -group csr -group reg -label mepc -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[21]}
add wave -noupdate -group csr -group reg -label mcause -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[22]}
add wave -noupdate -group csr -group reg -label mtval -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[23]}
add wave -noupdate -group csr -group reg -label minst -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[24]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[25]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[26]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[27]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[28]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[29]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[30]}
add wave -noupdate -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[31]}
add wave -noupdate -group csr -radix binary /tb_hart/dut/u_csr/privilege_level
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rw
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rwi
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rs
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rsi
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rc
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rci
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/rd
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/wr
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/rd_valid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/wr_valid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/wpri
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/ncsr
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/ir
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_in
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_out
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_addr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_wr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_pr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/trap_addr
add wave -noupdate -group csr /tb_hart/dut/u_csr/trap_taken
add wave -noupdate -group csr /tb_hart/dut/u_csr/intr_s
add wave -noupdate -group csr /tb_hart/dut/u_csr/intr_t
add wave -noupdate -group csr /tb_hart/dut/u_csr/intr_e
add wave -noupdate -group csr /tb_hart/dut/u_csr/dmem_ld_ma
add wave -noupdate -group csr /tb_hart/dut/u_csr/dmem_st_ma
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_addr
add wave -noupdate -group csr -radix binary /tb_hart/dut/u_csr/privilege_level
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rw
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rwi
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rs
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rsi
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rc
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rci
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/rd
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/wr
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/rd_valid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/wr_valid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/wpri
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/ncsr
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/ir
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_in
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_out
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_addr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_wr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_pr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/trap_addr
add wave -noupdate -group csr /tb_hart/dut/u_csr/trap_taken
add wave -noupdate -group csr /tb_hart/dut/u_csr/intr_s
add wave -noupdate -group csr /tb_hart/dut/u_csr/intr_t
add wave -noupdate -group csr /tb_hart/dut/u_csr/intr_e
add wave -noupdate -group csr /tb_hart/dut/u_csr/dmem_ld_ma
add wave -noupdate -group csr /tb_hart/dut/u_csr/dmem_st_ma
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_addr
add wave -noupdate -group csr -radix binary /tb_hart/dut/u_csr/privilege_level
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rw
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rwi
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rs
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rsi
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rc
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rci
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/rd
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/wr
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/rd_valid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/wr_valid
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/wpri
add wave -noupdate -group csr -radix hexadecimal /tb_hart/dut/u_csr/ncsr
add wave -noupdate -group alu -radix hexadecimal /tb_hart/dut/u_alu/a
add wave -noupdate -group alu -radix hexadecimal /tb_hart/dut/u_alu/b
add wave -noupdate -group alu -radix hexadecimal /tb_hart/dut/alu_out
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/ir_id
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/ir_ex
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/ir_mem
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/ir_wb
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/stall_if
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/stall_pd
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/stall_id
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/stall_ex
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/stall_mem
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/stall_wb
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/amo_req
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/amo_ack
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/b_rd_i
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/b_rd_d
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/s_mx_a_fw
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/a_fw
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/s_mx_b_fw
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/b_fw
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/rst_n
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/clk
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/stall_all
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/rs1_pc
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/rs2_imm
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/rs1
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/rs2
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/rd_ex
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/rd_mem
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/rd_wb
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/wr_ex
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/wr_mem
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/wr_wb
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/dh_ex
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/dh_mem
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/dh_wb
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/a_fw_ex
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/a_fw_mem
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/a_fw_wb
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/b_fw_ex
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/b_fw_mem
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/b_fw_wb
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/fw
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/stall_c
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/stall_d
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/dh
add wave -noupdate -group stall /tb_hart/dut/stall_if
add wave -noupdate -group stall /tb_hart/dut/stall_pd
add wave -noupdate -group stall /tb_hart/dut/stall_id
add wave -noupdate -group stall /tb_hart/dut/stall_ex
add wave -noupdate -group stall /tb_hart/dut/stall_mem
add wave -noupdate -group stall /tb_hart/dut/stall_wb
add wave -noupdate -group ir -radix hexadecimal /tb_hart/dut/ir
add wave -noupdate -group ir -radix hexadecimal /tb_hart/dut/bfp_ir
add wave -noupdate -group ir -radix hexadecimal /tb_hart/dut/bpd_ir
add wave -noupdate -group ir -radix hexadecimal /tb_hart/dut/bdx_ir
add wave -noupdate -group ir -radix hexadecimal /tb_hart/dut/bxm_ir
add wave -noupdate -group ir -radix hexadecimal /tb_hart/dut/bmw_ir
add wave -noupdate -group reg -radix hexadecimal -childformat {{{/tb_hart/dut/u_regfile/register[1]} -radix hexadecimal} {{/tb_hart/dut/u_regfile/register[2]} -radix hexadecimal} {{/tb_hart/dut/u_regfile/register[3]} -radix decimal} {{/tb_hart/dut/u_regfile/register[4]} -radix decimal} {{/tb_hart/dut/u_regfile/register[5]} -radix decimal} {{/tb_hart/dut/u_regfile/register[6]} -radix decimal} {{/tb_hart/dut/u_regfile/register[7]} -radix decimal} {{/tb_hart/dut/u_regfile/register[8]} -radix decimal} {{/tb_hart/dut/u_regfile/register[9]} -radix decimal} {{/tb_hart/dut/u_regfile/register[10]} -radix decimal} {{/tb_hart/dut/u_regfile/register[11]} -radix decimal} {{/tb_hart/dut/u_regfile/register[12]} -radix decimal} {{/tb_hart/dut/u_regfile/register[13]} -radix decimal} {{/tb_hart/dut/u_regfile/register[14]} -radix decimal} {{/tb_hart/dut/u_regfile/register[15]} -radix decimal} {{/tb_hart/dut/u_regfile/register[16]} -radix decimal} {{/tb_hart/dut/u_regfile/register[17]} -radix decimal} {{/tb_hart/dut/u_regfile/register[18]} -radix decimal} {{/tb_hart/dut/u_regfile/register[19]} -radix decimal} {{/tb_hart/dut/u_regfile/register[20]} -radix decimal} {{/tb_hart/dut/u_regfile/register[21]} -radix decimal} {{/tb_hart/dut/u_regfile/register[22]} -radix decimal} {{/tb_hart/dut/u_regfile/register[23]} -radix decimal} {{/tb_hart/dut/u_regfile/register[24]} -radix decimal} {{/tb_hart/dut/u_regfile/register[25]} -radix decimal} {{/tb_hart/dut/u_regfile/register[26]} -radix decimal} {{/tb_hart/dut/u_regfile/register[27]} -radix decimal} {{/tb_hart/dut/u_regfile/register[28]} -radix decimal} {{/tb_hart/dut/u_regfile/register[29]} -radix decimal} {{/tb_hart/dut/u_regfile/register[30]} -radix decimal} {{/tb_hart/dut/u_regfile/register[31]} -radix decimal}} -subitemconfig {{/tb_hart/dut/u_regfile/register[1]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_regfile/register[2]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_regfile/register[3]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[4]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[5]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[6]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[7]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[8]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[9]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[10]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[11]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[12]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[13]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[14]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[15]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[16]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[17]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[18]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[19]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[20]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[21]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[22]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[23]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[24]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[25]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[26]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[27]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[28]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[29]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[30]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[31]} {-height 16 -radix decimal}} /tb_hart/dut/u_regfile/register
add wave -noupdate -group reg -radix hexadecimal /tb_hart/dut/rs1
add wave -noupdate -group reg -radix hexadecimal /tb_hart/dut/rs2
add wave -noupdate -group reg -radix hexadecimal /tb_hart/dut/rd
add wave -noupdate -group reg -radix hexadecimal /tb_hart/dut/r1
add wave -noupdate -group reg -radix hexadecimal /tb_hart/dut/r2
add wave -noupdate -group reg -radix hexadecimal /tb_hart/dut/d
add wave -noupdate -group reg -radix hexadecimal /tb_hart/dut/wr
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/pc
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/trap_addr
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/jalr_taken
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/jalr_addr
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/pr_miss
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/br_addr
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/jal_taken
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/jal_addr
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/pr_taken
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/pr_offs
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/c_ins
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/pc
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ir
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/b_addr_i
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/b_data_i
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/b_rd_i
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/b_dv_i
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/stall
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/stall_imem
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/rst_n
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/clk
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr_tag
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr_set
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr_offs
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/data
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/tag
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/v
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/re
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/hit
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ma
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/cache_line_out
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/l_tag
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/l_set
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/l_data
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/l_hit
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr_2
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr_2_tag
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr_2_set
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ma_tag
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ma_set
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ma_data
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ma_hit
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/set_q
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/way_q
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/rde
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/set_d
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/way_d
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/wre
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/imem_fsm
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/imem_fsm_next
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ld_cnt
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ma_d
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ma_re
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/lru_tree
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/len
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/data_out
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/rd
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/data_in
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/wr
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/ld_ma
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/st_ma
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_addr_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_data_in_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_rd_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_dv_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_data_out_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_wr_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv_addr
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/stall_dmem
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/rst_n
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/clk
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/dmem_op
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr_set
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr_offs
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/data
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/v
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/re
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/hit_q
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/cache_line_out
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/cache_line_in
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/r_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/r_set
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/r_data
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/r_hit_q
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/set_q
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/way_q
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/rde
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/w_len
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/w_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/w_set
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/w_way
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/w_offs
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/w_data
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/wr_pend
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/set_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/way_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/wre
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/cache_line_in_w
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/dmem_fsm
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/dmem_fsm_next
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/ld_cnt
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/data_mux
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv_set
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr_2
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/lru_tree
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/lru_update
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/re_update
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/b_addr_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/b_data_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/b_rd_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/b_dv_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/b_addr_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/b_data_in_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/b_rd_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/b_dv_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/b_data_out_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/b_wr_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/h_addr
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/h_data_in
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/h_rd
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/h_dv
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/h_data_out
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/h_wr
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/inv_addr
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/inv
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/stall_hmem
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/rst_n
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/clk
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_tag_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_set_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_offs_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_tag_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_set_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_offs_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/data
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/tag
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/v
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/re
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/hit_qi
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/hit_qd
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/cache_line_in
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/cache_line_out_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/cache_line_out_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/imem_op
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/dmem_op
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/op
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/ri_tag
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/ri_set
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/ri_data
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/ri_hit
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/rd_tag
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/rd_set
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/rd_data
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/rd_hit
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/f_tag
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/set_qi
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/way_qi
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/rde_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/set_qd
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/way_qd
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/rde_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/w_tag
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/w_set
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/w_way
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/w_offs
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/w_data
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/wr_pend
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/set_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/way_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/wre
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/cache_line_in_w
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/h_dv_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/hmem_fsm
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/hmem_fsm_next
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/ld_cnt
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/inv_tag
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/inv_set
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/lru_tree
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/lru_update
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/re_update
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3920000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 281
configure wave -valuecolwidth 144
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {8995570 ps}
