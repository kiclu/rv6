onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/h_addr
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/h_data_in
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/h_rd
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/h_dv
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/h_data_out
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/h_wr
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/inv_addr
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/inv
add wave -noupdate /tb_hart_fib_c/dut/amo_req
add wave -noupdate /tb_hart_fib_c/dut/amo_ack
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/rst_n
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/clk
add wave -noupdate -radix hexadecimal /tb_hart_fib_c/dut/pc
add wave -noupdate -group ir -radix hexadecimal /tb_hart_fib_c/dut/inst_cu/ir_if
add wave -noupdate -group ir -radix hexadecimal /tb_hart_fib_c/dut/inst_cu/ir_pd
add wave -noupdate -group ir -radix hexadecimal /tb_hart_fib_c/dut/inst_cu/ir_id
add wave -noupdate -group ir -radix hexadecimal /tb_hart_fib_c/dut/inst_cu/ir_ex
add wave -noupdate -group ir -radix hexadecimal /tb_hart_fib_c/dut/inst_cu/ir_mem
add wave -noupdate -group ir -radix hexadecimal /tb_hart_fib_c/dut/inst_cu/ir_wb
add wave -noupdate -expand -group reg -radix hexadecimal /tb_hart_fib_c/dut/inst_regfile/r1
add wave -noupdate -expand -group reg -radix decimal /tb_hart_fib_c/dut/inst_regfile/rs1
add wave -noupdate -expand -group reg -radix hexadecimal /tb_hart_fib_c/dut/inst_regfile/r2
add wave -noupdate -expand -group reg -radix decimal /tb_hart_fib_c/dut/inst_regfile/rs2
add wave -noupdate -expand -group reg -radix hexadecimal /tb_hart_fib_c/dut/inst_regfile/d
add wave -noupdate -expand -group reg -radix decimal /tb_hart_fib_c/dut/inst_regfile/rd
add wave -noupdate -expand -group reg /tb_hart_fib_c/dut/inst_regfile/wr
add wave -noupdate -expand -group reg -radix decimal -childformat {{{/tb_hart_fib_c/dut/inst_regfile/register[1]} -radix hexadecimal} {{/tb_hart_fib_c/dut/inst_regfile/register[2]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[3]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[4]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[5]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[6]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[7]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[8]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[9]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[10]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[11]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[12]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[13]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[14]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[15]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[16]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[17]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[18]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[19]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[20]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[21]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[22]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[23]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[24]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[25]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[26]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[27]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[28]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[29]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[30]} -radix decimal} {{/tb_hart_fib_c/dut/inst_regfile/register[31]} -radix decimal}} -expand -subitemconfig {{/tb_hart_fib_c/dut/inst_regfile/register[1]} {-height 16 -radix hexadecimal} {/tb_hart_fib_c/dut/inst_regfile/register[2]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[3]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[4]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[5]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[6]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[7]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[8]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[9]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[10]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[11]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[12]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[13]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[14]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[15]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[16]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[17]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[18]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[19]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[20]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[21]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[22]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[23]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[24]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[25]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[26]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[27]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[28]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[29]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[30]} {-height 16 -radix decimal} {/tb_hart_fib_c/dut/inst_regfile/register[31]} {-height 16 -radix decimal}} /tb_hart_fib_c/dut/inst_regfile/register
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/pc
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/ir
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/jal_taken
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/jal_addr
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/pr_taken
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/pr_offs
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/rst_n
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/j_taken
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/j_taken_c
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/j_addr
add wave -noupdate -group bpu -radix hexadecimal /tb_hart_fib_c/dut/inst_bpu/j_addr_c
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/pc
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/jalr_taken
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/jalr_addr
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/pr_miss
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/br_addr
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/jal_taken
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/jal_addr
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/pr_taken
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/pr_offs
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/c_ins
add wave -noupdate -group pc /tb_hart_fib_c/dut/inst_pc/stall
add wave -noupdate -expand -group stall /tb_hart_fib_c/dut/inst_cu/stall_if
add wave -noupdate -expand -group stall /tb_hart_fib_c/dut/inst_cu/stall_pd
add wave -noupdate -expand -group stall /tb_hart_fib_c/dut/inst_cu/stall_id
add wave -noupdate -expand -group stall /tb_hart_fib_c/dut/inst_cu/stall_ex
add wave -noupdate -expand -group stall /tb_hart_fib_c/dut/inst_cu/stall_mem
add wave -noupdate -expand -group stall /tb_hart_fib_c/dut/inst_cu/stall_wb
add wave -noupdate -group dmem -radix unsigned /tb_hart_fib_c/dut/inst_dmem/addr
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/len
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/data_out
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/rd
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/data_in
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/wr
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/b_addr_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/b_data_in_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/b_rd_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/b_dv_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/b_data_out_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/b_wr_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/inv_addr
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/inv
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/rst_n
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/clk
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/addr_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/addr_set
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/addr_offs
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/data
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/v
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/way
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/data_mux
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/hit
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/lru_tree
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/re
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/dmem_op
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/dmem_op_d
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/lru_update
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/inv_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/inv_set
add wave -noupdate -group dmem -radix hexadecimal /tb_hart_fib_c/dut/inst_dmem/b_wr_dd
add wave -noupdate -expand -group pd -radix hexadecimal /tb_hart_fib_c/dut/inst_pd/pc_in
add wave -noupdate -expand -group pd -radix hexadecimal /tb_hart_fib_c/dut/inst_pd/ir_in
add wave -noupdate -expand -group pd -radix hexadecimal /tb_hart_fib_c/dut/inst_pd/ir_out
add wave -noupdate -expand -group pd /tb_hart_fib_c/dut/inst_pd/amo_req
add wave -noupdate -expand -group pd /tb_hart_fib_c/dut/inst_pd/amo_ack
add wave -noupdate -expand -group pd /tb_hart_fib_c/dut/inst_pd/stall
add wave -noupdate -expand -group pd /tb_hart_fib_c/dut/inst_pd/rst_n
add wave -noupdate -expand -group pd /tb_hart_fib_c/dut/inst_pd/clk
add wave -noupdate -expand -group pd /tb_hart_fib_c/dut/inst_pd/sc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 7} {1660000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 272
configure wave -valuecolwidth 148
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
WaveRestoreZoom {1208278 ps} {2507876 ps}
