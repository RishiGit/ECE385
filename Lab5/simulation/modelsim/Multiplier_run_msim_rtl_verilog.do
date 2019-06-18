transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/lab5 {C:/Users/rjaud/Documents/385/lab5/ninebra.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/lab5 {C:/Users/rjaud/Documents/385/lab5/control.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/lab5 {C:/Users/rjaud/Documents/385/lab5/register.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/lab5 {C:/Users/rjaud/Documents/385/lab5/Synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/lab5 {C:/Users/rjaud/Documents/385/lab5/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/lab5 {C:/Users/rjaud/Documents/385/lab5/flip_flop.sv}
vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/lab5 {C:/Users/rjaud/Documents/385/lab5/Processor.sv}

vlog -sv -work work +incdir+C:/Users/rjaud/Documents/385/lab5 {C:/Users/rjaud/Documents/385/lab5/testbench_8.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_8

add wave *
view structure
view signals
run 10 us
