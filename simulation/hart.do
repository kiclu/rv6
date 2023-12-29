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
add wave -noupdate -group reg -radix hexadecimal -childformat {{{/tb_hart/dut/u_regfile/register[1]} -radix hexadecimal} {{/tb_hart/dut/u_regfile/register[2]} -radix hexadecimal} {{/tb_hart/dut/u_regfile/register[3]} -radix decimal} {{/tb_hart/dut/u_regfile/register[4]} -radix decimal} {{/tb_hart/dut/u_regfile/register[5]} -radix decimal} {{/tb_hart/dut/u_regfile/register[6]} -radix decimal} {{/tb_hart/dut/u_regfile/register[7]} -radix decimal} {{/tb_hart/dut/u_regfile/register[8]} -radix decimal} {{/tb_hart/dut/u_regfile/register[9]} -radix decimal} {{/tb_hart/dut/u_regfile/register[10]} -radix decimal} {{/tb_hart/dut/u_regfile/register[11]} -radix decimal} {{/tb_hart/dut/u_regfile/register[12]} -radix decimal} {{/tb_hart/dut/u_regfile/register[13]} -radix decimal} {{/tb_hart/dut/u_regfile/register[14]} -radix decimal} {{/tb_hart/dut/u_regfile/register[15]} -radix decimal} {{/tb_hart/dut/u_regfile/register[16]} -radix decimal} {{/tb_hart/dut/u_regfile/register[17]} -radix decimal} {{/tb_hart/dut/u_regfile/register[18]} -radix decimal} {{/tb_hart/dut/u_regfile/register[19]} -radix decimal} {{/tb_hart/dut/u_regfile/register[20]} -radix decimal} {{/tb_hart/dut/u_regfile/register[21]} -radix decimal} {{/tb_hart/dut/u_regfile/register[22]} -radix decimal} {{/tb_hart/dut/u_regfile/register[23]} -radix decimal} {{/tb_hart/dut/u_regfile/register[24]} -radix decimal} {{/tb_hart/dut/u_regfile/register[25]} -radix decimal} {{/tb_hart/dut/u_regfile/register[26]} -radix decimal} {{/tb_hart/dut/u_regfile/register[27]} -radix decimal} {{/tb_hart/dut/u_regfile/register[28]} -radix decimal} {{/tb_hart/dut/u_regfile/register[29]} -radix decimal} {{/tb_hart/dut/u_regfile/register[30]} -radix decimal} {{/tb_hart/dut/u_regfile/register[31]} -radix decimal}} -expand -subitemconfig {{/tb_hart/dut/u_regfile/register[1]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_regfile/register[2]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_regfile/register[3]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[4]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[5]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[6]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[7]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[8]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[9]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[10]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[11]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[12]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[13]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[14]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[15]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[16]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[17]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[18]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[19]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[20]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[21]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[22]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[23]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[24]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[25]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[26]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[27]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[28]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[29]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[30]} {-height 16 -radix decimal} {/tb_hart/dut/u_regfile/register[31]} {-height 16 -radix decimal}} /tb_hart/dut/u_regfile/register
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
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ma_data
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/set_q
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/way_q
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/rde
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/set_d
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/way_d
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/wre
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/imem_fsm
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/imem_fsm_next
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/ld_cnt
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr_2
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
add wave -noupdate -group hmem -radix hexadecimal -childformat {{{/tb_hart/dut/u_hmem/cache_line_out_i[255]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[254]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[253]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[252]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[251]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[250]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[249]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[248]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[247]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[246]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[245]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[244]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[243]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[242]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[241]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[240]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[239]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[238]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[237]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[236]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[235]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[234]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[233]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[232]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[231]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[230]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[229]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[228]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[227]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[226]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[225]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[224]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[223]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[222]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[221]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[220]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[219]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[218]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[217]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[216]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[215]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[214]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[213]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[212]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[211]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[210]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[209]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[208]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[207]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[206]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[205]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[204]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[203]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[202]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[201]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[200]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[199]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[198]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[197]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[196]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[195]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[194]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[193]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[192]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[191]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[190]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[189]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[188]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[187]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[186]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[185]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[184]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[183]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[182]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[181]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[180]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[179]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[178]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[177]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[176]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[175]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[174]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[173]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[172]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[171]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[170]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[169]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[168]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[167]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[166]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[165]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[164]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[163]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[162]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[161]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[160]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[159]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[158]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[157]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[156]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[155]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[154]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[153]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[152]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[151]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[150]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[149]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[148]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[147]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[146]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[145]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[144]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[143]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[142]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[141]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[140]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[139]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[138]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[137]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[136]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[135]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[134]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[133]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[132]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[131]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[130]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[129]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[128]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[127]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[126]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[125]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[124]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[123]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[122]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[121]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[120]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[119]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[118]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[117]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[116]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[115]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[114]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[113]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[112]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[111]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[110]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[109]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[108]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[107]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[106]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[105]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[104]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[103]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[102]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[101]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[100]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[99]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[98]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[97]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[96]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[95]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[94]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[93]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[92]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[91]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[90]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[89]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[88]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[87]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[86]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[85]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[84]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[83]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[82]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[81]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[80]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[79]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[78]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[77]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[76]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[75]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[74]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[73]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[72]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[71]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[70]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[69]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[68]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[67]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[66]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[65]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[64]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[63]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[62]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[61]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[60]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[59]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[58]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[57]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[56]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[55]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[54]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[53]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[52]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[51]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[50]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[49]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[48]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[47]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[46]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[45]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[44]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[43]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[42]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[41]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[40]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[39]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[38]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[37]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[36]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[35]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[34]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[33]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[32]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[31]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[30]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[29]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[28]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[27]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[26]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[25]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[24]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[23]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[22]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[21]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[20]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[19]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[18]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[17]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[16]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[15]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[14]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[13]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[12]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[11]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[10]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[9]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[8]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[7]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[6]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[5]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[4]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[3]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[2]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[1]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/cache_line_out_i[0]} -radix hexadecimal}} -subitemconfig {{/tb_hart/dut/u_hmem/cache_line_out_i[255]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[254]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[253]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[252]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[251]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[250]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[249]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[248]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[247]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[246]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[245]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[244]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[243]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[242]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[241]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[240]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[239]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[238]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[237]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[236]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[235]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[234]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[233]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[232]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[231]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[230]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[229]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[228]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[227]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[226]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[225]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[224]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[223]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[222]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[221]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[220]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[219]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[218]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[217]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[216]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[215]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[214]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[213]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[212]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[211]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[210]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[209]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[208]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[207]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[206]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[205]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[204]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[203]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[202]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[201]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[200]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[199]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[198]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[197]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[196]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[195]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[194]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[193]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[192]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[191]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[190]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[189]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[188]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[187]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[186]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[185]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[184]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[183]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[182]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[181]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[180]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[179]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[178]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[177]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[176]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[175]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[174]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[173]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[172]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[171]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[170]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[169]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[168]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[167]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[166]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[165]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[164]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[163]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[162]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[161]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[160]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[159]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[158]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[157]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[156]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[155]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[154]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[153]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[152]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[151]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[150]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[149]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[148]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[147]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[146]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[145]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[144]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[143]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[142]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[141]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[140]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[139]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[138]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[137]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[136]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[135]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[134]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[133]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[132]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[131]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[130]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[129]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[128]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[127]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[126]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[125]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[124]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[123]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[122]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[121]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[120]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[119]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[118]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[117]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[116]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[115]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[114]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[113]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[112]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[111]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[110]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[109]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[108]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[107]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[106]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[105]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[104]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[103]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[102]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[101]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[100]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[99]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[98]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[97]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[96]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[95]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[94]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[93]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[92]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[91]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[90]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[89]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[88]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[87]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[86]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[85]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[84]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[83]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[82]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[81]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[80]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[79]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[78]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[77]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[76]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[75]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[74]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[73]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[72]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[71]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[70]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[69]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[68]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[67]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[66]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[65]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[64]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[63]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[62]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[61]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[60]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[59]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[58]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[57]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[56]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[55]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[54]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[53]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[52]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[51]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[50]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[49]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[48]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[47]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[46]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[45]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[44]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[43]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[42]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[41]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[40]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[39]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[38]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[37]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[36]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[35]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[34]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[33]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[32]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[31]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[30]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[29]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[28]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[27]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[26]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[25]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[24]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[23]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[22]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[21]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[20]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[19]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[18]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[17]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[16]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[15]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[14]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[13]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[12]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[11]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[10]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[9]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[8]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[7]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[6]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[5]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[4]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[3]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[2]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[1]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/cache_line_out_i[0]} {-height 16 -radix hexadecimal}} /tb_hart/dut/u_hmem/cache_line_out_i
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
