onerror {resume}
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
add wave -noupdate -group pc -radix hexadecimal /tb_hart/dut/u_pc/trap
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
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/len
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/data_out
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/rd
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/data_in
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/wr
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_addr_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_data_in_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_rd_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_dv_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_data_out_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_wr_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv_addr
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr_set
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/addr_offs
add wave -noupdate -group dmem -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/data[0]} -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/data[0][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/data[0][1]} -radix hexadecimal}}} {{/tb_hart/dut/u_dmem/data[1]} -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/data[1][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/data[1][1]} -radix hexadecimal}}}} -expand -subitemconfig {{/tb_hart/dut/u_dmem/data[0]} {-height 16 -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/data[0][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/data[0][1]} -radix hexadecimal}} -expand} {/tb_hart/dut/u_dmem/data[0][0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_dmem/data[0][1]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_dmem/data[1]} {-height 16 -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/data[1][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/data[1][1]} -radix hexadecimal}} -expand} {/tb_hart/dut/u_dmem/data[1][0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_dmem/data[1][1]} {-height 16 -radix hexadecimal}} /tb_hart/dut/u_dmem/data
add wave -noupdate -group dmem -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/tag[0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/tag[1]} -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/tag[1][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/tag[1][1]} -radix hexadecimal}}}} -expand -subitemconfig {{/tb_hart/dut/u_dmem/tag[0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_dmem/tag[1]} {-height 16 -radix hexadecimal -childformat {{{/tb_hart/dut/u_dmem/tag[1][0]} -radix hexadecimal} {{/tb_hart/dut/u_dmem/tag[1][1]} -radix hexadecimal}} -expand} {/tb_hart/dut/u_dmem/tag[1][0]} {-height 16 -radix hexadecimal} {/tb_hart/dut/u_dmem/tag[1][1]} {-height 16 -radix hexadecimal}} /tb_hart/dut/u_dmem/tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/v
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/way
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/data_mux
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/hit
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/lru_tree
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/re
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/dmem_op
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/dmem_op_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/lru_update
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/re_update
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/lru_update_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/inv_set
add wave -noupdate -group dmem -radix hexadecimal /tb_hart/dut/u_dmem/b_wr_dd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17860000 ps} 1}
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
WaveRestoreZoom {0 ps} {32325231 ps}
