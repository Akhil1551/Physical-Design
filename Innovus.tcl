proc init_design_flow {} {
    global init_lef_file
    global init_verilog
    global init_top_cell

    # Read physical libraries
    set init_lef_file { /home/cadence/install/FOUNDRY/digital/90nm/dig/lef/gsclib090_translated.lef /home/cadence/install/FOUNDRY/digital/90nm/dig/lef/gsclib090_tech.lef}

    set init_verilog {../synthesis/alu_unit_netlist.v}
    set init_top_cell alu_unit

    # Read timing libraries / MMC setup
    # Timing libraries
    create_library_set -name slow_lib \
        -timing [list ../synthesis/slow.lib]

    create_library_set -name typical_lib \
        -timing [list ../synthesis/typical.lib]

    create_library_set -name fast_lib \
        -timing [list ../synthesis/fast.lib]

#constraint mode

    create_constraint_mode -name func_mode \
        -sdc_files [list ../synthesis/alu_unit.sdc]

#delay_corners

    create_delay_corner -name slow_corner \
        -library_set slow_lib 

    create_delay_corner -name typical_corner \
        -library_set typical_lib

    create_delay_corner -name fast_corner \
        -library_set fast_lib

#analysis views
create_analysis_view -name slow_view \
    -constraint_mode func_mode \
    -delay_corner slow_corner

create_analysis_view -name typical_view \
    -constraint_mode func_mode \
    -delay_corner typical_corner

create_analysis_view -name fast_view \
    -constraint_mode func_mode \
    -delay_corner fast_corner

#Intialize design
init_design -setup slow_view -hold fast_view

# Set active views
set_analysis_view \
    -setup {slow_view} \
    -hold {fast_view}

#basic checks
checkDesign -all


#save checkpoint
saveDesign 01_init

}

#main

init_design_flow
