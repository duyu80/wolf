`include "../SRC/status_define.v"
`include "i2c_master_defines.v"

module tb_status;

parameter 		CPLD_REV	= `CPLD_REV;
parameter		GPI_IN		= 8'ha5;
parameter		GPO_OUT	= 8'h37;

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

// Indicator LEDs Signals
wire            SES_FLT_AMBER_LED_L;
wire            SES_INENT_BLUE_LED_L;
wire            COM_FLT_AMBER_LED_L;
wire            DRV_FLT_AMBER_LED_L;
wire            COVER_OPEN_AMBER_LED_L;
// SGPIO
reg             SGPIO_CK1;
reg             SGPIO_LD1;
reg             SGPIO_DATA1;
reg             SGPIO_CK2;
reg             SGPIO_LD2;
reg             SGPIO_DATA2;
// Active led power
wire            DRV_ACT_LED_EN_L;

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


TOP		TOP_INST (
				.SYSCLK                         (clk),
				.RESET_N                        (rstn),
				.SCL			                (scl),
				.SDA			                (sda),
                
				// Indicator LEDs Signals
				.SES_FLT_AMBER_LED_L            (SES_FLT_AMBER_LED_L    ),
				.SES_INENT_BLUE_LED_L           (SES_INENT_BLUE_LED_L   ),
				.COM_FLT_AMBER_LED_L            (COM_FLT_AMBER_LED_L    ),
				.DRV_FLT_AMBER_LED_L            (DRV_FLT_AMBER_LED_L    ),
				.COVER_OPEN_AMBER_LED_L         (COVER_OPEN_AMBER_LED_L ),
				
				// SGPIO
				.SGPIO_CK1                      (SGPIO_CK1   ),
				.SGPIO_LD1                      (SGPIO_LD1   ),
				.SGPIO_DATA1                    (SGPIO_DATA1 ),
				.SGPIO_CK2                      (SGPIO_CK2   ),
				.SGPIO_LD2                      (SGPIO_LD2   ),
				.SGPIO_DATA2                    (SGPIO_DATA2 ),  			
				// Active led power
				.DRV_ACT_LED_EN_L               (DRV_ACT_LED_EN_L)
				);

				
always	#20   clk       = ~clk;
always  #5000 SGPIO_CK1 = ~SGPIO_CK1;
always  #5000 SGPIO_CK2 = ~SGPIO_CK2;

	
initial
	begin

        clk         = 0;
        rstn        = 0;
        i2c_wr      = 1;
        SGPIO_CK1   = 0;
        SGPIO_LD1   = 0;
        SGPIO_DATA1 = 0;
        SGPIO_CK2   = 0;
        SGPIO_LD2   = 0;
        SGPIO_DATA2 = 0;
        repeat (1000) @(posedge clk);
		
        rstn = 1;
		repeat (1000) @(posedge clk);
        
		// CPLD INFO TEST
        HEADER_TEST();
		repeat (1000) @(posedge clk);
		
		// LED TEST
        LED_TEST();
		repeat (1000) @(posedge clk);
        
        // SGPIO TEST
		SGPIO();
		
        repeat (1000) @(posedge clk);
        $stop;

	end




//***************************	SGPIO TASK	**************************
task    SGPIO;
    begin
	    //SGPIO1
        SGPIO_1(108'h200_0000_0000_0000_0000_0000_0041);
		
        if(tb_status.TOP_INST.DRV1_ACT_LED_CATH_L != 1)
        	begin
        		$display("SGPIO TEST FAIL");
        		$stop;
        	end
        if(tb_status.TOP_INST.DRV2_ACT_LED_CATH_L != 0)
        	begin
        		$display("SGPIO TEST FAIL");
        		$stop;
        	end
        if(tb_status.TOP_INST.DRV3_ACT_LED_CATH_L != 1)
        	begin
        		$display("SGPIO TEST FAIL");
        		$stop;
        	end
        if(tb_status.TOP_INST.DRV60_ACT_LED_CATH_L != 1)
        	begin
        		$display("SGPIO TEST FAIL");
        		$stop;
        	end
		
        $display("***************************  SGPIO1 TEST PASS  ***************************");
		
		//SGPIO2
        SGPIO_2(108'h200_0000_0000_0000_0000_0000_1040);
		
        if(tb_status.TOP_INST.DRV15_ACT_LED_CATH_L != 1)
        	begin
        		$display("SGPIO TEST FAIL");
        		$stop;
        	end
        if(tb_status.TOP_INST.DRV16_ACT_LED_CATH_L != 0)
        	begin
        		$display("SGPIO TEST FAIL");
        		$stop;
        	end
        if(tb_status.TOP_INST.DRV17_ACT_LED_CATH_L != 1)
        	begin
        		$display("SGPIO TEST FAIL");
        		$stop;
        	end
        if(tb_status.TOP_INST.DRV72_ACT_LED_CATH_L != 1)
        	begin
        		$display("SGPIO TEST FAIL");
        		$stop;
        	end
		
        $display("***************************  SGPIO2 TEST PASS  ***************************");
	end
endtask

task	SGPIO_1;
	reg		[`HDD_NUM*3-1:0] SGPIO_TMP;
	input	[`HDD_NUM*3-1:0] SGPIO_OUT;
	begin
        SGPIO_TMP   = SGPIO_OUT;
        SGPIO_LD1   = 0;
        SGPIO_DATA1 = 0;
		@(posedge SGPIO_CK1);
		
        SGPIO_LD1 = 1;
		@(posedge SGPIO_CK1);
        
		SGPIO_LD1 = 0;
		
		repeat(3)
		    begin
		        for (i=0;i<`HDD_NUM*3;i=i+1)
			        begin
				        SGPIO_DATA1 = SGPIO_TMP[i];
						SGPIO_LD1 = (i==(`HDD_NUM*3-1))? 1 : 0;
				        @(posedge SGPIO_CK1);
			        end
				SGPIO_LD1 = 0;
			end

	end
endtask

task	SGPIO_2;
	reg		[`HDD_NUM*3-1:0] SGPIO_TMP;
	input	[`HDD_NUM*3-1:0] SGPIO_OUT;
	begin
        SGPIO_TMP   = SGPIO_OUT;
        SGPIO_LD2   = 0;
        SGPIO_DATA2 = 0;
		@(posedge SGPIO_CK2);
		
        SGPIO_LD2 = 1;
		@(posedge SGPIO_CK2);
        
		SGPIO_LD2 = 0;
		
		repeat(3)
		    begin
		        for (i=0;i<`HDD_NUM*3;i=i+1)
			        begin
				        SGPIO_DATA2 = SGPIO_TMP[i];
						SGPIO_LD2 = (i==(`HDD_NUM*3-1))? 1 : 0;
				        @(posedge SGPIO_CK2);
			        end
				SGPIO_LD2 = 0;
			end

	end
endtask

//***************************	HEADER TEST TASK	**************************
task HEADER_TEST;
	begin
	    $display("*************************** HEADER test begin ***************************\n");
		
        $display("*********** Read DEVICE_ID_MSB ***********");
		wb_write(`I2C_ADDR,8'h0,0,0,8'h1);
        wb_read(`I2C_ADDR,8'h1);
		if(i2c_rddata1 == `DEVICE_ID_MSB)
		  $display("DEVICE_ID_MSB test pass\n");
		else
		  begin
		    $display("DEVICE_ID_MSB test fail");
			$stop;
		  end
		
		$display("*********** Read DEVICE_ID_LSB ***********");
		wb_write(`I2C_ADDR,8'h1,0,0,8'h1);
        wb_read(`I2C_ADDR,8'h1);
		if(i2c_rddata1 == `DEVICE_ID_LSB)
		  $display("DEVICE_ID_LSB test pass\n");
		else
		  begin
		    $display("DEVICE_ID_LSB test fail");
			$stop;
		  end
		
		$display("*********** Read CPLD_MAJ_VER ***********");
		wb_write(`I2C_ADDR,8'h2,0,0,8'h1);
        wb_read(`I2C_ADDR,8'h1);
		if(i2c_rddata1 == `CPLD_MAJ_VER)
		  $display("CPLD_MAJ_VER test pass\n");
		else
		  begin
		    $display("CPLD_MAJ_VER test fail");
			$stop;
		  end
		
		$display("*********** Read CPLD_MIN_VER ***********");
		wb_write(`I2C_ADDR,8'h3,0,0,8'h1);
        wb_read(`I2C_ADDR,8'h1);
		if(i2c_rddata1 == `CPLD_MIN_VER)
		  $display("CPLD_MIN_VER test pass\n");
		else
		  begin
		    $display("CPLD_MIN_VER test fail");
			$stop;
		  end
		
		$display("*********** Read CPLD_TEST_VER ***********");
		wb_write(`I2C_ADDR,8'h4,0,0,8'h1);
        wb_read(`I2C_ADDR,8'h1);
		if(i2c_rddata1 == `CPLD_TEST_VER)
		  $display("CPLD_TEST_VER test pass\n");
		else
		  begin
		    $display("CPLD_TEST_VER test fail");
			$stop;
		  end
		
		$display("*********** Read CHECKSUM ***********");
		wb_write(`I2C_ADDR,8'h5,0,0,8'h1);
        wb_read(`I2C_ADDR,8'h1);
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
		wb_write(`I2C_ADDR,8'h10,8'h01,8'h00,8'h2);
		wb_read(`I2C_ADDR,8'h1);
		
		if((tb_status.TOP_INST.LED_INST.LED0 == 0) && (tb_status.TOP_INST.LED_INST.LED1 == 1))
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

//******************************	I2C TASK	******************************
task wb_write;
	input	[7:0]	i2c_addr;
	input	[7:0]	data1;
	input	[7:0]	data2;
	input	[7:0]	data3;
	input	[7:0]	data_num;
	begin
		//i2c_address = {`I2C_ADDR,1'b0};
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
		//i2c_address = {`I2C_ADDR,1'b1};
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

