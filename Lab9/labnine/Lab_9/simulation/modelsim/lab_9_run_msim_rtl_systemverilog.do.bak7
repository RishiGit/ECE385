transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9 {C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9/muxes.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9 {C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9/AES_CONTROL.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9 {C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9/SubBytes.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9 {C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9/InvShiftRows.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9 {C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9/InvMixColumns.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9 {C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9/AES.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9 {C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9/registers.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9 {C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9/KeyExpansion.sv}
vlib lab8_soc
vmap lab8_soc lab8_soc

vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9 {C:/Users/rjaud/Documents/385/Lab9/labnine/Lab_9/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L lab8_soc -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 3000 ns
