`include "../SRC/baseboard_define.v"
`include "i2c_master_defines.v"

module tb_baseboard;

reg	[7:0]		i;
reg			    clk;
reg			    rstn;
reg			    i2c_wr;
reg	[7:0]	    i2c_address;
reg	[7:0]	    i2c_wrdata1;
reg	[7:0]	    i2c_wrdata2;
reg	[7:0]	    i2c_wrdata3;
reg	[7:0]	    i2c_data_num;

wire	[2:0]	adr;
wire	[7:0]	dat_o;
wire	[7:0]	dat0_i;
wire			cyc;
wire			stb;
wire			we;
wire			ack;

wire			scl;
wire			sda;

wire	[7:0]	porta;
wire	[7:0]	portb;
wire	[15:0]	PORT_CS;
wire	[15:0]	OFFSET_SEL;    //This two signal port are used for GPIO port selection
wire	[7:0]	I2C_DOUT;    //When write through I2C, the output data will through these two port to each GPIO port
wire			RD_WR;    //1 means I2C read operation, and 0 means I2C write operation
wire	[7:0]	DIN_0;

wire			i2c_busy;
wire	[7:0]	i2c_rddata1;
wire	[7:0]	i2c_rddata2;

// Driver active led input
reg     [35:0]  DRV_ACT;
// Driver power
reg     [23:0]  DRV_POWER_OK;

// SGPIO
wire            SGPIO_CK;
wire            SGPIO_LD;
wire            SGPIO_DATA;


pullup p1(scl); // pullup scl line
pullup p2(sda); // pullup sda line

