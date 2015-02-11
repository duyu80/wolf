vdel -all -lib work
vlib work

vlog  -work work tb_status.v
vlog  -work work wb_master.v
vlog  -work work i2c_master_wb_top.v
vlog  -work work i2c_master_bit_ctrl.v
vlog  -work work i2c_master_byte_ctrl.v
vlog  -work work i2c_master_defines.v
vlog  -work work i2c_master_registers.v
vlog  -work work DELAY.v
vlog  -work work ../SRC/TOP.v
vlog  -work work ../SRC/I2C.v
vlog  -work work ../SRC/HEADER.v
vlog  -work work ../SRC/GPIO.v
vlog  -work work ../SRC/LED.v
vlog  -work work ../SRC/LED_CNT.v
vlog  -work work ../SRC/SGPIO.v


#Load the design. Use required libraries.#
#vsim -t ns -novopt +notimingchecks work.status_tb
vsim -t ns -novopt -voptargs="+acc" -lib work work.tb_status
#Log all the objects in design. These will appear in .wlf file#
#log -r /*

do {status_wave.do}
run -all
