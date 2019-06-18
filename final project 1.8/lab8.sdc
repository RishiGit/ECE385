#**************************************************************
# This .sbc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

set_time_format -unit ns -decimal_places 3

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period 20 [get_ports CLOCK_50]

create_clock -period "27 MHZ" [get_ports AUDIO_CLK]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks
create_generated_clock -name {m_final_soc|sdram_pll|sd1|pll7|clk[0]} -source [get_pins {m_final_soc|sdram_pll|sd1|pll7|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -phase -54.000 -master_clock {CLOCK_50} [get_pins {m_final_soc|sdram_pll|sd1|pll7|clk[0]}] 
create_generated_clock -name {m_final_soc|sdram_pll|sd1|pll7|clk[1]} -source [get_pins {m_final_soc|sdram_pll|sd1|pll7|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -phase -54.000 -master_clock {CLOCK_50} [get_pins {m_final_soc|sdram_pll|sd1|pll7|clk[1]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[0]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[0]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[1]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[1]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[2]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[2]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[3]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[3]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[4]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[4]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[5]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[5]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[6]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[6]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[7]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[7]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[8]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[8]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[9]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[9]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[10]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[10]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[11]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[11]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[12]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[12]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[13]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[13]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[14]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[14]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[15]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[15]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[16]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[16]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[17]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[17]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[18]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[18]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[19]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[19]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[20]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[20]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[21]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[21]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[22]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[22]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[23]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[23]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[24]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[24]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[25]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[25]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[26]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[26]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[27]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[27]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[28]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[28]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[29]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[29]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[30]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[30]}]
set_input_delay -add_delay -max -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[31]}]
set_input_delay -add_delay -min -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[31]}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {KEY[0]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {KEY[0]}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {KEY[1]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {KEY[1]}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {KEY[2]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {KEY[2]}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {KEY[3]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {KEY[3]}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[0]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[0]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[1]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[1]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[2]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[2]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[3]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[3]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[4]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[4]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[5]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[5]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[6]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[6]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[7]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[7]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[8]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[8]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[9]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[9]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[10]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[10]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[11]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[11]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[12]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[12]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[13]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[13]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[14]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[14]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[15]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[15]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[16]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[16]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {S[17]}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {S[17]}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {OTG_INT}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {OTG_INT}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {altera_reserved_tck}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {altera_reserved_tck}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {altera_reserved_tdi}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {altera_reserved_tdi}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {altera_reserved_tms}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {altera_reserved_tms}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[0]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[1]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[2]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[3]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[4]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[5]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[6]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[7]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[8]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[9]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[10]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[11]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[12]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_BA[0]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_BA[1]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_CAS_N}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_CKE}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_CS_N}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQM[0]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQM[1]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQM[2]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQM[3]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[0]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[1]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[2]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[3]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[4]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[5]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[6]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[7]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[8]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[9]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[10]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[11]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[12]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[13]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[14]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[15]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[16]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[17]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[18]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[19]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[20]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[21]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[22]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[23]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[24]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[25]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[26]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[27]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[28]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[29]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[30]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[31]}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_RAS_N}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_WE_N}]
set_output_delay -add_delay  -clock [get_clocks {m_final_soc|sdram_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_CLK}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX0[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX0[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX0[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX0[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX0[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX0[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX0[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX0[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX1[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX1[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX1[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX1[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX1[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX1[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX1[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX1[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX2[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX2[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX2[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX2[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX2[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX2[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX2[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX2[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX3[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX3[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX3[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX3[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX3[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX3[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX3[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX3[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX4[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX4[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX4[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX4[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX4[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX4[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX4[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX4[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX5[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX5[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX5[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX5[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX5[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX5[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX5[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX5[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX6[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX6[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX6[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX6[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX6[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX6[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX6[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX6[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX7[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX7[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX7[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX7[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX7[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX7[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX7[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {HEX7[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_R[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_R[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_R[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_R[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_R[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_R[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_R[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_R[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_R[8]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_G[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_G[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_G[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_G[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_G[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_G[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_G[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_G[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_G[8]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_B[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_B[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_B[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_B[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_B[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_B[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_B[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_B[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_B[8]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_CLK}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_SYNC_N}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_BLANK_N}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_VS}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {VGA_HS}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {OTG_ADDR[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {OTG_ADDR[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {OTG_CS_N}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {OTG_RD_N}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {OTG_WR_N}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {OTG_RST_N}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {AUD_DACDAT}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {AUD_XCK}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {I2C_SCLK}]

set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {altera_reserved_tdo}]

#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}]

#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}]
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]
set_false_path -from [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_nios2_oci_break:the_final_soc_nios2_qsys_0_nios2_oci_break|break_readreg*}] -to [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_jtag_debug_module_wrapper:the_final_soc_nios2_qsys_0_jtag_debug_module_wrapper|final_soc_nios2_qsys_0_jtag_debug_module_tck:the_final_soc_nios2_qsys_0_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_nios2_oci_debug:the_final_soc_nios2_qsys_0_nios2_oci_debug|*resetlatch}] -to [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_jtag_debug_module_wrapper:the_final_soc_nios2_qsys_0_jtag_debug_module_wrapper|final_soc_nios2_qsys_0_jtag_debug_module_tck:the_final_soc_nios2_qsys_0_jtag_debug_module_tck|*sr[33]}]
set_false_path -from [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_nios2_oci_debug:the_final_soc_nios2_qsys_0_nios2_oci_debug|monitor_ready}] -to [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_jtag_debug_module_wrapper:the_final_soc_nios2_qsys_0_jtag_debug_module_wrapper|final_soc_nios2_qsys_0_jtag_debug_module_tck:the_final_soc_nios2_qsys_0_jtag_debug_module_tck|*sr[0]}]
set_false_path -from [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_nios2_oci_debug:the_final_soc_nios2_qsys_0_nios2_oci_debug|monitor_error}] -to [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_jtag_debug_module_wrapper:the_final_soc_nios2_qsys_0_jtag_debug_module_wrapper|final_soc_nios2_qsys_0_jtag_debug_module_tck:the_final_soc_nios2_qsys_0_jtag_debug_module_tck|*sr[34]}]
set_false_path -from [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_nios2_ocimem:the_final_soc_nios2_qsys_0_nios2_ocimem|*MonDReg*}] -to [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_jtag_debug_module_wrapper:the_final_soc_nios2_qsys_0_jtag_debug_module_wrapper|final_soc_nios2_qsys_0_jtag_debug_module_tck:the_final_soc_nios2_qsys_0_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_jtag_debug_module_wrapper:the_final_soc_nios2_qsys_0_jtag_debug_module_wrapper|final_soc_nios2_qsys_0_jtag_debug_module_tck:the_final_soc_nios2_qsys_0_jtag_debug_module_tck|*sr*}] -to [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_jtag_debug_module_wrapper:the_final_soc_nios2_qsys_0_jtag_debug_module_wrapper|final_soc_nios2_qsys_0_jtag_debug_module_sysclk:the_final_soc_nios2_qsys_0_jtag_debug_module_sysclk|*jdo*}]
set_false_path -from [get_keepers {sld_hub:*|irf_reg*}] -to [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_jtag_debug_module_wrapper:the_final_soc_nios2_qsys_0_jtag_debug_module_wrapper|final_soc_nios2_qsys_0_jtag_debug_module_sysclk:the_final_soc_nios2_qsys_0_jtag_debug_module_sysclk|ir*}]
set_false_path -from [get_keepers {sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1]}] -to [get_keepers {*final_soc_nios2_qsys_0:*|final_soc_nios2_qsys_0_nios2_oci:the_final_soc_nios2_qsys_0_nios2_oci|final_soc_nios2_qsys_0_nios2_oci_debug:the_final_soc_nios2_qsys_0_nios2_oci_debug|monitor_go}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************



