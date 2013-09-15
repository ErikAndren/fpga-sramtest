create_clock -period 20.000 -name RootClk RootClk
derive_pll_clocks
derive_clock_uncertainty

set_false_path -from [get_ports ARst_N]
set_false_path -from [get_ports Btn0]
set_false_path -from [get_ports Btn1]
set_false_path -from [get_ports Btn2]
set_false_path -from [get_ports Btn3]

set_output_delay -clock RootClk -max 8 [all_outputs]
set_output_delay -clock RootClk -min 8 [all_outputs] 
