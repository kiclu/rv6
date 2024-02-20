onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label c_addr -radix hexadecimal /tb_core/dut/c_addr
add wave -noupdate -label c_ext -radix hexadecimal /tb_core/dut/c_ext
add wave -noupdate -label c_rdata -radix hexadecimal /tb_core/dut/c_rdata
add wave -noupdate -label c_rd -radix hexadecimal /tb_core/dut/c_rd
add wave -noupdate -label c_dv -radix hexadecimal /tb_core/dut/c_dv
add wave -noupdate -label c_wdata -radix hexadecimal /tb_core/dut/c_wdata
add wave -noupdate -label c_len -radix binary /tb_core/dut/c_len
add wave -noupdate -label c_wr -radix hexadecimal /tb_core/dut/c_wr
add wave -noupdate -label c_inv_addr -radix hexadecimal -childformat {{{/tb_core/dut/c_inv_addr[63]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[62]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[61]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[60]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[59]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[58]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[57]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[56]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[55]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[54]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[53]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[52]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[51]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[50]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[49]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[48]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[47]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[46]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[45]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[44]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[43]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[42]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[41]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[40]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[39]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[38]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[37]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[36]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[35]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[34]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[33]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[32]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[31]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[30]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[29]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[28]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[27]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[26]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[25]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[24]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[23]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[22]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[21]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[20]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[19]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[18]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[17]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[16]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[15]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[14]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[13]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[12]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[11]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[10]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[9]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[8]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[7]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[6]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[5]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[4]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[3]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[2]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[1]} -radix hexadecimal} {{/tb_core/dut/c_inv_addr[0]} -radix hexadecimal}} -subitemconfig {{/tb_core/dut/c_inv_addr[63]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[62]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[61]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[60]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[59]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[58]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[57]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[56]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[55]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[54]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[53]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[52]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[51]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[50]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[49]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[48]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[47]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[46]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[45]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[44]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[43]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[42]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[41]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[40]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[39]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[38]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[37]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[36]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[35]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[34]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[33]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[32]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[31]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[30]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[29]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[28]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[27]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[26]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[25]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[24]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[23]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[22]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[21]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[20]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[19]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[18]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[17]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[16]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[15]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[14]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[13]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[12]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[11]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[10]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[9]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[8]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[7]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[6]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[5]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[4]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[3]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[2]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[1]} {-height 16 -radix hexadecimal} {/tb_core/dut/c_inv_addr[0]} {-height 16 -radix hexadecimal}} /tb_core/dut/c_inv_addr
add wave -noupdate -label c_inv -radix hexadecimal /tb_core/dut/c_inv
add wave -noupdate -label c_amo_req -radix hexadecimal /tb_core/dut/c_amo_req
add wave -noupdate -label c_amo_ack -radix hexadecimal /tb_core/dut/c_amo_ack
add wave -noupdate -label c_rst_n -radix hexadecimal /tb_core/dut/c_rst_n
add wave -noupdate -label c_clk -radix hexadecimal /tb_core/dut/c_clk
add wave -noupdate -label pc -radix hexadecimal /tb_core/dut/pc
add wave -noupdate -label ir -radix hexadecimal /tb_core/dut/ir
add wave -noupdate -group imem -label pc -radix hexadecimal /tb_core/dut/u_imem/pc
add wave -noupdate -group imem -label ir -radix hexadecimal /tb_core/dut/u_imem/ir
add wave -noupdate -group imem -label b_addr_i -radix hexadecimal /tb_core/dut/u_imem/b_addr_i
add wave -noupdate -group imem -label b_data_i -radix hexadecimal /tb_core/dut/u_imem/b_data_i
add wave -noupdate -group imem -label b_rd_i -radix hexadecimal /tb_core/dut/u_imem/b_rd_i
add wave -noupdate -group imem -label b_dv_i -radix hexadecimal /tb_core/dut/u_imem/b_dv_i
add wave -noupdate -group imem -label stall_imem -radix hexadecimal /tb_core/dut/u_imem/stall_imem
add wave -noupdate -group imem -label rst_n -radix hexadecimal /tb_core/dut/u_imem/rst_n
add wave -noupdate -group imem -label clk -radix hexadecimal /tb_core/dut/u_imem/clk
add wave -noupdate -group imem -label addr -radix hexadecimal /tb_core/dut/u_imem/addr
add wave -noupdate -group imem -label addr_tag -radix hexadecimal /tb_core/dut/u_imem/addr_tag
add wave -noupdate -group imem -label addr_set -radix hexadecimal /tb_core/dut/u_imem/addr_set
add wave -noupdate -group imem -label addr_offs -radix hexadecimal /tb_core/dut/u_imem/addr_offs
add wave -noupdate -group imem -label data -radix hexadecimal -childformat {{{/tb_core/dut/u_imem/data[0]} -radix hexadecimal} {{/tb_core/dut/u_imem/data[1]} -radix hexadecimal} {{/tb_core/dut/u_imem/data[2]} -radix hexadecimal} {{/tb_core/dut/u_imem/data[3]} -radix hexadecimal}} -subitemconfig {{/tb_core/dut/u_imem/data[0]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_imem/data[1]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_imem/data[2]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_imem/data[3]} {-height 16 -radix hexadecimal}} /tb_core/dut/u_imem/data
add wave -noupdate -group imem -label tag -radix hexadecimal /tb_core/dut/u_imem/tag
add wave -noupdate -group imem -label valid -radix hexadecimal -childformat {{{/tb_core/dut/u_imem/v[0]} -radix hexadecimal} {{/tb_core/dut/u_imem/v[1]} -radix hexadecimal} {{/tb_core/dut/u_imem/v[2]} -radix hexadecimal} {{/tb_core/dut/u_imem/v[3]} -radix hexadecimal}} -subitemconfig {{/tb_core/dut/u_imem/v[0]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_imem/v[1]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_imem/v[2]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_imem/v[3]} {-height 16 -radix hexadecimal}} /tb_core/dut/u_imem/v
add wave -noupdate -group imem -label {repl. entry} -radix hexadecimal -childformat {{{/tb_core/dut/u_imem/re[0]} -radix hexadecimal}} -subitemconfig {{/tb_core/dut/u_imem/re[0]} {-height 16 -radix hexadecimal}} /tb_core/dut/u_imem/re
add wave -noupdate -group imem -label hit -radix hexadecimal /tb_core/dut/u_imem/hit
add wave -noupdate -group imem -label tag_d -radix hexadecimal /tb_core/dut/u_imem/tag_d
add wave -noupdate -group imem -label set_d -radix hexadecimal /tb_core/dut/u_imem/set_d
add wave -noupdate -group imem -label way_d -radix hexadecimal /tb_core/dut/u_imem/way_d
add wave -noupdate -group imem -label data_d -radix hexadecimal /tb_core/dut/u_imem/d
add wave -noupdate -group imem -label wre -radix hexadecimal /tb_core/dut/u_imem/wre
add wave -noupdate -group imem -label tag_q -radix hexadecimal /tb_core/dut/u_imem/tag_q
add wave -noupdate -group imem -label set_q -radix hexadecimal /tb_core/dut/u_imem/set_q
add wave -noupdate -group imem -label way_q -radix hexadecimal /tb_core/dut/u_imem/way_q
add wave -noupdate -group imem -label data_q -radix hexadecimal /tb_core/dut/u_imem/q
add wave -noupdate -group imem -label rde -radix hexadecimal /tb_core/dut/u_imem/rde
add wave -noupdate -group imem -label rb_tag -radix hexadecimal /tb_core/dut/u_imem/rb_tag
add wave -noupdate -group imem -label rb_set -radix hexadecimal /tb_core/dut/u_imem/rb_set
add wave -noupdate -group imem -label rb_v -radix hexadecimal /tb_core/dut/u_imem/rb_v
add wave -noupdate -group imem -label rb_hit -radix hexadecimal /tb_core/dut/u_imem/rb_hit
add wave -noupdate -group imem -label ma_pc -radix hexadecimal /tb_core/dut/u_imem/ma_pc
add wave -noupdate -group imem -label ma_reg -radix hexadecimal /tb_core/dut/u_imem/ma_reg
add wave -noupdate -group imem -label ma_pend -radix hexadecimal /tb_core/dut/u_imem/ma_pend
add wave -noupdate -group imem -label ma_acc -radix hexadecimal /tb_core/dut/u_imem/ma_acc
add wave -noupdate -group imem -label ma_re -radix hexadecimal /tb_core/dut/u_imem/ma_re
add wave -noupdate -group imem -label ma -radix hexadecimal /tb_core/dut/u_imem/ma
add wave -noupdate -group imem -label ld_cnt -radix hexadecimal /tb_core/dut/u_imem/ld_cnt
add wave -noupdate -group imem -label imem_fsm_state -radix hexadecimal /tb_core/dut/u_imem/imem_fsm_state
add wave -noupdate -group imem -label imem_fsm_state_next -radix hexadecimal /tb_core/dut/u_imem/imem_fsm_state_next
add wave -noupdate -group imem -label ma_d -radix hexadecimal /tb_core/dut/u_imem/ma_d
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
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/stall_mem
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
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wr_nstall
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wr_nstall_d
add wave -noupdate -group dmem -radix hexadecimal /tb_core/dut/u_dmem/wr_nstall_re
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
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/data
add wave -noupdate -group cmem -radix hexadecimal /tb_core/dut/u_cmem/tag
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
add wave -noupdate -group reg -radix hexadecimal -childformat {{{/tb_core/dut/u_regfile/rs1_data[63]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[62]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[61]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[60]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[59]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[58]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[57]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[56]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[55]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[54]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[53]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[52]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[51]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[50]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[49]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[48]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[47]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[46]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[45]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[44]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[43]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[42]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[41]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[40]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[39]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[38]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[37]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[36]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[35]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[34]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[33]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[32]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[31]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[30]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[29]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[28]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[27]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[26]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[25]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[24]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[23]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[22]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[21]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[20]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[19]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[18]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[17]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[16]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[15]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[14]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[13]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[12]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[11]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[10]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[9]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[8]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[7]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[6]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[5]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[4]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[3]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[2]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[1]} -radix hexadecimal} {{/tb_core/dut/u_regfile/rs1_data[0]} -radix hexadecimal}} -subitemconfig {{/tb_core/dut/u_regfile/rs1_data[63]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[62]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[61]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[60]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[59]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[58]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[57]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[56]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[55]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[54]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[53]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[52]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[51]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[50]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[49]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[48]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[47]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[46]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[45]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[44]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[43]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[42]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[41]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[40]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[39]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[38]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[37]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[36]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[35]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[34]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[33]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[32]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[31]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[30]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[29]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[28]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[27]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[26]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[25]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[24]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[23]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[22]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[21]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[20]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[19]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[18]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[17]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[16]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[15]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[14]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[13]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[12]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[11]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[10]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[9]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[8]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[7]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[6]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[5]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[4]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[3]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[2]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[1]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/rs1_data[0]} {-height 16 -radix hexadecimal}} /tb_core/dut/u_regfile/rs1_data
add wave -noupdate -group reg -radix unsigned /tb_core/dut/u_regfile/rs1
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/rs2_data
add wave -noupdate -group reg -radix unsigned /tb_core/dut/u_regfile/rs2
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/rd_data
add wave -noupdate -group reg -radix unsigned /tb_core/dut/u_regfile/rd
add wave -noupdate -group reg -radix hexadecimal /tb_core/dut/u_regfile/we
add wave -noupdate -group reg -radix hexadecimal -childformat {{{/tb_core/dut/u_regfile/reg_data[1]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[2]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[3]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[4]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[5]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[6]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[7]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[8]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[9]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[10]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[11]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[12]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[13]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[14]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[15]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[16]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[17]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[18]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[19]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[20]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[21]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[22]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[23]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[24]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[25]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[26]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[27]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[28]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[29]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[30]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data[31]} -radix hexadecimal}} -expand -subitemconfig {{/tb_core/dut/u_regfile/reg_data[1]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[2]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[3]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[4]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[5]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[6]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[7]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[8]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[9]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[10]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[11]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[12]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[13]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[14]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[15]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[16]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[17]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[18]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[19]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[20]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[21]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[22]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[23]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[24]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[25]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[26]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[27]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[28]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[29]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[30]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data[31]} {-height 16 -radix hexadecimal}} /tb_core/dut/u_regfile/reg_data
add wave -noupdate -group reg -radix hexadecimal -childformat {{{/tb_core/dut/u_regfile/reg_data_out[0]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[1]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[2]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[3]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[4]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[5]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[6]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[7]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[8]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[9]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[10]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[11]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[12]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[13]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[14]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[15]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[16]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[17]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[18]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[19]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[20]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[21]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[22]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[23]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[24]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[25]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[26]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[27]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[28]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[29]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[30]} -radix hexadecimal} {{/tb_core/dut/u_regfile/reg_data_out[31]} -radix hexadecimal}} -subitemconfig {{/tb_core/dut/u_regfile/reg_data_out[0]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[1]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[2]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[3]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[4]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[5]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[6]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[7]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[8]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[9]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[10]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[11]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[12]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[13]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[14]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[15]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[16]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[17]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[18]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[19]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[20]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[21]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[22]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[23]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[24]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[25]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[26]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[27]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[28]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[29]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[30]} {-height 16 -radix hexadecimal} {/tb_core/dut/u_regfile/reg_data_out[31]} {-height 16 -radix hexadecimal}} /tb_core/dut/u_regfile/reg_data_out
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/HART_ID
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/ir
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_in
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_out
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_rd
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/trap_addr
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/trap_taken
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/dmem_ld_ma
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/dmem_st_ma
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/dmem_addr
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/flush_pd
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/flush_id
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/flush_ex
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/flush_mem
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pc_if
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pc_pd
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pc_id
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pc_ex
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pc_mem
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/instret
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/stall
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/rst_n
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/clk
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_addr
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/privilege_level
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/ecall
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/ebreak
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_wr
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_rw
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_rwi
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_rs
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_rsi
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_rc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_rci
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_op
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/rd
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/wr
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_addr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_wr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pr_invalid
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/rd_valid
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/wr_valid
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/tcause
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/tcause_pc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/tval
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/m_trap
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/s_trap
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/trap
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/mret
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/sret
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/tret
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/ncsr
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_misa
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mvendorid
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_marchid
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mimpid
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mhartid
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mstatus
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mtvec
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_medeleg
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mideleg
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mie
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mip
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mcycle
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_minstret
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mscratch
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mepc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mcause
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mtval
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mconfigptr
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_menvcfg
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mseccfg
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpcfg0
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr0
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_sstatus
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_stvec
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_sie
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_sip
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_sscratch
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_sepc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_scause
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_stval
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_satp
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/flush
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/exc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/dmem_ma
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/stvec_offs
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/mtvec_offs
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/ir_if
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/ir_id
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/ir_ex
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/ir_mem
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/ir_wb
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_if
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_pd
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_id
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_ex
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_mem
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_wb
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_imem
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_dmem
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/fence_i
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/amo_req
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/amo_ack
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/s_mx_a_fw
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/a_fw
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/s_mx_b_fw
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/b_fw
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/rst_n
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/clk
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_all
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/rs1_pc
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/rs2_imm
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/rs1
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/rs2
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/rd_ex
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/rd_mem
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/rd_wb
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/wr_ex
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/wr_mem
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/wr_wb
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/dh_ex
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/dh_mem
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/dh_wb
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/a_fw_ex
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/a_fw_mem
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/a_fw_wb
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/b_fw_ex
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/b_fw_mem
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/b_fw_wb
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/fw
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_c
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/stall_d
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/dh
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/i_fence
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/i_fence_d
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/i_fence_re
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/fence_cnt
add wave -noupdate -group cu -radix hexadecimal /tb_core/dut/u_cu/fence_cnt_ena
add wave -noupdate /tb_core/env.t
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 262
configure wave -valuecolwidth 158
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {21774355 ps}
