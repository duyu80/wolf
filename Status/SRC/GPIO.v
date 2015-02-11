//************************************************************************
//**                          Status CPLD								**
//**                          GPIO.v									**
//************************************************************************

//**********************      ChangeList      *****************************

`include "../SRC/status_define.v"

module GPIO # (
              parameter GPIOE_0          =    "TRUE",
			  parameter GPIOE_1          =    "TRUE",
			  parameter GPIOE_2          =    "TRUE",
			  parameter GPIOE_3          =    "TRUE",
              parameter GPIOE_4          =    "TRUE",
			  parameter GPIOE_5          =    "TRUE",
			  parameter GPIOE_6          =    "TRUE",
			  parameter GPIOE_7          =    "TRUE",
              parameter GPIOE_8          =    "TRUE",
			  parameter GPIOE_9          =    "TRUE",
			  parameter GPIOE_A          =    "TRUE",
			  parameter GPIOE_B          =    "TRUE",
              parameter GPIOE_C          =    "TRUE",
			  parameter GPIOE_D          =    "TRUE",
			  parameter GPIOE_E          =    "TRUE",
			  parameter GPIOE_F          =    "TRUE",
			  parameter GPO_DFT_VAL      =    8'h0
           )
           (
              input	     		SYSCLK,		 	//System clock
              input	     		RESET_N,		//Reset signal
                         
              input	     		PORT_CS,		//PORT select signal
              input	     [15:0]	OFFSET_SEL,	    //Address offset selection
              input	     		RD_WR,			//I2C read/write signal, 1 means read, 0 means write
                         
              input	     [7:0]	DIN,
              output reg [7:0]	DOUT,			//Output data when I2C read operation
              
              inout	     [7:0]	GPIO_0,
              inout	     [7:0]	GPIO_1,
              inout	     [7:0]	GPIO_2,
              inout	     [7:0]	GPIO_3,
              inout	     [7:0]	GPIO_4,
              inout	     [7:0]	GPIO_5,
              inout	     [7:0]	GPIO_6,
              inout	     [7:0]	GPIO_7,
              inout	     [7:0]	GPIO_8,
              inout	     [7:0]	GPIO_9,
              inout	     [7:0]	GPIO_A,
              inout	     [7:0]	GPIO_B,
              inout	     [7:0]	GPIO_C,
              inout	     [7:0]	GPIO_D,
              inout	     [7:0]	GPIO_E,
              inout	     [7:0]	GPIO_F
            );


reg	    [7:0]	GPO_0;
reg	    [7:0]	GPO_1;
reg	    [7:0]	GPO_2;
reg	    [7:0]	GPO_3;
reg	    [7:0]	GPO_4;
reg	    [7:0]	GPO_5;
reg	    [7:0]	GPO_6;
reg	    [7:0]	GPO_7;
reg	    [7:0]	GPO_8;
reg	    [7:0]	GPO_9;
reg	    [7:0]	GPO_A;
reg	    [7:0]	GPO_B;
reg	    [7:0]	GPO_C;
reg	    [7:0]	GPO_D;
reg	    [7:0]	GPO_E;
reg	    [7:0]	GPO_F;

wire    [7:0]	DOUT_W =  (
							({8{OFFSET_SEL[0]}}  & GPIO_0)		|
							({8{OFFSET_SEL[1]}}  & GPIO_1)		|
							({8{OFFSET_SEL[2]}}  & GPIO_2)		|
							({8{OFFSET_SEL[3]}}  & GPIO_3)		|
							({8{OFFSET_SEL[4]}}  & GPIO_4)		|
							({8{OFFSET_SEL[5]}}  & GPIO_5)		|
							({8{OFFSET_SEL[6]}}  & GPIO_6)		|
							({8{OFFSET_SEL[7]}}  & GPIO_7)		|
							({8{OFFSET_SEL[8]}}  & GPIO_8)		|
							({8{OFFSET_SEL[9]}}  & GPIO_9)		|
							({8{OFFSET_SEL[10]}} & GPIO_A)		|
							({8{OFFSET_SEL[11]}} & GPIO_B)		|
							({8{OFFSET_SEL[12]}} & GPIO_C)		|
							({8{OFFSET_SEL[13]}} & GPIO_D)		|
							({8{OFFSET_SEL[14]}} & GPIO_E)		|
							({8{OFFSET_SEL[15]}} & GPIO_F)
                          );

//READ
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				DOUT <= 8'h0;
			end
		else
			begin
				DOUT <= (PORT_CS & RD_WR)? DOUT_W : DOUT;			
			end
	end

//WRITE
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				GPO_0	<= GPO_DFT_VAL;
				GPO_1	<= GPO_DFT_VAL;
				GPO_2	<= GPO_DFT_VAL;
				GPO_3	<= GPO_DFT_VAL;
				GPO_4	<= GPO_DFT_VAL;
				GPO_5	<= GPO_DFT_VAL;
				GPO_6	<= GPO_DFT_VAL;
				GPO_7	<= GPO_DFT_VAL;
				GPO_8	<= GPO_DFT_VAL;
				GPO_9	<= GPO_DFT_VAL;
				GPO_A	<= GPO_DFT_VAL;
				GPO_B	<= GPO_DFT_VAL;
				GPO_C	<= GPO_DFT_VAL;
				GPO_D	<= GPO_DFT_VAL;
				GPO_E	<= GPO_DFT_VAL;
				GPO_F	<= GPO_DFT_VAL;
			end
		else
			begin
				GPO_0	<= (PORT_CS & OFFSET_SEL[0]  & ~RD_WR)? DIN :  GPO_0;
				GPO_1	<= (PORT_CS & OFFSET_SEL[1]  & ~RD_WR)? DIN :  GPO_1;
				GPO_2	<= (PORT_CS & OFFSET_SEL[2]  & ~RD_WR)? DIN :  GPO_2;
				GPO_3	<= (PORT_CS & OFFSET_SEL[3]  & ~RD_WR)? DIN :  GPO_3;
				GPO_4	<= (PORT_CS & OFFSET_SEL[4]  & ~RD_WR)? DIN :  GPO_4;
				GPO_5	<= (PORT_CS & OFFSET_SEL[5]  & ~RD_WR)? DIN :  GPO_5;
				GPO_6	<= (PORT_CS & OFFSET_SEL[6]  & ~RD_WR)? DIN :  GPO_6;
				GPO_7	<= (PORT_CS & OFFSET_SEL[7]  & ~RD_WR)? DIN :  GPO_7;
				GPO_8	<= (PORT_CS & OFFSET_SEL[8]  & ~RD_WR)? DIN :  GPO_8;
				GPO_9	<= (PORT_CS & OFFSET_SEL[9]  & ~RD_WR)? DIN :  GPO_9;
				GPO_A	<= (PORT_CS & OFFSET_SEL[10] & ~RD_WR)? DIN :  GPO_A;
				GPO_B	<= (PORT_CS & OFFSET_SEL[11] & ~RD_WR)? DIN :  GPO_B;
				GPO_C	<= (PORT_CS & OFFSET_SEL[12] & ~RD_WR)? DIN :  GPO_C;
				GPO_D	<= (PORT_CS & OFFSET_SEL[13] & ~RD_WR)? DIN :  GPO_D;
				GPO_E	<= (PORT_CS & OFFSET_SEL[14] & ~RD_WR)? DIN :  GPO_E;
				GPO_F	<= (PORT_CS & OFFSET_SEL[15] & ~RD_WR)? DIN :  GPO_F;
			end
	end

assign    GPIO_0  =  (GPIOE_0 == "TRUE")? GPO_0 : 8'hz;
assign    GPIO_1  =  (GPIOE_1 == "TRUE")? GPO_1 : 8'hz;
assign    GPIO_2  =  (GPIOE_2 == "TRUE")? GPO_2 : 8'hz;
assign    GPIO_3  =  (GPIOE_3 == "TRUE")? GPO_3 : 8'hz;
assign    GPIO_4  =  (GPIOE_4 == "TRUE")? GPO_4 : 8'hz;
assign    GPIO_5  =  (GPIOE_5 == "TRUE")? GPO_5 : 8'hz;
assign    GPIO_6  =  (GPIOE_6 == "TRUE")? GPO_6 : 8'hz;
assign    GPIO_7  =  (GPIOE_7 == "TRUE")? GPO_7 : 8'hz;
assign    GPIO_8  =  (GPIOE_8 == "TRUE")? GPO_8 : 8'hz;
assign    GPIO_9  =  (GPIOE_9 == "TRUE")? GPO_9 : 8'hz;
assign    GPIO_A  =  (GPIOE_A == "TRUE")? GPO_A : 8'hz;
assign    GPIO_B  =  (GPIOE_B == "TRUE")? GPO_B : 8'hz;
assign    GPIO_C  =  (GPIOE_C == "TRUE")? GPO_C : 8'hz;
assign    GPIO_D  =  (GPIOE_D == "TRUE")? GPO_D : 8'hz;
assign    GPIO_E  =  (GPIOE_E == "TRUE")? GPO_E : 8'hz;
assign    GPIO_F  =  (GPIOE_F == "TRUE")? GPO_F : 8'hz;

endmodule