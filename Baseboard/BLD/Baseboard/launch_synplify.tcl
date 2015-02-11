#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file F:/project/wolf/Baseboard/BLD/Baseboard/launch_synplify.tcl
#-- Written on Fri Oct  3 00:05:52 2014

project -close
set filename "F:/project/wolf/Baseboard/BLD/Baseboard/Baseboard_syn.prj"
if ([file exists "$filename"]) {
	project -load "$filename"
	project_file -remove *
} else {
	project -new "$filename"
}
set create_new 0

#device options
set_option -technology MACHXO2
set_option -part LCMXO2_7000HC
set_option -package FG484C
set_option -speed_grade -4

if {$create_new == 1} {
#-- add synthesis options
	set_option -symbolic_fsm_compiler true
	set_option -resource_sharing true
	set_option -vlog_std v2001
	set_option -frequency auto
	set_option -maxfan 1000
	set_option -auto_constrain_io 0
	set_option -disable_io_insertion false
	set_option -retiming false; set_option -pipe true
	set_option -force_gsr false
	set_option -compiler_compatible 0
	set_option -dup false
	set_option -frequency 1
	set_option -default_enum_encoding default
	
	
	
	set_option -write_apr_constraint 1
	set_option -fix_gated_and_generated_clocks 1
	set_option -update_models_cp 0
	set_option -resolve_multiple_driver 0
	
	
}
#-- add_file options
set_option -include_path "F:/project/wolf/Baseboard/BLD"
add_file -verilog "F:/project/wolf/Baseboard/BLD/../SRC/baseboard_define.v"
add_file -verilog "F:/project/wolf/Baseboard/BLD/../SRC/BB_SGPIO.v"
add_file -verilog "F:/project/wolf/Baseboard/BLD/../SRC/BB_TOP.v"
add_file -verilog "F:/project/wolf/Baseboard/BLD/../SRC/GPI.v"
add_file -verilog "F:/project/wolf/Baseboard/BLD/../SRC/GPO.v"
add_file -verilog "F:/project/wolf/Baseboard/BLD/../SRC/I2C.v"
add_file -verilog "F:/project/wolf/Baseboard/BLD/../SRC/LED.v"
add_file -verilog "F:/project/wolf/Baseboard/BLD/../SRC/LED_CNT.v"
add_file -verilog "F:/project/wolf/Baseboard/BLD/../SRC/PCIE_RST_CTRL.v"
add_file -verilog "F:/project/wolf/Baseboard/BLD/../SRC/PRSNT_LED_CTRL.v"
project -result_file {F:/project/wolf/Baseboard/BLD/Baseboard/Baseboard.edi}
project -save "$filename"
