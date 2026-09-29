# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.17-s066_1 on Tue Sep 29 16:09:40 EDT 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1fF
set_units -time 1000ps

# Set the current design
current_design cascade_biquad_PIPELINE1

create_clock -name "clk" -period 2.0 -waveform {0.0 1.0} [get_ports clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports rst]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[15]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[14]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[13]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[12]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[11]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[10]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[9]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[8]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {in_sample[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[15]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[14]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[13]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[12]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[11]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[10]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.5 [get_ports {out_sample[0]}]
set_wire_load_mode "enclosed"
