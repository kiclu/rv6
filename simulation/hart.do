onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_hart/b_addr_i
add wave -noupdate -radix hexadecimal /tb_hart/b_data_i
add wave -noupdate /tb_hart/b_rd_i
add wave -noupdate /tb_hart/b_dv_i
add wave -noupdate -radix hexadecimal /tb_hart/b_addr
add wave -noupdate -radix hexadecimal /tb_hart/b_data_in
add wave -noupdate /tb_hart/b_rd
add wave -noupdate /tb_hart/b_dv
add wave -noupdate -radix hexadecimal /tb_hart/dut/inst_dmem/data_in
add wave -noupdate -radix hexadecimal /tb_hart/dut/bxm_alu_out
add wave -noupdate -radix hexadecimal /tb_hart/dut/bxm_r2
add wave -noupdate /tb_hart/dut/inst_dmem/wr
add wave -noupdate /tb_hart/dut/inst_dmem/rd
add wave -noupdate -radix hexadecimal /tb_hart/b_data_out
add wave -noupdate /tb_hart/b_wr
add wave -noupdate /tb_hart/rst_n
add wave -noupdate /tb_hart/clk
add wave -noupdate /tb_hart/dut/inst_br_alu/pr_miss
add wave -noupdate /tb_hart/dut/flush_n
add wave -noupdate -radix hexadecimal /tb_hart/dut/ir
add wave -noupdate -radix hexadecimal /tb_hart/dut/bfp_ir
add wave -noupdate -radix hexadecimal /tb_hart/dut/bpd_ir
add wave -noupdate -radix unsigned /tb_hart/dut/inst_cu/rs1
add wave -noupdate -radix unsigned /tb_hart/dut/inst_cu/rs2
add wave -noupdate -radix hexadecimal /tb_hart/dut/bdx_ir
add wave -noupdate -radix unsigned /tb_hart/dut/inst_cu/rd_ex
add wave -noupdate -radix hexadecimal /tb_hart/dut/bxm_ir
add wave -noupdate -radix unsigned /tb_hart/dut/inst_cu/rd_mem
add wave -noupdate -radix hexadecimal /tb_hart/dut/bmw_ir
add wave -noupdate -radix unsigned /tb_hart/dut/inst_cu/rd_wb
add wave -noupdate -radix hexadecimal /tb_hart/dut/pc
add wave -noupdate -radix hexadecimal /tb_hart/dut/bfp_pc
add wave -noupdate -radix hexadecimal /tb_hart/dut/bpd_pc
add wave -noupdate -radix hexadecimal /tb_hart/dut/bdx_pc
add wave -noupdate -radix hexadecimal /tb_hart/dut/jalr_addr
add wave -noupdate -radix hexadecimal /tb_hart/dut/jal_addr
add wave -noupdate -radix decimal /tb_hart/dut/pr_offs
add wave -noupdate -expand -group {branch prediction} -radix hexadecimal /tb_hart/dut/inst_bpu/pr_taken
add wave -noupdate -expand -group {branch prediction} -radix hexadecimal /tb_hart/dut/inst_bpu/pr_offs
add wave -noupdate -expand -group {branch prediction check} /tb_hart/dut/inst_br_alu/brc
add wave -noupdate -expand -group {branch prediction check} /tb_hart/dut/inst_br_alu/pr_taken
add wave -noupdate -expand -group {branch prediction check} /tb_hart/dut/inst_br_alu/pr_miss
add wave -noupdate -expand -group {branch prediction check} -radix hexadecimal /tb_hart/dut/inst_br_alu/br_addr
add wave -noupdate /tb_hart/dut/jalr_taken
add wave -noupdate /tb_hart/dut/jal_taken
add wave -noupdate /tb_hart/dut/pr_taken
add wave -noupdate -expand -group {stall signals} /tb_hart/dut/inst_cu/stall_if
add wave -noupdate -expand -group {stall signals} /tb_hart/dut/inst_cu/stall_pd
add wave -noupdate -expand -group {stall signals} /tb_hart/dut/inst_cu/stall_id
add wave -noupdate -expand -group {stall signals} /tb_hart/dut/inst_cu/stall_ex
add wave -noupdate -expand -group {stall signals} /tb_hart/dut/inst_cu/stall_mem
add wave -noupdate -group {data hazard signals} /tb_hart/dut/inst_cu/dh_ex
add wave -noupdate -group {data hazard signals} /tb_hart/dut/inst_cu/dh_mem
add wave -noupdate -group {data hazard signals} /tb_hart/dut/inst_cu/dh_wb
add wave -noupdate -group {data hazard signals} /tb_hart/dut/inst_cu/dh
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {200000 ps} 1} {{Cursor 2} {2000000 ps} 1} {{Cursor 3} {208811 ps} 0}
quietly wave cursor active 3
configure wave -namecolwidth 242
configure wave -valuecolwidth 83
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
WaveRestoreZoom {0 ps} {716185 ps}
