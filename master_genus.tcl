# ============================================================
# MASTER GENUS SYNTHESIS SCRIPT
# ============================================================
# For use with Cadence Genus
#
# For a new design, normally update ONLY:
#   1. RTL_PATH
#   2. LIB_PATH
#   3. DESIGN
#   4. RTL_LIST
#
# ============================================================


# ============================================================
# 1. USER CONFIGURATION
# ============================================================

# RTL source files
set RTL_PATH "../sources/"

# Standard-cell Liberty files
set LIB_PATH "../lib/"

# Design name / top-level module
set DESIGN "sha256"

# All RTL files required for the design
set RTL_LIST {
    sha256.v
    sha256_core.v
    sha256_k_constants.v
    sha256_w_mem.v
}


# ============================================================
# 2. TECHNOLOGY / PHYSICAL LIBRARY PATHS
# ============================================================
# Normally these remain unchanged if your technology setup
# is the same for all designs.

set LEF_PATH "../lef/scaled/"
set TLEF_PATH "../techlef/"
set QRC_PATH "../qrc/"

# QRC technology file
set QRC_FILE "qrcTechFile_typ03_scaled4xV06"


# ============================================================
# 3. STANDARD CELL LIBRARIES
# ============================================================
# Update these ONLY if your standard-cell library changes.

set LIB_LIST {
    asap7sc7p5t_AO_LVT_TT_nldm_211120.lib
    asap7sc7p5t_INVBUF_LVT_TT_nldm_220122.lib
    asap7sc7p5t_OA_LVT_TT_nldm_211120.lib
    asap7sc7p5t_SEQ_LVT_TT_nldm_220123.lib
    asap7sc7p5t_SIMPLE_LVT_TT_nldm_211120.lib
}


# ============================================================
# 4. LEF FILES
# ============================================================

set LEF_LIST {
    asap7_tech_4x_201209.lef
    asap7sc7p5t_28_L_4x_220121a.lef
    asap7sc7p5t_28_R_4x_220121a.lef
    asap7sc7p5t_28_SL_4x_220121a.lef
}


# ============================================================
# 5. GENUS SEARCH PATHS
# ============================================================

set_db init_lib_search_path "$LIB_PATH $LEF_PATH $TLEF_PATH"
set_db init_hdl_search_path $RTL_PATH

set_db / .library "$LIB_LIST"
set_db lef_library "$LEF_LIST"
set_db qrc_tech_file "$QRC_PATH/$QRC_FILE"


# ============================================================
# 6. SYNTHESIS EFFORT
# ============================================================

set_db syn_generic_effort high
set_db syn_map_effort high
set_db syn_opt_effort extreme


# ============================================================
# 7. POWER OPTIMIZATION
# ============================================================

set_db lp_power_analysis_effort high
set_db power_optimization_effort high
set_db design_power_effort high


# ============================================================
# 8. CLOCK GATING
# ============================================================

set_db lp_insert_clock_gating true


# ============================================================
# 9. DON'T USE CELLS
# ============================================================
# Prevent specific cells from being used during synthesis.

set_dont_use AOI22xp33_ASAP7_75t_L true
set_dont_use AOI22xp33_ASAP7_75t_SL true
set_dont_use AOI22xp33_ASAP7_75t_R true


# ============================================================
# 10. READ RTL
# ============================================================

read_hdl ${RTL_LIST}


# ============================================================
# 11. ELABORATE DESIGN
# ============================================================

elaborate $DESIGN


# ============================================================
# 12. TIMING CONSTRAINTS
# ============================================================

# Default clock period = 1 ns = 1000 ps
#
# Change this value when performing timing experiments.
#
# Examples:
#   1000 ps = 1.000 ns
#    900 ps = 0.900 ns
#    706 ps = 0.706 ns
#    500 ps = 0.500 ns

create_clock -name "clk" -period 1000 [get_ports clk]


# Input/output delays
set_input_delay  -clock clk 300 [all_inputs]
set_output_delay -clock clk 300 [all_outputs]


# ============================================================
# 13. GENERIC SYNTHESIS
# ============================================================

syn_generic


# ============================================================
# 14. TECHNOLOGY MAPPING
# ============================================================

syn_map


# ============================================================
# 15. OPTIMIZATION
# ============================================================

syn_opt


# ============================================================
# 16. WRITE SYNTHESIZED NETLIST
# ============================================================

write_hdl > $DESIGN.netlist.v


# ============================================================
# 17. REPORTS
# ============================================================

# Area
report_area


# Timing
report_timing -fields "timing_point cell delay arrival"


# Power
report_power -unit mW -format %.4f


# ============================================================
# 18. OPTIONAL REPORT FILES
# ============================================================
# Uncomment these if you want separate report files.

# report clocks > ./$DESIGN.clocks.rep
# report timing > ./$DESIGN.timing.rep
# report area   > ./$DESIGN.area.rep
# report gates  > ./$DESIGN.gates.rep
# report power  > ./$DESIGN.power.rep


# ============================================================
# END OF SYNTHESIS
# ============================================================
