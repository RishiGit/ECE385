transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+F:/UPDATED\ LAB9/Lab9_Avalon_Provided_2.0 {F:/UPDATED LAB9/Lab9_Avalon_Provided_2.0/SubBytes.sv}
vlog -sv -work work +incdir+F:/UPDATED\ LAB9/Lab9_Avalon_Provided_2.0 {F:/UPDATED LAB9/Lab9_Avalon_Provided_2.0/InvShiftRows.sv}
vlog -sv -work work +incdir+F:/UPDATED\ LAB9/Lab9_Avalon_Provided_2.0 {F:/UPDATED LAB9/Lab9_Avalon_Provided_2.0/InvMixColumns.sv}
vlog -sv -work work +incdir+F:/UPDATED\ LAB9/Lab9_Avalon_Provided_2.0 {F:/UPDATED LAB9/Lab9_Avalon_Provided_2.0/AES.sv}
vlog -sv -work work +incdir+F:/UPDATED\ LAB9/Lab9_Avalon_Provided_2.0 {F:/UPDATED LAB9/Lab9_Avalon_Provided_2.0/muxes.sv}
vlog -sv -work work +incdir+F:/UPDATED\ LAB9/Lab9_Avalon_Provided_2.0 {F:/UPDATED LAB9/Lab9_Avalon_Provided_2.0/registers.sv}
vlog -sv -work work +incdir+F:/UPDATED\ LAB9/Lab9_Avalon_Provided_2.0 {F:/UPDATED LAB9/Lab9_Avalon_Provided_2.0/AES_CONTROL.sv}
vlog -sv -work work +incdir+F:/UPDATED\ LAB9/Lab9_Avalon_Provided_2.0 {F:/UPDATED LAB9/Lab9_Avalon_Provided_2.0/KeyExpansion.sv}

vlog -sv -work work +incdir+F:/UPDATED\ LAB9/Lab9_Avalon_Provided_2.0 {F:/UPDATED LAB9/Lab9_Avalon_Provided_2.0/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 3000 ns