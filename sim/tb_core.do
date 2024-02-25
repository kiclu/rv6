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
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/rs1_data
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/rs1
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/rs2_data
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/rs2
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/rd_data
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/rd
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/we
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/rst_n
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/clk
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/reg_data
add wave -noupdate -group regfile -radix hexadecimal /tb_core/dut/u_regfile/reg_data_out
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/priv
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ir
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_val
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_ii_ex
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_ii_csr
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_pmp_iaf
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_pmp_laf
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_pmp_saf
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_dmem_lma
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/exc_dmem_sma
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/dmem_addr
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/flush_pd
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/flush_id
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/flush_ex
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/flush_mem
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_if
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_pd
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_id
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_ex
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_mem
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/stall_wb
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/rst_n
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/clk
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ecall
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ebreak
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/if_exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/if_exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/if_exc_val
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/pd_exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/pd_exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/pc_exc_val
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/id_exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/id_exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/id_exc_val
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ex_exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ex_exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/ex_exc_val
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/mem_exc
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/mem_exc_cause
add wave -noupdate -group exc -radix hexadecimal /tb_core/dut/u_exc/mem_exc_val
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/HART_ID
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/priv
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/ir
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_in
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_out
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_rd
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_ii
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/t_addr
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/t_taken
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/t_flush
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/irq_me
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/irq_mt
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/irq_ms
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/irq_se
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/irq_st
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/irq_ss
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/exc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/exc_cause
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/exc_val
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpcfg0
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpcfg2
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr0
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr1
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr2
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr3
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr4
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr5
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr6
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr7
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr8
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr9
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr10
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr11
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr12
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr13
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr14
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/pmpaddr15
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/instret
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/stall
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/rst_n
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/clk
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_addr
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
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/mcountinhibit_cy
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_minstret
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/mcountinhibit_ir
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mcounteren
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mcountinhibit
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mscratch
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mepc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mcause
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mtval
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mconfigptr
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_menvcfg
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mseccfg
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpcfg0
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpcfg2
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr0
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr1
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr2
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr3
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr4
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr5
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr6
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr7
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr8
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr9
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr10
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr11
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr12
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr13
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr14
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_pmpaddr15
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_tselect
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_tdata1
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_tdata2
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_tdata3
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_mcontext
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_sstatus
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_stvec
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_sie
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_sip
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_scounteren
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_sscratch
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_sepc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_scause
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_stval
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_satp
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_cycle
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_cycle_access_exc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_time
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_time_access_exc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_instret
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/csr_instret_access_exc
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/stvec_offs
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/mtvec_offs
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/wp_mask
add wave -noupdate -group csr -radix hexadecimal /tb_core/dut/u_csr/ri_mask
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
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/rst_n
add wave -noupdate -group pmp -radix hexadecimal /tb_core/dut/u_pmp/clk
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
add wave -noupdate -expand -group dut.pipeline -color Gold -label pd -radix hexadecimal {/tb_core/env.t.pipeline[1]}
add wave -noupdate -expand -group dut.pipeline -color Gold -label id -radix hexadecimal {/tb_core/env.t.pipeline[2]}
add wave -noupdate -expand -group dut.pipeline -color Gold -label ex -radix hexadecimal {/tb_core/env.t.pipeline[3]}
add wave -noupdate -expand -group dut.pipeline -color Gold -label mem -radix hexadecimal {/tb_core/env.t.pipeline[4]}
add wave -noupdate -expand -group dut.pipeline -color Gold -label wb -radix hexadecimal {/tb_core/env.t.pipeline[5]}
add wave -noupdate /tb_core/env
add wave -noupdate -group ir -label if -radix hexadecimal /tb_core/dut/ir
add wave -noupdate -group ir -label pd -radix hexadecimal /tb_core/dut/bfp_ir
add wave -noupdate -group ir -label id -radix hexadecimal /tb_core/dut/bpd_ir
add wave -noupdate -group ir -label ex -radix hexadecimal /tb_core/dut/bdx_ir
add wave -noupdate -group ir -label mem -radix hexadecimal /tb_core/dut/bxm_ir
add wave -noupdate -group ir -label wb -radix hexadecimal /tb_core/dut/bmw_ir
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {8060000 ps} 1} {{Cursor 3} {8080000 ps} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {6843476 ps} {7387 ns}
