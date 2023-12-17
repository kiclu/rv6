onerror {resume}
quietly virtual signal -install /tb_hart/dut/u_dmem { /tb_hart/dut/u_dmem/addr[63:4]} aaddr_start
quietly virtual function -install /tb_hart/dut/u_dmem -env /tb_hart/dut/u_dmem { &{/tb_hart/dut/u_dmem/aaddr_end[63], /tb_hart/dut/u_dmem/aaddr_end[62], /tb_hart/dut/u_dmem/aaddr_end[61], /tb_hart/dut/u_dmem/aaddr_end[60], /tb_hart/dut/u_dmem/aaddr_end[59], /tb_hart/dut/u_dmem/aaddr_end[58], /tb_hart/dut/u_dmem/aaddr_end[57], /tb_hart/dut/u_dmem/aaddr_end[56], /tb_hart/dut/u_dmem/aaddr_end[55], /tb_hart/dut/u_dmem/aaddr_end[54], /tb_hart/dut/u_dmem/aaddr_end[53], /tb_hart/dut/u_dmem/aaddr_end[52], /tb_hart/dut/u_dmem/aaddr_end[51], /tb_hart/dut/u_dmem/aaddr_end[50], /tb_hart/dut/u_dmem/aaddr_end[49], /tb_hart/dut/u_dmem/aaddr_end[48], /tb_hart/dut/u_dmem/aaddr_end[47], /tb_hart/dut/u_dmem/aaddr_end[46], /tb_hart/dut/u_dmem/aaddr_end[45], /tb_hart/dut/u_dmem/aaddr_end[44], /tb_hart/dut/u_dmem/aaddr_end[43], /tb_hart/dut/u_dmem/aaddr_end[42], /tb_hart/dut/u_dmem/aaddr_end[41], /tb_hart/dut/u_dmem/aaddr_end[40], /tb_hart/dut/u_dmem/aaddr_end[39], /tb_hart/dut/u_dmem/aaddr_end[38], /tb_hart/dut/u_dmem/aaddr_end[37], /tb_hart/dut/u_dmem/aaddr_end[36], /tb_hart/dut/u_dmem/aaddr_end[35], /tb_hart/dut/u_dmem/aaddr_end[34], /tb_hart/dut/u_dmem/aaddr_end[33], /tb_hart/dut/u_dmem/aaddr_end[32], /tb_hart/dut/u_dmem/aaddr_end[31], /tb_hart/dut/u_dmem/aaddr_end[30], /tb_hart/dut/u_dmem/aaddr_end[29], /tb_hart/dut/u_dmem/aaddr_end[28], /tb_hart/dut/u_dmem/aaddr_end[27], /tb_hart/dut/u_dmem/aaddr_end[26], /tb_hart/dut/u_dmem/aaddr_end[25], /tb_hart/dut/u_dmem/aaddr_end[24], /tb_hart/dut/u_dmem/aaddr_end[23], /tb_hart/dut/u_dmem/aaddr_end[22], /tb_hart/dut/u_dmem/aaddr_end[21], /tb_hart/dut/u_dmem/aaddr_end[20], /tb_hart/dut/u_dmem/aaddr_end[19], /tb_hart/dut/u_dmem/aaddr_end[18], /tb_hart/dut/u_dmem/aaddr_end[17], /tb_hart/dut/u_dmem/aaddr_end[16], /tb_hart/dut/u_dmem/aaddr_end[15], /tb_hart/dut/u_dmem/aaddr_end[14], /tb_hart/dut/u_dmem/aaddr_end[13], /tb_hart/dut/u_dmem/aaddr_end[12], /tb_hart/dut/u_dmem/aaddr_end[11], /tb_hart/dut/u_dmem/aaddr_end[10], /tb_hart/dut/u_dmem/aaddr_end[9], /tb_hart/dut/u_dmem/aaddr_end[8], /tb_hart/dut/u_dmem/aaddr_end[7], /tb_hart/dut/u_dmem/aaddr_end[6], /tb_hart/dut/u_dmem/aaddr_end[5], /tb_hart/dut/u_dmem/aaddr_end[4] }} aaddr_end_c
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
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/ir
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_in
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_out
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_addr_invalid
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_wr_invalid
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_pr_invalid
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/trap_addr
add wave -noupdate -expand -group csr /tb_hart/dut/u_csr/trap_taken
add wave -noupdate -expand -group csr /tb_hart/dut/u_csr/intr_s
add wave -noupdate -expand -group csr /tb_hart/dut/u_csr/intr_t
add wave -noupdate -expand -group csr /tb_hart/dut/u_csr/intr_e
add wave -noupdate -expand -group csr /tb_hart/dut/u_csr/dmem_ld_ma
add wave -noupdate -expand -group csr /tb_hart/dut/u_csr/dmem_st_ma
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_addr
add wave -noupdate -expand -group csr -group reg -label mstatus/sstatus -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[0]}
add wave -noupdate -expand -group csr -group reg -label mie/sie -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[1]}
add wave -noupdate -expand -group csr -group reg -label stvec -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[2]}
add wave -noupdate -expand -group csr -group reg -label scounteren -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[3]}
add wave -noupdate -expand -group csr -group reg -label sscratch -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[4]}
add wave -noupdate -expand -group csr -group reg -label sepc -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[5]}
add wave -noupdate -expand -group csr -group reg -label scause -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[6]}
add wave -noupdate -expand -group csr -group reg -label stval -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[7]}
add wave -noupdate -expand -group csr -group reg -label mip/sip -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[8]}
add wave -noupdate -expand -group csr -group reg -label satp -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[9]}
add wave -noupdate -expand -group csr -group reg -label mvendorid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[10]}
add wave -noupdate -expand -group csr -group reg -label marchid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[11]}
add wave -noupdate -expand -group csr -group reg -label mimpid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[12]}
add wave -noupdate -expand -group csr -group reg -label mhartid -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[13]}
add wave -noupdate -expand -group csr -group reg -label mconfigptr -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[14]}
add wave -noupdate -expand -group csr -group reg -label misa -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[15]}
add wave -noupdate -expand -group csr -group reg -label medeleg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[16]}
add wave -noupdate -expand -group csr -group reg -label mideleg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[17]}
add wave -noupdate -expand -group csr -group reg -label mtvec -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[18]}
add wave -noupdate -expand -group csr -group reg -label mcounteren -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[19]}
add wave -noupdate -expand -group csr -group reg -label mscratch -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[20]}
add wave -noupdate -expand -group csr -group reg -label mepc -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[21]}
add wave -noupdate -expand -group csr -group reg -label mcause -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[22]}
add wave -noupdate -expand -group csr -group reg -label mtval -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[23]}
add wave -noupdate -expand -group csr -group reg -label minst -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[24]}
add wave -noupdate -expand -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[25]}
add wave -noupdate -expand -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[26]}
add wave -noupdate -expand -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[27]}
add wave -noupdate -expand -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[28]}
add wave -noupdate -expand -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[29]}
add wave -noupdate -expand -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[30]}
add wave -noupdate -expand -group csr -group reg -radix hexadecimal {/tb_hart/dut/u_csr/csr_reg[31]}
add wave -noupdate -expand -group csr -radix binary /tb_hart/dut/u_csr/privilege_level
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rw
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rwi
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rs
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rsi
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rc
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr_rci
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/rd
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/wr
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/rd_valid
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/wr_valid
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/csr
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/wpri
add wave -noupdate -expand -group csr -radix hexadecimal /tb_hart/dut/u_csr/ncsr
add wave -noupdate -group alu -radix hexadecimal /tb_hart/dut/u_alu/a
add wave -noupdate -group alu -radix hexadecimal /tb_hart/dut/u_alu/b
add wave -noupdate -group alu -radix hexadecimal /tb_hart/dut/alu_out
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/ir_if
add wave -noupdate -group cu -radix hexadecimal /tb_hart/dut/u_cu/ir_pd
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
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/b_data
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/b_rd
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/b_dv
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr_tag
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr_set
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/addr_offs
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/data
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/tag
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/v
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/way
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/hit
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/lru_tree
add wave -noupdate -group imem -radix hexadecimal /tb_hart/dut/u_imem/re
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr
add wave -noupdate -expand -group dmem -radix binary /tb_hart/dut/u_dmem/len
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/data_out
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/rd
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/data_in
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/wr
add wave -noupdate -expand -group dmem /tb_hart/dut/u_dmem/ld_ma
add wave -noupdate -expand -group dmem /tb_hart/dut/u_dmem/st_ma
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_addr_d
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_data_in_d
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_rd_d
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_dv_d
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_data_out_d
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_wr_d
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv_addr
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr_tag
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr_set
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr_offs
add wave -noupdate -expand -group dmem -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/data[0]} -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/data[0][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/data[0][1]} -radix hexadecimal}}} {{/tb_hart/dut/u_dmem/data[1]} -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/data[1][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/data[1][1]} -radix hexadecimal}}}} -expand -subitemconfig {{/tb_hart/dut/u_dmem/data[0]} {-height 16 -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/data[0][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/data[0][1]} -radix hexadecimal}} -expand} {/tb_hart/dut/u_dmem/data[0][0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_dmem/data[0][1]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_dmem/data[1]} {-height 16 -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/data[1][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/data[1][1]} -radix hexadecimal}} -expand} {/tb_hart/dut/u_dmem/data[1][0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_dmem/data[1][1]} {-height 16 -radix hexadecimal}} /tb_hart/dut/u_dmem/data
add wave -noupdate -expand -group dmem -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/tag[0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/tag[1]} -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/tag[1][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/tag[1][1]} -radix hexadecimal}}}} -expand -subitemconfig {{/tb_hart/dut/u_dmem/tag[0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_dmem/tag[1]} {-height 16 -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/tag[1][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/tag[1][1]} -radix hexadecimal}} -expand} {/tb_hart/dut/u_dmem/tag[1][0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_dmem/tag[1][1]} {-height 16 -radix hexadecimal}} /tb_hart/dut/u_dmem/tag
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/v
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/way
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/data_mux
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/hit
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/lru_tree
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/re
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/dmem_op
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/dmem_op_d
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/lru_update
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/re_update
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/lru_update_d
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv_tag
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv_set
add wave -noupdate -expand -group dmem -label aaddr_start -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/aaddr_start[63]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[62]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[61]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[60]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[59]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[58]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[57]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[56]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[55]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[54]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[53]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[52]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[51]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[50]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[49]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[48]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[47]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[46]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[45]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[44]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[43]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[42]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[41]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[40]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[39]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[38]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[37]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[36]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[35]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[34]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[33]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[32]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[31]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[30]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[29]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[28]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[27]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[26]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[25]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[24]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[23]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[22]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[21]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[20]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[19]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[18]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[17]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[16]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[15]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[14]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[13]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[12]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[11]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[10]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[9]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[8]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[7]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[6]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[5]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/aaddr_start[4]} -radix hexadecimal}} -subitemconfig {{/tb_hart/dut/u_dmem/addr[63]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[62]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[61]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[60]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[59]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[58]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[57]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[56]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[55]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[54]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[53]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[52]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[51]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[50]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[49]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[48]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[47]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[46]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[45]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[44]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[43]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[42]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[41]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[40]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[39]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[38]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[37]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[36]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[35]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[34]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[33]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[32]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[31]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[30]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[29]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[28]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[27]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[26]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[25]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[24]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[23]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[22]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[21]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[20]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[19]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[18]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[17]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[16]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[15]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[14]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[13]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[12]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[11]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[10]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[9]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[8]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[7]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[6]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[5]} {-radix hexadecimal} {/tb_hart/dut/u_dmem/addr[4]} {-radix hexadecimal}} /tb_hart/dut/u_dmem/aaddr_start
add wave -noupdate -expand -group dmem -label aaddr_end -radix hexadecimal /tb_hart/dut/u_dmem/aaddr_end_c
add wave -noupdate -expand -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_wr_dd
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
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/rst_n
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/clk
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_tag_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_set_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_offs_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_tag_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_set_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/addr_offs_d
add wave -noupdate -group hmem -radix hexadecimal -childformat {{{/tb_hart/dut/u_hmem/data[0]} -radix hexadecimal -childformat {{{/tb_hart/dut/u_hmem/data[0][0]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/data[0][1]} -radix hexadecimal}}} {{/tb_hart/dut/u_hmem/data[1]} -radix hexadecimal -childformat {{{/tb_hart/dut/u_hmem/data[1][0]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/data[1][1]} -radix hexadecimal}}}} -subitemconfig {{/tb_hart/dut/u_hmem/data[0]} {-height 16 -radix hexadecimal -childformat {{{/tb_hart/dut/u_hmem/data[0][0]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/data[0][1]} -radix hexadecimal}} -expand} {/tb_hart/dut/u_hmem/data[0][0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/data[0][1]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/data[1]} {-height 16 -radix hexadecimal -childformat {{{/tb_hart/dut/u_hmem/data[1][0]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/data[1][1]} -radix hexadecimal}} -expand} {/tb_hart/dut/u_hmem/data[1][0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/data[1][1]} {-height 16 -radix hexadecimal}} /tb_hart/dut/u_hmem/data
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/tag
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/v
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/way_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/hit_i
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/way_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/hit_d
add wave -noupdate -group hmem -radix hexadecimal -childformat {{{/tb_hart/dut/u_hmem/lru_tree[0]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/lru_tree[1]} -radix hexadecimal}} -expand -subitemconfig {{/tb_hart/dut/u_hmem/lru_tree[0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/lru_tree[1]} {-height 16 -radix hexadecimal}} /tb_hart/dut/u_hmem/lru_tree
add wave -noupdate -group hmem -radix hexadecimal -childformat {{{/tb_hart/dut/u_hmem/re[0]} -radix hexadecimal} {{/tb_hart/dut/u_hmem/re[1]} -radix hexadecimal}} -expand -subitemconfig {{/tb_hart/dut/u_hmem/re[0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_hmem/re[1]} {-height 16 -radix hexadecimal}} /tb_hart/dut/u_hmem/re
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/hmem_op
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/hmem_op_d
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/lru_update
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/inv_tag
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/inv_set
add wave -noupdate -group hmem -radix hexadecimal /tb_hart/dut/u_hmem/h_wr_d
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18744610 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 254
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
WaveRestoreZoom {18329193 ps} {19470609 ps}
