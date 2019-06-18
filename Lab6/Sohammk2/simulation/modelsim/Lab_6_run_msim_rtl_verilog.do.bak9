transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/ALU.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/tristate.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/test_memory.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/SLC3_2.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/Mem2IO.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/ISDU.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/datapath.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/registers.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/muxes.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/HexDriver.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/slc3.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/memory_contents.sv}
vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/lab6_toplevel.sv}

vlog -sv -work work +incdir+U:/Desktop/lab6/Sohammk2 {U:/Desktop/lab6/Sohammk2/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 2000 ns
