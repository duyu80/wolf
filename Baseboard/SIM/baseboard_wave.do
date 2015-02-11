onerror {resume}
quietly WaveActivateNextPane {} 0
#add wave -noupdate -expand -group tb_baseboard /tb_baseboard/*
add wave -noupdate -group tb_baseboard /tb_baseboard/*
add wave -noupdate -group BB_TOP_INST /tb_baseboard/BB_TOP_INST/*
add wave -noupdate -group I2C_INS_1 /tb_baseboard/BB_TOP_INST/I2C_INS_1/*
add wave -noupdate -group I2C_INS_2 /tb_baseboard/BB_TOP_INST/I2C_INS_2/*
add wave -noupdate -group GPO2_INST /tb_baseboard/BB_TOP_INST/GPO2_INST/*
add wave -noupdate -group GPO5_INST /tb_baseboard/BB_TOP_INST/GPO5_INST/*
add wave -noupdate -group FLT_AMB_LED_INST2 /tb_baseboard/BB_TOP_INST/FLT_AMB_LED_INST2/*
add wave -noupdate -group PRSNT_LED_CTRL_INST /tb_baseboard/BB_TOP_INST/PRSNT_LED_CTRL_INST/*
add wave -noupdate -group BB_SGPIO_INST /tb_baseboard/BB_TOP_INST/BB_SGPIO_INST/*
#Status CPLD
add wave -noupdate -group STATUS_SGPIO_INST1 /tb_baseboard/STATUS_INST/SGPIO_INST1/*
add wave -noupdate -group STATUS_SGPIO_INST2 /tb_baseboard/STATUS_INST/SGPIO_INST2/*

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3457351 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 156
configure wave -valuecolwidth 98
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {5857677 ns}
