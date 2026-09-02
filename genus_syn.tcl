set_db use_scan_seqs_for_non_dft false
set LOCAL_LIB    "/home/cadence/install_RB_8.7/FOUNDRY/scl180"

set_db init_lib_search_path "$LOCAL_LIB/scl180/stdcell/fs120/4M1IL/liberty/lib_flow_ff $LOCAL_LIB/scl180/stdcell/fs120/4M1IL/liberty/lib_flow_ss"

set_db init_hdl_search_path .

read_libs {tsl18fs120_scl_ff.lib tsl18fs120_scl_ss.lib}

read_hdl "comparator_block.v mux.v alu.v ha.v reg_block.v arith_block.v fa.v logic_block.v shifter_block.v"

elaborate alu
check_design -all

read_sdc ./constraints.sdc


set_db hdl_track_filename_row_col true

set_db auto_ungroup none


#set_db lp_insert_clock_gating true
#or
#set_db / .lp_insert_clock_gating true 
#set_db tns_opto true 

## Power root attributes
#set_db / .lp_clock_gating_prefix <string>
#set_db / .lp_power_analysis_effort high 
#set_db / .lp_power_unit mW 
#set_db / .lp_toggle_rate_unit /ns 
## The attribute has been set to default value "medium"
## you can try setting it to high to explore MVT QoR for low power optimization
#set_db / .leakage_power_effort medium 

set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

syn_generic
syn_map
syn_opt

#reports
report_timing > ./report_timing.rpt
report_power  > ./report_power.rpt
report_area   > ./report_area.rpt
report_qor    > ./report_qor.rpt
report_gates  > ./gates.rpt

#Outputs
write_hdl > ./alu_netlist.v
write_sdc > ./alu_sdc.sdc

write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge  -setuphold split > alu.sdf
write_do_lec -revised_design ./alu_netlist.v > dofile
