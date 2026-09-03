build_model -designsource test_scripts/counter.test_netlist.v -techlib ./slow.v -designtop counter
build_testmode -testmode FULLSCAN -assignfile test_scripts/counter.FULLSCAN.pinassign
verify_test_structures -testmode FULLSCAN
report_test_structures -testmode FULLSCAN
build_faultmodel -fullfault yes
create_scanchain_tests -testmode FULLSCAN -experiment scan
create_logic_tests -testmode FULLSCAN -experiment logic
write_vectors -testmode FULLSCAN -inexperiment logic -language verilog -scanformat serial -outputfilename test_results
gui_open
