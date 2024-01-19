onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_dmem/addr
add wave -noupdate -radix hexadecimal /tb_dmem/len
add wave -noupdate -radix hexadecimal /tb_dmem/data_in
add wave -noupdate -radix hexadecimal /tb_dmem/wr
add wave -noupdate -radix hexadecimal /tb_dmem/data_out
add wave -noupdate -radix hexadecimal /tb_dmem/rd
add wave -noupdate -radix hexadecimal /tb_dmem/ld_ma
add wave -noupdate -radix hexadecimal /tb_dmem/st_ma
add wave -noupdate -radix hexadecimal /tb_dmem/b_addr_d
add wave -noupdate -radix hexadecimal /tb_dmem/b_data_in_d
add wave -noupdate -radix hexadecimal /tb_dmem/b_rd_d
add wave -noupdate -radix hexadecimal /tb_dmem/b_dv_d
add wave -noupdate -radix hexadecimal /tb_dmem/inv_addr
add wave -noupdate -radix hexadecimal /tb_dmem/inv
add wave -noupdate -radix hexadecimal /tb_dmem/stall_dmem
add wave -noupdate -radix hexadecimal /tb_dmem/rst_n
add wave -noupdate -radix hexadecimal /tb_dmem/clk
add wave -noupdate -radix hexadecimal /tb_dmem/dut/addr_tag
add wave -noupdate -radix hexadecimal /tb_dmem/dut/addr_set
add wave -noupdate -radix hexadecimal /tb_dmem/dut/addr_offs
add wave -noupdate -radix hexadecimal -childformat {{{/tb_dmem/dut/data[0]} -radix hexadecimal} {{/tb_dmem/dut/data[1]} -radix hexadecimal} {{/tb_dmem/dut/data[2]} -radix hexadecimal} {{/tb_dmem/dut/data[3]} -radix hexadecimal}} -subitemconfig {{/tb_dmem/dut/data[0]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/data[1]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/data[2]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/data[3]} {-height 16 -radix hexadecimal}} /tb_dmem/dut/data
add wave -noupdate -radix hexadecimal -childformat {{{/tb_dmem/dut/tag[0]} -radix hexadecimal} {{/tb_dmem/dut/tag[1]} -radix hexadecimal} {{/tb_dmem/dut/tag[2]} -radix hexadecimal} {{/tb_dmem/dut/tag[3]} -radix hexadecimal}} -subitemconfig {{/tb_dmem/dut/tag[0]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/tag[1]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/tag[2]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/tag[3]} {-height 16 -radix hexadecimal}} /tb_dmem/dut/tag
add wave -noupdate -radix hexadecimal -childformat {{{/tb_dmem/dut/v[0]} -radix hexadecimal} {{/tb_dmem/dut/v[1]} -radix hexadecimal} {{/tb_dmem/dut/v[2]} -radix hexadecimal} {{/tb_dmem/dut/v[3]} -radix hexadecimal}} -expand -subitemconfig {{/tb_dmem/dut/v[0]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/v[1]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/v[2]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/v[3]} {-height 16 -radix hexadecimal}} /tb_dmem/dut/v
add wave -noupdate -radix hexadecimal /tb_dmem/dut/re
add wave -noupdate -radix hexadecimal /tb_dmem/dut/hit
add wave -noupdate -radix hexadecimal /tb_dmem/dut/tag_d
add wave -noupdate -radix hexadecimal /tb_dmem/dut/set_d
add wave -noupdate -radix hexadecimal /tb_dmem/dut/way_d
add wave -noupdate -radix hexadecimal /tb_dmem/dut/d
add wave -noupdate -radix hexadecimal /tb_dmem/dut/wre
add wave -noupdate -radix hexadecimal /tb_dmem/dut/tag_q
add wave -noupdate -radix hexadecimal /tb_dmem/dut/set_q
add wave -noupdate -radix hexadecimal /tb_dmem/dut/way_q
add wave -noupdate -radix hexadecimal /tb_dmem/dut/q
add wave -noupdate -radix hexadecimal /tb_dmem/dut/rde
add wave -noupdate -radix hexadecimal /tb_dmem/dut/wb_tag
add wave -noupdate -radix hexadecimal /tb_dmem/dut/wb_set
add wave -noupdate -radix hexadecimal /tb_dmem/dut/wb_data
add wave -noupdate -radix hexadecimal /tb_dmem/dut/wb_len
add wave -noupdate -radix hexadecimal /tb_dmem/dut/wr_pend
add wave -noupdate -radix hexadecimal /tb_dmem/dut/rb_tag
add wave -noupdate -radix hexadecimal /tb_dmem/dut/rb_set
add wave -noupdate -radix hexadecimal /tb_dmem/dut/rb_v
add wave -noupdate -radix hexadecimal /tb_dmem/dut/rb_hit
add wave -noupdate -radix hexadecimal /tb_dmem/dut/dmem_fsm_state
add wave -noupdate -radix hexadecimal /tb_dmem/dut/dmem_fsm_state_next
add wave -noupdate -radix hexadecimal /tb_dmem/dut/ld_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {10251754 ps}
