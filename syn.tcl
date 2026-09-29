set LIBPATH "$env(HOME)/Desktop/RTL/iir/pdk"

set_db init_lib_search_path $LIBPATH
set_db library {NangateOpenCellLibrary_typical.lib}

read_hdl { src/biquad.v src/cascade_biquad.v }
elaborate cascade_biquad -parameters {{PIPELINE 1}}

# ---- constraints ----
create_clock -name clk -period 2.0 [get_ports clk]
set_input_delay  0.5 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 0.5 -clock clk [all_outputs]
set_load 0.02 [all_outputs]

# ---- synthesize ----
syn_generic
syn_map
syn_opt

# ---- reports ----
exec mkdir -p rpt out
report_timing -max_paths 5  > rpt/timing.rpt
report_area                 > rpt/area.rpt
report_gates                > rpt/gates.rpt
report_power                > rpt/power.rpt

write_hdl                   > out/netlist.v
write_sdc                   > out/constraints.sdc

report_timing -max_paths 1 > rpt/wns.rpt