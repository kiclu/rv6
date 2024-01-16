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
add wave -noupdate -group imem -radix hexadecimal /tb_core/dut/u_imem/data
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
add wave -noupdate -childformat {{/tb_core/env.t.ir_retired -radix hexadecimal} {/tb_core/env.t.fd -radix hexadecimal} {/tb_core/env.t.pipeline -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[1]} -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[1].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].e} -radix hexadecimal}}} {{/tb_core/env.t.pipeline[2]} -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[2].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].e} -radix hexadecimal}}} {{/tb_core/env.t.pipeline[3]} -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[3].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].e} -radix hexadecimal}}} {{/tb_core/env.t.pipeline[4]} -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[4].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].e} -radix hexadecimal}}} {{/tb_core/env.t.pipeline[5]} -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[5].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].e} -radix hexadecimal}}}}}} -subitemconfig {/tb_core/env.t.ir_retired {-height 16 -radix hexadecimal} /tb_core/env.t.fd {-height 16 -radix hexadecimal} /tb_core/env.t.pipeline {-height 16 -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[1]} -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[1].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].e} -radix hexadecimal}}} {{/tb_core/env.t.pipeline[2]} -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[2].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].e} -radix hexadecimal}}} {{/tb_core/env.t.pipeline[3]} -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[3].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].e} -radix hexadecimal}}} {{/tb_core/env.t.pipeline[4]} -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[4].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].e} -radix hexadecimal}}} {{/tb_core/env.t.pipeline[5]} -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[5].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].e} -radix hexadecimal}}}} -expand} {/tb_core/env.t.pipeline[1]} {-height 16 -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[1].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[1].e} -radix hexadecimal}}} {/tb_core/env.t.pipeline[1].ir} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[1].pc} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[1].hart_id} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[1].priv_lvl} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[1].e} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[2]} {-height 16 -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[2].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[2].e} -radix hexadecimal}}} {/tb_core/env.t.pipeline[2].ir} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[2].pc} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[2].hart_id} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[2].priv_lvl} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[2].e} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[3]} {-height 16 -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[3].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[3].e} -radix hexadecimal}}} {/tb_core/env.t.pipeline[3].ir} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[3].pc} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[3].hart_id} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[3].priv_lvl} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[3].e} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[4]} {-height 16 -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[4].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[4].e} -radix hexadecimal}}} {/tb_core/env.t.pipeline[4].ir} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[4].pc} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[4].hart_id} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[4].priv_lvl} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[4].e} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[5]} {-height 16 -radix hexadecimal -childformat {{{/tb_core/env.t.pipeline[5].ir} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].pc} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].hart_id} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].priv_lvl} -radix hexadecimal} {{/tb_core/env.t.pipeline[5].e} -radix hexadecimal}}} {/tb_core/env.t.pipeline[5].ir} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[5].pc} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[5].hart_id} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[5].priv_lvl} {-height 16 -radix hexadecimal} {/tb_core/env.t.pipeline[5].e} {-height 16 -radix hexadecimal}} /tb_core/env.t
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{trace log error} {31040000 ps} 1} {{Cursor 4} {31200000 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 262
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
WaveRestoreZoom {0 ps} {777015 ps}
