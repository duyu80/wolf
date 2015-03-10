//************************************************************************
//**                          Baseboard CPLD							**
//**                          GPO.v										**
//************************************************************************ 

//**********************      ChangeList      *****************************

`include "../SRC/baseboard_define.v"

module GPO_PROTECT # (
                parameter GPO_DFT = 8'h0
              )
			  (
                input	    		SYSCLK,		 	//System clock
                input	    		RESET_N,		//Reset signal
                            
                input	        	PORT_CS1,		//PORT select signal
				input	    [15:0]	PORT_CS1_ALL,	//PORT select signal
                input	    [15:0]	OFFSET_SEL1,	//Address offset selection
                input	    		RD_WR1,			//I2C read/write signal, 1 means read, 0 means write
                input	        	PORT_CS2,		//PORT select signal
				input	    [15:0]	PORT_CS2_ALL,	//PORT select signal
                input	    [15:0]	OFFSET_SEL2,	//Address offset selection
                input	    		RD_WR2,			//I2C read/write signal, 1 means read, 0 means write
                            
                input	    [7:0]	DIN1,
                input	    [7:0]	DIN2,
                output reg	[7:0]	DOUT1,			//Output data when I2C read operation
                output reg	[7:0]	DOUT2,			//Output data when I2C read operation

				output reg  [7:0]   DO0,
				output reg  [7:0]   DO1,
				output reg  [7:0]   DO2,
				output reg  [7:0]   DO3,
				output reg  [7:0]   DO4,
				output reg  [7:0]   DO5,
				output reg  [7:0]   DO6,
				output reg  [7:0]   DO7,                                    
				output reg  [7:0]   DO8,
				output reg  [7:0]   DO9,
				output reg  [7:0]   DO10,
				output reg  [7:0]   DO11,
				output reg  [7:0]   DO12,
				output reg  [7:0]   DO13,
				output reg  [7:0]   DO14,
				output reg  [7:0]   DO15
				);

wire		[7:0]	DOUT_W1 =	(
							({8{OFFSET_SEL1[0]}}  & DO0)		|
							({8{OFFSET_SEL1[1]}}  & DO1)		|
							({8{OFFSET_SEL1[2]}}  & DO2)		|
							({8{OFFSET_SEL1[3]}}  & DO3)		|
							({8{OFFSET_SEL1[4]}}  & DO4)		|
							({8{OFFSET_SEL1[5]}}  & DO5)		|
							({8{OFFSET_SEL1[6]}}  & DO6)		|
							({8{OFFSET_SEL1[7]}}  & DO7)		|
							({8{OFFSET_SEL1[8]}}  & DO8)		|
							({8{OFFSET_SEL1[9]}}  & DO9)		|
							({8{OFFSET_SEL1[10]}} & DO10)		|
							({8{OFFSET_SEL1[11]}} & DO11)		|
							({8{OFFSET_SEL1[12]}} & DO12)		|
							({8{OFFSET_SEL1[13]}} & DO13)		|
							({8{OFFSET_SEL1[14]}} & DO14)		|
							({8{OFFSET_SEL1[15]}} & DO15)
							);

wire		[7:0]	DOUT_W2 =	(
							({8{OFFSET_SEL2[0]}}  & DO0)		|
							({8{OFFSET_SEL2[1]}}  & DO1)		|
							({8{OFFSET_SEL2[2]}}  & DO2)		|
							({8{OFFSET_SEL2[3]}}  & DO3)		|
							({8{OFFSET_SEL2[4]}}  & DO4)		|
							({8{OFFSET_SEL2[5]}}  & DO5)		|
							({8{OFFSET_SEL2[6]}}  & DO6)		|
							({8{OFFSET_SEL2[7]}}  & DO7)		|
							({8{OFFSET_SEL2[8]}}  & DO8)		|
							({8{OFFSET_SEL2[9]}}  & DO9)		|
							({8{OFFSET_SEL2[10]}} & DO10)		|
							({8{OFFSET_SEL2[11]}} & DO11)		|
							({8{OFFSET_SEL2[12]}} & DO12)		|
							({8{OFFSET_SEL2[13]}} & DO13)		|
							({8{OFFSET_SEL2[14]}} & DO14)		|
							({8{OFFSET_SEL2[15]}} & DO15)
							);

reg             PROTECT;
reg             TMP_EN;
reg             i2c_access_d;
wire			i2c_access = |(PORT_CS1_ALL | PORT_CS2_ALL);
wire			i2c_access_p = ~i2c_access_d & i2c_access;
always@(posedge SYSCLK)
	begin
		i2c_access_d <= i2c_access;
	end
							
//READ
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				DOUT1 <= 8'h0;
			end
		else
			begin
				DOUT1 <= (PORT_CS1 & RD_WR1)? DOUT_W1 : DOUT1;			
			end
	end

always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				DOUT2 <= 8'h0;
			end
		else
			begin
				DOUT2 <= (PORT_CS2 & RD_WR2)? DOUT_W2 : DOUT2;			
			end
	end

//PROTECT CTRL
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				PROTECT <= 1'b0;
				TMP_EN <=1'b0;
			end
		else
			begin
				if (PORT_CS1_ALL[15] & OFFSET_SEL1[5] & (DIN1==8'h57))
					TMP_EN <= 1'b1;
				else if (PORT_CS2_ALL[15] & OFFSET_SEL2[5] & (DIN2==8'h57))
					TMP_EN <= 1'b1;
				else if ( i2c_access_p )
					TMP_EN <= 1'b0;

				if (PORT_CS1_ALL[15] & OFFSET_SEL1[10] & (DIN1==8'h6C) & (TMP_EN == 1'b1))
					PROTECT <= 1'b1;
				else if (PORT_CS2_ALL[15] & OFFSET_SEL2[10] & (DIN2==8'h6C) & (TMP_EN == 1'b1))
					PROTECT <= 1'b1;
				else if ( i2c_access_p )
					PROTECT <= 1'b0;
			end
	end
	
//WRITE
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				DO0  	<= GPO_DFT;
				DO1  	<= GPO_DFT;
				DO2  	<= GPO_DFT;
				DO3  	<= GPO_DFT;
				DO4  	<= GPO_DFT;
				DO5  	<= GPO_DFT;
				DO6  	<= GPO_DFT;
				DO7  	<= GPO_DFT;
				DO8  	<= GPO_DFT;
				DO9  	<= GPO_DFT;
				DO10	<= GPO_DFT;
				DO11	<= GPO_DFT;
				DO12	<= GPO_DFT;
				DO13	<= GPO_DFT;
				DO14	<= GPO_DFT;
				DO15	<= GPO_DFT;
			end
		else
			begin
				DO0 	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[0]  & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[0]  & ~RD_WR2)? DIN2 : DO0 )) : DO0 ;
				DO1 	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[1]  & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[1]  & ~RD_WR2)? DIN2 : DO1 )) : DO1 ;
				DO2 	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[2]  & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[2]  & ~RD_WR2)? DIN2 : DO2 )) : DO2 ;
				DO3 	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[3]  & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[3]  & ~RD_WR2)? DIN2 : DO3 )) : DO3 ;
				DO4 	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[4]  & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[4]  & ~RD_WR2)? DIN2 : DO4 )) : DO4 ;
				DO5 	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[5]  & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[5]  & ~RD_WR2)? DIN2 : DO5 )) : DO5 ;
				DO6 	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[6]  & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[6]  & ~RD_WR2)? DIN2 : DO6 )) : DO6 ;
				DO7 	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[7]  & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[7]  & ~RD_WR2)? DIN2 : DO7 )) : DO7 ;
				DO8 	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[8]  & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[8]  & ~RD_WR2)? DIN2 : DO8 )) : DO8 ;
				DO9 	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[9]  & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[9]  & ~RD_WR2)? DIN2 : DO9 )) : DO9 ;
				DO10	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[10] & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[10] & ~RD_WR2)? DIN2 : DO10)) : DO10;
				DO11	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[11] & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[11] & ~RD_WR2)? DIN2 : DO11)) : DO11;
				DO12	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[12] & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[12] & ~RD_WR2)? DIN2 : DO12)) : DO12;
				DO13	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[13] & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[13] & ~RD_WR2)? DIN2 : DO13)) : DO13;
				DO14	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[14] & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[14] & ~RD_WR2)? DIN2 : DO14)) : DO14;
				DO15	<= PROTECT? ((PORT_CS1 & OFFSET_SEL1[15] & ~RD_WR1)? DIN1 : ((PORT_CS2 & OFFSET_SEL2[15] & ~RD_WR2)? DIN2 : DO15)) : DO15;
			end
	end

endmodule
