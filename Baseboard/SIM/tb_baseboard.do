vdel -all -lib work
vlib work

vlog  -work work tb_baseboard.v
vlog  -work work wb_master.v
vlog  -work work i2c_master_wb_top.v
vlog  -work work i2c_master_bit_ctrl.v
vlog  -work work i2c_master_byte_ctrl.v
vlog  -work work i2c_master_defines.v
vlog  -work work i2c_master_registers.v
vlog  -work work DELAY.v
vlog  -work work ../SRC/baseboard_define.v
vlog  -work work ../SRC/BB_TOP.v
vlog  -work work ../SRC/I2C.v
vlog  -work work ../SRC/GPI.v
vlog  -work work ../SRC/GPO.v
vlog  -work work ../SRC/LED.v
vlog  -work work ../SRC/LED_CNT.v
vlog  -work work ../SRC/PCIE_RST_CTRL.v
vlog  -work work ../SRC/PRSNT_LED_CTRL.v
vlog  -work work ../SRC/BB_SGPIO.v
#Status CPLD
vlog  -work work ../../status/SRC/TOP.v
#vlog  -work work ../../status/SRC/I2C.v
vlog  -work work ../../status/SRC/HEADER.v
vlog  -work work ../../status/SRC/GPIO.v
#vlog  -work work ../../status/SRC/LED.v
#vlog  -work work ../../status/SRC/LED_CNT.v
vlog  -work work ../../status/SRC/SGPIO.v


#Load the design. Use required libraries.#
#vsim -t ns -novopt +notimingchecks work.tb_baseboard
vsim -t ns -novopt -voptargs="+acc" -lib work work.tb_baseboard
#Log all the objects in design. These will appear in .wlf file#
#log -r /*

do {baseboard_wave.do}
run -all
