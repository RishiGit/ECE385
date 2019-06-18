create_clock -name {clk} -period 20ns -waveform {0.000 5.000} [get_ports {clk}]

set_input_delay -clock {clk} -max 3 [all_inputs]
set_input_delay -clock {clk} -min 2 [all_inputs]

set_output_delay -clock {clk} 2 [all_outputs]