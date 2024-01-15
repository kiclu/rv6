onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_core/dut/c_addr
add wave -noupdate -radix hexadecimal /tb_core/dut/c_ext
add wave -noupdate -radix hexadecimal /tb_core/dut/c_rdata
add wave -noupdate -radix hexadecimal /tb_core/dut/c_rd
add wave -noupdate -radix hexadecimal /tb_core/dut/c_dv
add wave -noupdate -radix hexadecimal /tb_core/dut/c_wdata
add wave -noupdate -radix hexadecimal /tb_core/dut/c_len
add wave -noupdate -radix hexadecimal /tb_core/dut/c_wr
add wave -noupdate -radix hexadecimal /tb_core/dut/c_irq_e
add wave -noupdate -radix hexadecimal /tb_core/dut/c_irq_t
add wave -noupdate -radix hexadecimal /tb_core/dut/c_irq_s
add wave -noupdate -radix hexadecimal /tb_core/dut/c_inv_addr
add wave -noupdate -radix hexadecimal /tb_core/dut/c_inv
add wave -noupdate -radix hexadecimal /tb_core/dut/c_amo_req
add wave -noupdate -radix hexadecimal /tb_core/dut/c_amo_ack
add wave -noupdate -radix hexadecimal /tb_core/dut/c_rst_n
add wave -noupdate -radix hexadecimal /tb_core/dut/c_clk
add wave -noupdate -radix hexadecimal /tb_core/dut/pc
add wave -noupdate -radix hexadecimal /tb_core/dut/ir
add wave -noupdate /tb_core/dut/stall_if
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/pc
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/trap_taken
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/trap_addr
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/jalr_taken
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/jalr_addr
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/pr_miss
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/br_addr
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/jal_taken
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/jal_addr
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/pr_taken
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/pr_offs
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/c_ins
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/stall
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/rst_n
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/clk
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/pr_addr
add wave -noupdate -group pc -radix hexadecimal /tb_core/dut/u_pc/n_pc
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/pc
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/ir
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/jal_taken
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/jal_addr
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/pr_taken
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/pr_offs
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/rst_n
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/j_taken
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/j_taken_c
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/j_addr
add wave -noupdate -group bpu -radix hexadecimal /tb_core/dut/u_bpu/j_addr_c
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/r1
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/rs1
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/r2
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/rs2
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/d
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/rd
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/wr
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/clk
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/_reg
add wave -noupdate -group alu -radix hexadecimal /tb_core/dut/u_alu/a
add wave -noupdate -group alu -radix hexadecimal /tb_core/dut/u_alu/b
add wave -noupdate -group alu -radix hexadecimal /tb_core/dut/u_alu/alu_out
add wave -noupdate -group alu -radix hexadecimal /tb_core/dut/u_alu/op_ir
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/pc
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/ir
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/b_addr_i
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/b_data_i
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/b_rd_i
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/b_dv_i
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/stall_imem
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/rst_n
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/clk
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/addr
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/addr_tag
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/addr_set
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/addr_offs
add wave -noupdate -group imem -radix hexadecimal -childformat {{{/tb_core/dut/u_imem/data[0]} -radix hexadecimal} {{/tb_core/dut/u_imem/data[1]} -radix hexadecimal} {{/tb_core/dut/u_imem/data[2]} -radix hexadecimal} {{/tb_core/dut/u_imem/data[3]} -radix hexadecimal}} -expand -subitemconfig {{/tb_core/dut/u_imem/data[0]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_imem/data[1]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_imem/data[2]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_imem/data[3]} {-height 16 -radix hexadecimal}} /tb_core/dut/u_imem/data
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/tag
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/v
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/re
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/hit
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/tag_d
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/set_d
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/way_d
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/d
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/wre
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/tag_q
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/set_q
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/way_q
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/q
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/rde
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/rb_tag
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/rb_set
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/rb_v
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/rb_hit
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/ma_pc
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/ma_reg
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/ma_pend
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/ma_acc
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/ma_re
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/ma
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/ld_cnt
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/imem_fsm_state
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/imem_fsm_state_next
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/ma_d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/addr
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/len
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/rdata
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/rd
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wdata
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wr
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/ld_ma
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/st_ma
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/b_addr_d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/b_rdata_d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/b_rd_d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/b_dv_d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/b_inv_addr_d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/inv
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/stall_dmem
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/rst_n
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/clk
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/addr_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/addr_set
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/addr_offs
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/data
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/tag
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/v
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/re
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/hit
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/tag_d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/set_d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/way_d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wre
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/tag_q
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/set_q
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/way_q
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/q
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/rde
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wb_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wb_set
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wb_offs
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wb_data
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wb_len
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wr_pend
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/rb_tag
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/rb_set
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/rb_v
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/rb_hit
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/ld_cnt
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/dmem_fsm_state
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/dmem_fsm_state_next
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_addr_w
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_wdata_w
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_len_w
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_wr_w
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_addr_i
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_data_i
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_rd_i
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_dv_i
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_addr_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_rdata_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_rd_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_dv_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_addr_c
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_rdata_c
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_rd_c
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_dv_c
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/b_inv_addr_c
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/inv
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/stall_cmem
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rst_n
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/clk
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/addr_i_tag
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/addr_i_set
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/addr_i_offs
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/addr_d_tag
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/addr_d_set
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/addr_d_offs
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/addr_w_tag
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/addr_w_set
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/addr_w_offs
add wave -noupdate -group cmem -radix hexadecimal -childformat {{{/tb_core/dut/u_cmem/data[0]} -radix hexadecimal} {{/tb_core/dut/u_cmem/data[1]} -radix hexadecimal} {{/tb_core/dut/u_cmem/data[2]} -radix hexadecimal} {{/tb_core/dut/u_cmem/data[3]} -radix hexadecimal}} -expand -subitemconfig {{/tb_core/dut/u_cmem/data[0]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_cmem/data[1]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_cmem/data[2]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_cmem/data[3]} {-height 16 -radix hexadecimal}} /tb_core/dut/u_cmem/data
add wave -noupdate -group cmem -radix hexadecimal -childformat {{{/tb_core/dut/u_cmem/tag[0]} -radix hexadecimal} {{/tb_core/dut/u_cmem/tag[1]} -radix hexadecimal} {{/tb_core/dut/u_cmem/tag[2]} -radix hexadecimal} {{/tb_core/dut/u_cmem/tag[3]} -radix hexadecimal}} -expand -subitemconfig {{/tb_core/dut/u_cmem/tag[0]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_cmem/tag[1]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_cmem/tag[2]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_cmem/tag[3]} {-height 16 -radix hexadecimal}} /tb_core/dut/u_cmem/tag
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/v
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/re
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/hit_i
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/hit_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/hit_w
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/tag_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/set_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/way_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/wre
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/tag_qi
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/set_qi
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/way_qi
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/qi
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rde_i
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/tag_qd
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/set_qd
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/way_qd
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/qd
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rde_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rb_tag_i
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rb_set_i
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rb_v_i
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rb_hit_i
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rb_tag_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rb_set_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rb_v_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rb_hit_d
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/rb_hit_w
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/wb_tag
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/wb_set
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/wb_offs
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/wb_data
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/wb_len
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/wr_pend
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/ld_cnt
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/cmem_fsm_state
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/cmem_fsm_state_next
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/pend
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/pend_next
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {51020000 ps} 1} {{Cursor 2} {22060000 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 241
configure wave -valuecolwidth 158
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
WaveRestoreZoom {0 ps} {71887767 ps}
