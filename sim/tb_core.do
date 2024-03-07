onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_core/c_addr
add wave -noupdate -radix hexadecimal /tb_core/c_ext
add wave -noupdate -radix hexadecimal /tb_core/c_rdata
add wave -noupdate -radix hexadecimal /tb_core/c_rd
add wave -noupdate -radix hexadecimal /tb_core/c_dv
add wave -noupdate -radix hexadecimal /tb_core/c_wdata
add wave -noupdate -radix hexadecimal /tb_core/c_len
add wave -noupdate -radix hexadecimal /tb_core/c_wr
add wave -noupdate -radix hexadecimal /tb_core/c_irq_me
add wave -noupdate -radix hexadecimal /tb_core/c_irq_mt
add wave -noupdate -radix hexadecimal /tb_core/c_irq_ms
add wave -noupdate -radix hexadecimal /tb_core/c_irq_se
add wave -noupdate -radix hexadecimal /tb_core/c_irq_st
add wave -noupdate -radix hexadecimal /tb_core/c_irq_ss
add wave -noupdate -radix hexadecimal /tb_core/c_inv_addr
add wave -noupdate -radix hexadecimal /tb_core/c_inv
add wave -noupdate -radix hexadecimal /tb_core/c_amo_req
add wave -noupdate -radix hexadecimal /tb_core/c_amo_ack
add wave -noupdate -radix hexadecimal /tb_core/c_stall
add wave -noupdate -radix hexadecimal /tb_core/c_rst_n
add wave -noupdate -radix hexadecimal /tb_core/c_clk
add wave -noupdate -color Salmon -radix hexadecimal /tb_core/dut/pc
add wave -noupdate -color Salmon -radix hexadecimal /tb_core/dut/ir
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/b_addr_w_p
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/b_wr_w_p
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/b_addr_i_p
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/b_rd_i_p
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/b_addr_d_p
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/b_rd_d_p
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/priv
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpcfg0
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpcfg2
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr0
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr1
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr2
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr3
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr4
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr5
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr6
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr7
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr8
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr9
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr10
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr11
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr12
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr13
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr14
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr15
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/exc_pmp_iaf
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/exc_pmp_laf
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/exc_pmp_saf
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpcfg
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmpaddr
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/access_i
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/access_d
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/access_w
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/napot_mask
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmp_iaf_oob
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmp_laf_oob
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/pmp_saf_oob
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/b_addr_w
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/b_addr_i
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/b_addr_d
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/priv
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ir
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_val
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_ii_if
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_ii_csr
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_pmp_iaf
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_pmp_laf
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_pmp_saf
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_dmem_lma
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_dmem_sma
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/dmem_addr
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/flush_pd
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/flush_id
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/t_flush
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_if
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_pd
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_id
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_ex
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_mem
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_wb
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ecall
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ebreak
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/if_exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/if_exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/if_exc_val
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/pd_exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/pd_exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/pd_exc_val
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/id_exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/id_exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/id_exc_val
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ex_exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ex_exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ex_exc_val
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/mem_exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/mem_exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/mem_exc_val
add wave -noupdate -expand -group pipeline -color Gold -label pd -radix hexadecimal {/tb_core/env.t.pipeline[1]}
add wave -noupdate -expand -group pipeline -color Gold -label id -radix hexadecimal {/tb_core/env.t.pipeline[2]}
add wave -noupdate -expand -group pipeline -color Gold -label ex -radix hexadecimal {/tb_core/env.t.pipeline[3]}
add wave -noupdate -expand -group pipeline -color Gold -label mem -radix hexadecimal {/tb_core/env.t.pipeline[4]}
add wave -noupdate -expand -group pipeline -color Gold -label wb -radix hexadecimal {/tb_core/env.t.pipeline[5]}
add wave -noupdate -color {Slate Blue} /tb_core/env
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8800000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 127
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
WaveRestoreZoom {5855569 ps} {7386997 ps}
