#set sdc_version 2.1
reset_design

set PERIOD  5.0
set INPUT_DELAY  1.0
set OUTPUT_DELAY  1.0
set CLOCK_LATENCY 0.5
set SOURCE_LATENCY 0.5
set UNCERTAINTY 0.15
set MAX_TRANSITION 0.5
set MIN_CLOCK_LATENCY 0.1
set MIN_SOURCE_LATENCY 0.1
set MIN_IO_DELAY 0.5



## CLOCK BASICS
create_clock -name "clock" -period $PERIOD [get_ports clk]

set_clock_latency $CLOCK_LATENCY [get_clocks clock]
set_clock_latency -min $MIN_CLOCK_LATENCY [get_clocks clock]

set_clock_latency -source $SOURCE_LATENCY [get_clocks clock]
set_clock_latency -source -min $MIN_SOURCE_LATENCY [get_clocks clock]

set_clock_uncertainty -setup $UNCERTAINTY [get_clocks clock]
set_clock_uncertainty -hold $UNCERTAINTY [get_clocks clock]

set_clock_transition 0.5 [get_clocks clock]


## GROUPING


group_path  -name CLOCK\
            -to clock\
            -weight 1

group_path  -name INPUTS\
            -through [all_inputs]\
            -weight 1

group_path  -name OUTPUTS\
            -to [all_outputs]\
            -weight 1

group_path  -name COMBO\
            -from [all_inputs]\
            -to [all_outputs]\
            -weight 1

## IN/OUT
set INPUTPORTS [remove_from_collection [all_inputs] [get_ports clk]]
set OUTPUTPORTS [all_outputs]
  
set_input_delay -clock "clock" -max $INPUT_DELAY $INPUTPORTS 
set_output_delay -clock "clock" -max $OUTPUT_DELAY $OUTPUTPORTS
set_input_delay -clock "clock" -min $MIN_IO_DELAY $INPUTPORTS 
set_output_delay -clock "clock" -min $MIN_IO_DELAY $OUTPUTPORTS

## DRC
set_max_transition $MAX_TRANSITION [current_design]

set_max_fanout 50 [current_design]

set_max_capacitance 100 [current_design]

set_wire_load_model -library tsl18fs120_scl_ss -name 8000
set_wire_load_mode top

set_load 20 $OUTPUTPORTS
set_input_transition 0.1 $INPUTPORTS