wb_master #(8, 8) u0 (
		.clk(clk),
		.rst(rstn),
		.adr(adr),
		.din(dat0_i),
		.dout(dat_o),
		.cyc(cyc),
		.stb(stb),
		.we(we),
		.sel(),
		.ack(ack),
		.err(1'b0),
		.rty(1'b0),
		.i2c_wr(i2c_wr),
		.i2c_addr(i2c_address),
		.i2c_wrdata1( i2c_wrdata1),
		.i2c_wrdata2( i2c_wrdata2),
		.i2c_wrdata3( i2c_wrdata3),
		.i2c_data_num(i2c_data_num),
		.i2c_busy(i2c_busy),
		.i2c_rddata1(i2c_rddata1),
		.i2c_rddata2(i2c_rddata2)
	);

i2c_master_wb_top u1 (

		// wishbone interface
		.wb_clk_i(clk),
		.wb_rst_i(1'b0),
		.arst_i(rstn),
		.wb_adr_i(adr[2:0]),
		.wb_dat_i(dat_o),
		.wb_dat_o(dat0_i),
		.wb_we_i(we),
		.wb_stb_i(stb),
		.wb_cyc_i(cyc),
		.wb_ack_o(ack),
		.wb_inta_o(),

		.scl(scl),
		.sda(sda)
	);


BB_TOP		BB_TOP_INST (
				.SYSCLK                         ( clk           ),
				.RESET_N                        ( rstn),
				.SCL_1			                ( scl),
				.SDA_1			                ( sda),
				.SCL_2			                ( ),
				.SDA_2			                ( ),

                .DRV0_ACT_LED                ( DRV_ACT[0] ),
                .DRV1_ACT_LED                ( DRV_ACT[1] ),
                .DRV2_ACT_LED                ( DRV_ACT[2] ),
                .DRV3_ACT_LED                ( DRV_ACT[3] ),
                .DRV4_ACT_LED                ( DRV_ACT[4] ),
                .DRV5_ACT_LED                ( DRV_ACT[5] ),
                .DRV6_ACT_LED                ( DRV_ACT[6] ),
                .DRV7_ACT_LED                ( DRV_ACT[7] ),
                .DRV8_ACT_LED                ( DRV_ACT[8] ),
                .DRV9_ACT_LED                ( DRV_ACT[9] ),
                .DRV10_ACT_LED                ( DRV_ACT[10] ),
                .DRV11_ACT_LED                ( DRV_ACT[11] ),
                .DRV12_ACT_LED                ( DRV_ACT[12] ),
                .DRV13_ACT_LED                ( DRV_ACT[13] ),
                .DRV14_ACT_LED                ( DRV_ACT[14] ),
                .DRV15_ACT_LED                ( DRV_ACT[15] ),
                .DRV16_ACT_LED                ( DRV_ACT[16] ),
                .DRV17_ACT_LED                ( DRV_ACT[17] ),
                .DRV18_ACT_LED                ( DRV_ACT[18] ),
                .DRV19_ACT_LED                ( DRV_ACT[19] ),
                .DRV20_ACT_LED                ( DRV_ACT[20] ),
                .DRV21_ACT_LED                ( DRV_ACT[21] ),
                .DRV22_ACT_LED                ( DRV_ACT[22] ),
                .DRV23_ACT_LED                ( DRV_ACT[23] ),
                .DRV24_ACT_LED                ( DRV_ACT[24] ),
                .DRV25_ACT_LED                ( DRV_ACT[25] ),
                .DRV26_ACT_LED                ( DRV_ACT[26] ),
                .DRV27_ACT_LED                ( DRV_ACT[27] ),
                .DRV28_ACT_LED                ( DRV_ACT[28] ),
                .DRV29_ACT_LED                ( DRV_ACT[29] ),
                .DRV30_ACT_LED                ( DRV_ACT[30] ),
                .DRV31_ACT_LED                ( DRV_ACT[31] ),
                .DRV32_ACT_LED                ( DRV_ACT[32] ),
                .DRV33_ACT_LED                ( DRV_ACT[33] ),
                .DRV34_ACT_LED                ( DRV_ACT[34] ),
                .DRV35_ACT_LED                ( DRV_ACT[35] ),
                .DRV12_PWROK                  ( DRV_POWER_OK[0] ),
                .DRV13_PWROK                  ( DRV_POWER_OK[1] ),
                .DRV14_PWROK                  ( DRV_POWER_OK[2] ),
                .DRV15_PWROK                  ( DRV_POWER_OK[3] ),
                .DRV16_PWROK                  ( DRV_POWER_OK[4] ),
                .DRV17_PWROK                  ( DRV_POWER_OK[5] ),
                .DRV18_PWROK                  ( DRV_POWER_OK[6] ),
                .DRV19_PWROK                  ( DRV_POWER_OK[7] ),
                .DRV20_PWROK                  ( DRV_POWER_OK[8] ),
                .DRV21_PWROK                  ( DRV_POWER_OK[9] ),
                .DRV22_PWROK                  ( DRV_POWER_OK[10] ),
                .DRV23_PWROK                  ( DRV_POWER_OK[11] ),
                .DRV24_PWROK                  ( DRV_POWER_OK[12] ),
                .DRV25_PWROK                  ( DRV_POWER_OK[13] ),
                .DRV26_PWROK                  ( DRV_POWER_OK[14] ),
                .DRV27_PWROK                  ( DRV_POWER_OK[15] ),
                .DRV28_PWROK                  ( DRV_POWER_OK[16] ),
                .DRV29_PWROK                  ( DRV_POWER_OK[17] ),
                .DRV30_PWROK                  ( DRV_POWER_OK[18] ),
                .DRV31_PWROK                  ( DRV_POWER_OK[19] ),
                .DRV32_PWROK                  ( DRV_POWER_OK[20] ),
                .DRV33_PWROK                  ( DRV_POWER_OK[21] ),
                .DRV34_PWROK                  ( DRV_POWER_OK[22] ),
                .DRV35_PWROK                  ( DRV_POWER_OK[23] ),
				
				// SGPIO
				.SGPIO_CK                       ( SGPIO_CK      ),
				.SGPIO_LD                       ( SGPIO_LD      ),
				.SGPIO_DATA                     ( SGPIO_DATA    )
				);

// Status CPLD
TOP		STATUS_INST (
				.SYSCLK                         (clk),
				.RESET_N                        (rstn),
				
				// SGPIO
				.SGPIO_CK1                      ( SGPIO_CK   ),
				.SGPIO_LD1                      ( SGPIO_LD   ),
				.SGPIO_DATA1                    ( SGPIO_DATA ),
				.SGPIO_CK2                      (            ),
				.SGPIO_LD2                      (            ),
				.SGPIO_DATA2                    (            )
				);
				
always	#20   clk       = ~clk;

	
initial
	begin

        clk          = 0;
        rstn         = 0;
        i2c_wr       = 1;
		DRV_POWER_OK = 'h0;

        repeat (1000) @(posedge clk);
		
        rstn = 1;
		DRV_ACT      = 'b0;
		DRV_POWER_OK = 24'hff_ffff;
		repeat (1000) @(posedge clk);
		
		//SGPIO TEST
		//SGPIO_TEST();
        
		//CPLD INFO TEST
        HEADER_TEST();
		repeat (1000) @(posedge clk);
		
		//LED_TEST
		LED_TEST();
		repeat (1000) @(posedge clk);
		
		//PROTECT TEST
		PROTECT_TEST();
		repeat (1000) @(posedge clk);
		
		repeat (10000) @(posedge clk);
		
		
		$display("*************************************************************************");
		$display("***********************     ALL TEST PASS!!!     ************************");
		$display("*************************************************************************");
        $stop;

	end




//***************************	HEADER TEST TASK	**************************
task HEADER_TEST;
	begin
	    $display("*************************** HEADER test begin ***************************\n");
		
        $display("*********** Read DEVICE_ID_MSB ***********");
		wb_write(`I2C_ADDR1,8'h0,0,0,8'h1);
        wb_read(`I2C_ADDR1,8'h1);
		if(i2c_rddata1 == `DEVICE_ID_MSB)
		  $display("DEVICE_ID_MSB test pass\n");
		else
		  begin
		    $display("DEVICE_ID_MSB test fail");
			$stop;
		  end
		
		$display("*********** Read DEVICE_ID_LSB ***********");
		wb_write(`I2C_ADDR1,8'h1,0,0,8'h1);
        wb_read(`I2C_ADDR1,8'h1);
		if(i2c_rddata1 == `DEVICE_ID_LSB)
		  $display("DEVICE_ID_LSB test pass\n");
		else
		  begin
		    $display("DEVICE_ID_LSB test fail");
			$stop;
		  end
		
		$display("*********** Read CPLD_MAJ_VER ***********");
		wb_write(`I2C_ADDR1,8'h2,0,0,8'h1);
        wb_read(`I2C_ADDR1,8'h1);
		if(i2c_rddata1 == `CPLD_MAJ_VER)
		  $display("CPLD_MAJ_VER test pass\n");
		else
		  begin
		    $display("CPLD_MAJ_VER test fail");
			$stop;
		  end
		
		$display("*********** Read CPLD_MIN_VER ***********");
		wb_write(`I2C_ADDR1,8'h3,0,0,8'h1);
        wb_read(`I2C_ADDR1,8'h1);
		if(i2c_rddata1 == `CPLD_MIN_VER)
		  $display("CPLD_MIN_VER test pass\n");
		else
		  begin
		    $display("CPLD_MIN_VER test fail");
			$stop;
		  end
		
		$display("*********** Read CPLD_TEST_VER ***********");
		wb_write(`I2C_ADDR1,8'h4,0,0,8'h1);
        wb_read(`I2C_ADDR1,8'h1);
		if(i2c_rddata1 == `CPLD_TEST_VER)
		  $display("CPLD_TEST_VER test pass\n");
		else
		  begin
		    $display("CPLD_TEST_VER test fail");
			$stop;
		  end
		
		$display("*********** Read CHECKSUM ***********");
		wb_write(`I2C_ADDR1,8'h5,0,0,8'h1);
        wb_read(`I2C_ADDR1,8'h1);
		if(i2c_rddata1 == `CHECKSUM)
		  $display("CHECKSUM test pass\n");
		else
		  begin
		    $display("CHECKSUM test fail");
			$stop;
		  end
		
		$display("*************************** HEADER test pass ***************************\n");
	end
endtask

//***************************	LED TEST TASK	**************************
task LED_TEST;
	begin
		$display("*************************** I2C LED test begin ***************************\n");
		wb_write(`I2C_ADDR1,8'h50,{`LED_ON,`LED_OFF},8'h00,8'h2);
		wb_read(`I2C_ADDR1,8'h1);
		
		if((tb_baseboard.BB_TOP_INST.FLT_AMB_LED_INST2.LED0 == `OFF) && (tb_baseboard.BB_TOP_INST.FLT_AMB_LED_INST2.LED1 == `ON))
			begin
				$display("LED TEST Pass, the HDD FLT LED data is %x\n", i2c_rddata1);
			end
		else
			begin
				$display("LED TEST Fail, the HDD FLT LED data is %x\n", i2c_rddata1);
				$stop;
			end
		
		$display("*************************** I2C LED test pass ***************************\n");
	end
endtask

//***************************	PROTECT TEST TASK	**************************
task PROTECT_TEST;
	begin
		$display("*************************** protect test begin ***************************\n");
		wb_write(`I2C_ADDR1,8'h20,8'h55,8'h00,8'h2);
		wb_read(`I2C_ADDR1,8'h1);		
		if(tb_baseboard.BB_TOP_INST.DRV_PWR_EN0 == 8'h00)
			begin
				$display("PROTECT TEST Pass, the DRV_PWR_EN0 data is %x\n", i2c_rddata1);
			end
		else
			begin
				$display("PROTECT TEST Fail, the DRV_PWR_EN0 should be 8'h00 but the actual data is %x\n", i2c_rddata1);
				$stop;
			end
		
		wb_write(`I2C_ADDR1,8'hf5,8'h57,8'h00,8'h2);
		wb_write(`I2C_ADDR1,8'hfa,8'h6c,8'h00,8'h2);
		wb_write(`I2C_ADDR1,8'h20,8'h55,8'h00,8'h2);
		wb_read(`I2C_ADDR1,8'h1);
		if(tb_baseboard.BB_TOP_INST.DRV_PWR_EN0 == 8'h55)
			begin
				$display("PROTECT TEST Pass, the DRV_PWR_EN0 data is %x\n", i2c_rddata1);
			end
		else
			begin
				$display("PROTECT TEST Fail, the DRV_PWR_EN0 should be 8'h55 but the actual data is %x\n", i2c_rddata1);
				$stop;
			end		
		$display("*************************** protect test pass ***************************\n");
	end
endtask

//***************************	SGPIO TEST TASK	**************************
task SGPIO_TEST;
	begin
		$display("*************************** SGPIO test begin ***************************\n");
		DRV_ACT     = 36'b1011_0000_0000_0000_0000_0000_0000_0000_0101;
		repeat (3) @(posedge SGPIO_LD);
		if(tb_baseboard.STATUS_INST.SGPIO_INST1.ACT_LED == DRV_ACT)
		    $display("SGPIO TEST Pass!\n");
		else
		    begin
		        $display("SGPIO TEST Fail, the SGPIO received data is %x\n", tb_baseboard.STATUS_INST.SGPIO_INST1.ACT_LED);
				$stop;
			end

		DRV_ACT     = 36'b1011_0001_0001_0000_1010_0000_0000_0000_0101;
		repeat (3) @(posedge SGPIO_LD);
		if(tb_baseboard.STATUS_INST.SGPIO_INST1.ACT_LED == DRV_ACT)
		    $display("SGPIO TEST Pass!\n");
		else
		    begin
		        $display("SGPIO TEST Fail, the SGPIO received data is %x\n", tb_baseboard.STATUS_INST.SGPIO_INST1.ACT_LED);
				$stop;
			end

		DRV_ACT     = 36'b1011_0001_0001_0000_1010_0100_0010_0110_0101;
		repeat (3) @(posedge SGPIO_LD);
		if(tb_baseboard.STATUS_INST.SGPIO_INST1.ACT_LED == DRV_ACT)
		    $display("SGPIO TEST Pass!\n");
		else
		    begin
		        $display("SGPIO TEST Fail, the SGPIO received data is %x\n", tb_baseboard.STATUS_INST.SGPIO_INST1.ACT_LED);
				$stop;
			end

		DRV_ACT     = 36'hf_ffff_ffff;
		repeat (3) @(posedge SGPIO_LD);
		if(tb_baseboard.STATUS_INST.SGPIO_INST1.ACT_LED == DRV_ACT)
		    $display("SGPIO TEST Pass!\n");
		else
		    begin
		        $display("SGPIO TEST Fail, the SGPIO received data is %x\n", tb_baseboard.STATUS_INST.SGPIO_INST1.ACT_LED);
				$stop;
			end

		DRV_ACT     = 'b0;
		repeat (3) @(posedge SGPIO_LD);
		if(tb_baseboard.STATUS_INST.SGPIO_INST1.ACT_LED == DRV_ACT)
		    $display("SGPIO TEST Pass!\n");
		else
		    begin
		        $display("SGPIO TEST Fail, the SGPIO received data is %x\n", tb_baseboard.STATUS_INST.SGPIO_INST1.ACT_LED);
				$stop;
			end
		
		repeat (3) @(posedge SGPIO_LD);
    end
endtask

//******************************	I2C TASK	******************************
task wb_write;
	input	[7:0]	i2c_addr;
	input	[7:0]	data1;
	input	[7:0]	data2;
	input	[7:0]	data3;
	input	[7:0]	data_num;
	begin
		//i2c_address = {`I2C_ADDR1,1'b0};
		i2c_address = {i2c_addr,1'b0};
		i2c_wrdata1 = data1;
		i2c_wrdata2 = data2;
		i2c_wrdata3 = data3;
		i2c_data_num = data_num;
		@(posedge clk);
		i2c_wr = 0;
		@(posedge clk);
		i2c_wr = 1;
		
		@(negedge i2c_busy);
		
		if(data_num == 8'h1)
			$display("The I2C write %x", i2c_wrdata1);
		else if(data_num == 8'h2)
			$display("The I2C write %x and %x", i2c_wrdata1, i2c_wrdata2);
		else
			$display("The I2C write %x and %x and %x", i2c_wrdata1, i2c_wrdata2, i2c_wrdata3);
	end
endtask

task wb_read;
	input	[7:0]	i2c_addr;
	//output	[7:0]	data1;
	//output	[7:0]	data2;
	input	[7:0]	data_num;
	begin
		//i2c_address = {`I2C_ADDR1,1'b1};
		i2c_address = {i2c_addr,1'b1};
		i2c_data_num = data_num;
		@(posedge clk);
		i2c_wr = 0;
		@(posedge clk);
		i2c_wr = 1;
		
		@(negedge i2c_busy);
		
		if(data_num == 8'h1)
			$display("The I2C received %x", i2c_rddata1);
		else
			$display("The I2C received %x and %x", i2c_rddata1, i2c_rddata2);
		//data1 = i2c_rddata1;
		//data2 = i2c_rddata2;
	end
endtask


endmodule

