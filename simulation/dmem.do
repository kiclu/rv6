onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_dmem/addr
add wave -noupdate -radix hexadecimal /tb_dmem/len
add wave -noupdate -radix hexadecimal /tb_dmem/rd
add wave -noupdate -radix hexadecimal /tb_dmem/wr
add wave -noupdate -radix hexadecimal /tb_dmem/data_in
add wave -noupdate -radix hexadecimal /tb_dmem/data_out
add wave -noupdate -expand -group bus -radix hexadecimal /tb_dmem/b_addr
add wave -noupdate -expand -group bus -radix hexadecimal /tb_dmem/b_data_in
add wave -noupdate -expand -group bus -radix hexadecimal /tb_dmem/b_rd
add wave -noupdate -expand -group bus -radix hexadecimal /tb_dmem/b_dv
add wave -noupdate -expand -group bus -radix hexadecimal /tb_dmem/b_wr
add wave -noupdate -expand -group bus -radix hexadecimal /tb_dmem/b_data_out
add wave -noupdate -radix hexadecimal /tb_dmem/clr_n
add wave -noupdate -radix hexadecimal /tb_dmem/clk
add wave -noupdate -group ram {/tb_dmem/ram[0]}
add wave -noupdate -group ram {/tb_dmem/ram[1]}
add wave -noupdate -group ram {/tb_dmem/ram[2]}
add wave -noupdate -group ram {/tb_dmem/ram[3]}
add wave -noupdate -group ram {/tb_dmem/ram[4]}
add wave -noupdate -group ram {/tb_dmem/ram[5]}
add wave -noupdate -group ram {/tb_dmem/ram[6]}
add wave -noupdate -group ram {/tb_dmem/ram[7]}
add wave -noupdate -group ram {/tb_dmem/ram[8]}
add wave -noupdate -group ram {/tb_dmem/ram[9]}
add wave -noupdate -group ram {/tb_dmem/ram[10]}
add wave -noupdate -group ram {/tb_dmem/ram[11]}
add wave -noupdate -group ram {/tb_dmem/ram[12]}
add wave -noupdate -group ram {/tb_dmem/ram[13]}
add wave -noupdate -group ram {/tb_dmem/ram[14]}
add wave -noupdate -group ram {/tb_dmem/ram[15]}
add wave -noupdate -group ram {/tb_dmem/ram[16]}
add wave -noupdate -group ram {/tb_dmem/ram[17]}
add wave -noupdate -group ram {/tb_dmem/ram[18]}
add wave -noupdate -group ram {/tb_dmem/ram[19]}
add wave -noupdate -group ram {/tb_dmem/ram[20]}
add wave -noupdate -group ram {/tb_dmem/ram[21]}
add wave -noupdate -group ram {/tb_dmem/ram[22]}
add wave -noupdate -group ram {/tb_dmem/ram[23]}
add wave -noupdate -group ram {/tb_dmem/ram[24]}
add wave -noupdate -group ram {/tb_dmem/ram[25]}
add wave -noupdate -group ram {/tb_dmem/ram[26]}
add wave -noupdate -group ram {/tb_dmem/ram[27]}
add wave -noupdate -group ram {/tb_dmem/ram[28]}
add wave -noupdate -group ram {/tb_dmem/ram[29]}
add wave -noupdate -group ram {/tb_dmem/ram[30]}
add wave -noupdate -group ram {/tb_dmem/ram[31]}
add wave -noupdate -radix hexadecimal -childformat {{{/tb_dmem/dut/data[0]} -radix hexadecimal -childformat {{{/tb_dmem/dut/data[0][0]} -radix hexadecimal} {{/tb_dmem/dut/data[0][1]} -radix hexadecimal}}} {{/tb_dmem/dut/data[1]} -radix hexadecimal -childformat {{{/tb_dmem/dut/data[1][0]} -radix hexadecimal} {{/tb_dmem/dut/data[1][1]} -radix hexadecimal}}}} -subitemconfig {{/tb_dmem/dut/data[0]} {-height 16 -radix hexadecimal -childformat {{{/tb_dmem/dut/data[0][0]} -radix hexadecimal} {{/tb_dmem/dut/data[0][1]} -radix hexadecimal}}} {/tb_dmem/dut/data[0][0]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/data[0][1]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/data[1]} {-height 16 -radix hexadecimal -childformat {{{/tb_dmem/dut/data[1][0]} -radix hexadecimal} {{/tb_dmem/dut/data[1][1]} -radix hexadecimal}}} {/tb_dmem/dut/data[1][0]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/data[1][1]} {-height 16 -radix hexadecimal}} /tb_dmem/dut/data
add wave -noupdate /tb_dmem/dut/hit
add wave -noupdate -radix hexadecimal -childformat {{{/tb_dmem/dut/tag[0]} -radix hexadecimal -childformat {{{/tb_dmem/dut/tag[0][0]} -radix hexadecimal} {{/tb_dmem/dut/tag[0][1]} -radix hexadecimal}}} {{/tb_dmem/dut/tag[1]} -radix hexadecimal -childformat {{{/tb_dmem/dut/tag[1][0]} -radix hexadecimal} {{/tb_dmem/dut/tag[1][1]} -radix hexadecimal}}}} -subitemconfig {{/tb_dmem/dut/tag[0]} {-height 16 -radix hexadecimal -childformat {{{/tb_dmem/dut/tag[0][0]} -radix hexadecimal} {{/tb_dmem/dut/tag[0][1]} -radix hexadecimal}} -expand} {/tb_dmem/dut/tag[0][0]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/tag[0][1]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/tag[1]} {-height 16 -radix hexadecimal -childformat {{{/tb_dmem/dut/tag[1][0]} -radix hexadecimal} {{/tb_dmem/dut/tag[1][1]} -radix hexadecimal}} -expand} {/tb_dmem/dut/tag[1][0]} {-height 16 -radix hexadecimal} {/tb_dmem/dut/tag[1][1]} {-height 16 -radix hexadecimal}} /tb_dmem/dut/tag
add wave -noupdate -radix hexadecimal /tb_dmem/dut/addr_tag
add wave -noupdate -radix hexadecimal /tb_dmem/dut/addr_set
add wave -noupdate -radix hexadecimal /tb_dmem/dut/addr_offs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {80000 ps} 0} {{Cursor 2} {160000 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 206
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
WaveRestoreZoom {0 ps} {890618 ps}
