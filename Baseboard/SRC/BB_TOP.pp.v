//************************************************************************
//**                          Baseboard CPLD							**
//**                          I2C.v										**
//************************************************************************ 

//**********************      ChangeList      *****************************

`include "../SRC/baseboard_define.v"


module BB_TOP (
            // System
			input     SYSCLK,
			input     RESET_N,
			// I2C
			input     SCL_1,
			inout     SDA_1,
			input     SCL_2,
			inout     SDA_2,
			// Driver active led input
; for ($i=0; $i<36; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            input     DRV${j3}_ACT_LED,DRV${j2}_ACT_LED,DRV${j1}_ACT_LED,DRV${j0}_ACT_LED,
; }
            // Driver power enable output
; for ($i=0; $i<36; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            output    DRV${j3}_PWR_EN_L,DRV${j2}_PWR_EN_L,DRV${j1}_PWR_EN_L,DRV${j0}_PWR_EN_L,
; }
            // Driver power ok input
; for ($i=12; $i<36; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            input     DRV${j3}_PWROK,DRV${j2}_PWROK,DRV${j1}_PWROK,DRV${j0}_PWROK,
; }
            // Driver present and amber LED inout
; for ($i=0; $i<36; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
			inout     DRV${j3}_PRSNT_AMBER_LED,DRV${j2}_PRSNT_AMBER_LED,DRV${j1}_PRSNT_AMBER_LED,DRV${j0}_PRSNT_AMBER_LED,
; }
            // Driver identify and blue LED inout
; for ($i=0; $i<36; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
			inout     DRV${j3}_IFDET_BLUE_LED,DRV${j2}_IFDET_BLUE_LED,DRV${j1}_IFDET_BLUE_LED,DRV${j0}_IFDET_BLUE_LED,
; }
            // PCIE reset portA output
; for ($i=0; $i<24; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            output    PE_RST_DRV${j3}_A_L,PE_RST_DRV${j2}_A_L,PE_RST_DRV${j1}_A_L,PE_RST_DRV${j0}_A_L,
; }
            // PCIE reset portB output
; for ($i=0; $i<24; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            output    PE_RST_DRV${j3}_B_L,PE_RST_DRV${j2}_B_L,PE_RST_DRV${j1}_B_L,PE_RST_DRV${j0}_B_L,
; }
            // PCIE clock OE portA output
; for ($i=12; $i<36; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            output    DRV${j3}_PCIE_CLK_A_OE_L,DRV${j2}_PCIE_CLK_A_OE_L,DRV${j1}_PCIE_CLK_A_OE_L,DRV${j0}_PCIE_CLK_A_OE_L,
; }
            // PCIE clock OE portB output
; for ($i=12; $i<36; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            output    DRV${j3}_PCIE_CLK_B_OE_L,DRV${j2}_PCIE_CLK_B_OE_L,DRV${j1}_PCIE_CLK_B_OE_L,DRV${j0}_PCIE_CLK_B_OE_L,
; }
            // Enclosure Signals
            output reg   BB_CPLD_ALT_L,
			input     CANISTER_A_PCIE_CLK_ACT_L,CANISTER_B_PCIE_CLK_ACT_L,
			input     CPLD_SLOT_ID,
            // SGPIO
            output    SGPIO_CK,
            output    SGPIO_LD,
			output    SGPIO_DATA,
            output reg   HEART			
			);

//I2C wire1
wire	[7:0]	I2C_DOUT_1;
wire	[15:0]	PORT_CS_1;
wire	[15:0]	OFFSET_SEL_1;    //This two signal port are used for GPIO port selection
wire			RD_WR_1;    //1 means I2C read operation, and 0 means I2C write operation
wire	[7:0]   DIN_0_1, DIN_1_1, DIN_2_1, DIN_3_1, DIN_4_1,  DIN_5_1, DIN_6_1, DIN_7_1, DIN_8_1, DIN_9_1, DIN_A_1, DIN_B_1, DIN_C_1, DIN_D_1, DIN_E_1, DIN_F_1;    //16 PORTs for GPIO PORTs
wire			WR_EN_1;    //This signal is for error code

//I2C wire 2
wire	[7:0]	I2C_DOUT_2;
wire	[15:0]	PORT_CS_2;
wire	[15:0]	OFFSET_SEL_2;    //This two signal port are used for GPIO port selection
wire			RD_WR_2;    //1 means I2C read operation, and 0 means I2C write operation
wire	[7:0]   DIN_0_2, DIN_1_2, DIN_2_2, DIN_3_2, DIN_4_2,  DIN_5_2, DIN_6_2, DIN_7_2, DIN_8_2, DIN_9_2, DIN_A_2, DIN_B_2, DIN_C_2, DIN_D_2, DIN_E_2, DIN_F_2;    //16 PORTs for GPIO PORTs
wire			WR_EN_2;    //This signal is for error code

//LED
wire    [7:0]	LED_REG0;
wire    [7:0]	LED_REG1;
wire    [7:0]	LED_REG2;
wire    [7:0]	LED_REG3;
wire    [7:0]	LED_REG4;
wire    [7:0]	LED_REG5;
wire    [7:0]	LED_REG6;
wire    [7:0]	LED_REG7;

//Present$Identify output signal from PRSNT_LED_CTRL.v
wire    [35:0]  PRSNT;
reg     [35:0]  PRSNT_D;
wire    [35:0]  IDENT;
//LED input signal to PRSNT_LED_CTRL.v
wire    [35:0]  AMBER_DAT;
wire    [35:0]  BLUE_DAT;
//CLOCK OE
// PCIE clock OE portA output
; for ($i=12; $i<36; $i++) {
assign    DRV${i}_PCIE_CLK_A_OE_L = DRV${i}_PWR_EN_L;
; }
// PCIE clock OE portB output
; for ($i=12; $i<36; $i++) {
assign    DRV${i}_PCIE_CLK_B_OE_L = DRV${i}_PWR_EN_L;
; }

//**************************************************************************
//**                          
//**  This instance is I2C MACHINE, CPLD use this I2C MACHINE to read/write
//**  data from/to GPIO                    
//**                          
//************************************************************************** 
I2C  I2C_INS_1  (
			   .SCL		   		    (SCL_1),
			   .SDA		   		    (SDA_1),
			   .I2C_ADDRESS		    (`I2C_ADDR1),
			   .I2C_RESET_N		    (RESET_N),
			   .SYSCLK     			(SYSCLK),
			   .PORT_CS    		    (PORT_CS_1),
			   .OFFSET_SEL 		    (OFFSET_SEL_1),
			   .RD_WR      		    (RD_WR_1),
			   .DOUT       			(I2C_DOUT_1),
			   .DIN_0      			(DIN_0_1),                
			   .DIN_1      			(DIN_1_1), 		
			   .DIN_2      			(DIN_2_1), 		
			   .DIN_3      			(DIN_3_1), 		
			   .DIN_4      			(DIN_4_1), 		
			   .DIN_5      			(DIN_5_1), 		
			   .DIN_6      			(DIN_6_1), 		
			   .DIN_7      			(DIN_7_1),		    
			   .DIN_8      			(DIN_8_1), 		
			   .DIN_9      			(DIN_9_1), 		
			   .DIN_A      			(DIN_A_1), 		
			   .DIN_B      			(DIN_B_1), 		
			   .DIN_C      			(DIN_C_1), 		
			   .DIN_D      			(DIN_D_1), 		
			   .DIN_E      			(DIN_E_1), 		
			   .DIN_F      			(DIN_F_1)
			   );


I2C  I2C_INS_2  (
			   .SCL		   		    (SCL_2),
			   .SDA		   		    (SDA_2),
			   .I2C_ADDRESS		    (`I2C_ADDR2),
			   .I2C_RESET_N		    (RESET_N),
			   .SYSCLK     			(SYSCLK),
			   .PORT_CS    		    (PORT_CS_2),
			   .OFFSET_SEL 		    (OFFSET_SEL_2),
			   .RD_WR      		    (RD_WR_2),
			   .DOUT       			(I2C_DOUT_2),
			   .DIN_0      			(DIN_0_2),                
			   .DIN_1      			(DIN_1_2), 		
			   .DIN_2      			(DIN_2_2), 		
			   .DIN_3      			(DIN_3_2), 		
			   .DIN_4      			(DIN_4_2), 		
			   .DIN_5      			(DIN_5_2), 		
			   .DIN_6      			(DIN_6_2), 		
			   .DIN_7      			(DIN_7_2),		    
			   .DIN_8      			(DIN_8_2), 		
			   .DIN_9      			(DIN_9_2), 		
			   .DIN_A      			(DIN_A_2), 		
			   .DIN_B      			(DIN_B_2), 		
			   .DIN_C      			(DIN_C_2), 		
			   .DIN_D      			(DIN_D_2), 		
			   .DIN_E      			(DIN_E_2), 		
			   .DIN_F      			(DIN_F_2)
			   );

//HEADER 00H
GPI    	GPI0_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[0]),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_0_1),						
			.RD_WR1		    (RD_WR_1),
			
			.PORT_CS2		(PORT_CS_2[0]),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_0_2),						
			.RD_WR2		    (RD_WR_2),
			
			.DIN0           ( `DEVICE_ID_MSB ),
			.DIN1           ( `DEVICE_ID_LSB ),
			.DIN2           ( `CPLD_MAJ_VER  ),
			.DIN3           ( `CPLD_MIN_VER  ),
			.DIN4           ( `CPLD_TEST_VER ),
			.DIN5           ( `CHECKSUM      ),
			.DIN6           ( `CPLD_REV      ),
			.DIN7           (0),
			.DIN8           (0),
			.DIN9           (0),
			.DIN10          (0),
			.DIN11          (0),
			.DIN12          (0),
			.DIN13          (0),
			.DIN14          (0),
			.DIN15          (0)
			);

//PRESENT&IDENTIFY 10H
GPI    	GPI1_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[1]),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_1_1),						
			.RD_WR1		    (RD_WR_1),
			
			.PORT_CS2		(PORT_CS_2[1]),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_1_2),						
			.RD_WR2		    (RD_WR_2),
			
			.DIN0           (  PRSNT[7:0]          ),
			.DIN1           (  PRSNT[15:8]         ),
			.DIN2           (  PRSNT[23:16]        ),
			.DIN3           (  PRSNT[31:24]        ),
			.DIN4           (  {4'h0,PRSNT[35:32]} ),			
			.DIN5           (  0                   ),
			.DIN6           (  IDENT[7:0]          ),
			.DIN7           (  IDENT[15:8]         ),
			.DIN8           (  IDENT[23:16]        ),
			.DIN9           (  IDENT[31:24]        ),
			.DIN10          (  {4'h0,IDENT[35:32]} ),
			.DIN11          (  0                   ),
			.DIN12          (  0                   ),
			.DIN13          (  0                   ),
			.DIN14          (  0                   ),
			.DIN15          (  0                   )
			);

always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
			    PRSNT_D       <= 'b0;
				BB_CPLD_ALT_L <= 'b0;
			end
		else
		    begin
			    PRSNT_D       <= PRSNT;
				BB_CPLD_ALT_L <= (PORT_CS_1[9] || PORT_CS_2[9])? 'b0 : ((PRSNT ^ PRSNT_D)? 1'b1 : BB_CPLD_ALT_L);
			end
	end
	
//POWER ENABLE 20H
wire  [7:0]  DRV_PWR_EN0,DRV_PWR_EN1,DRV_PWR_EN2,DRV_PWR_EN3,DRV_PWR_EN4;
; for ($i=0,$j=0; $i<8,$j<8; $i++,$j++) {
assign    DRV${j}_PWR_EN_L = !(DRV_PWR_EN0[${i}] && PRSNT[${j}]);
; }
; for ($i=0,$j=8; $i<8,$j<16; $i++,$j++) {
assign    DRV${j}_PWR_EN_L = !(DRV_PWR_EN1[${i}] && PRSNT[${j}]);
; }
; for ($i=0,$j=16; $i<8,$j<24; $i++,$j++) {
assign    DRV${j}_PWR_EN_L = !(DRV_PWR_EN2[${i}] && PRSNT[${j}]);
; }
; for ($i=0,$j=24; $i<8,$j<32; $i++,$j++) {
assign    DRV${j}_PWR_EN_L = !(DRV_PWR_EN3[${i}] && PRSNT[${j}]);
; }
; for ($i=0,$j=32; $i<4,$j<36; $i++,$j++) {
assign    DRV${j}_PWR_EN_L = !(DRV_PWR_EN4[${i}] && PRSNT[${j}]);
; }
// wire  [7:0]  DRV_PWR_EN0,DRV_PWR_EN1,DRV_PWR_EN2,DRV_PWR_EN3,DRV_PWR_EN4;
// ; for ($i=0,$j=0; $i<8,$j<8; $i++,$j++) {
// assign    DRV${j}_PWR_EN_L = 0;
// ; }
// ; for ($i=0,$j=8; $i<8,$j<16; $i++,$j++) {
// assign    DRV${j}_PWR_EN_L = 0;
// ; }
// ; for ($i=0,$j=16; $i<8,$j<24; $i++,$j++) {
// assign    DRV${j}_PWR_EN_L = 0;
// ; }
// ; for ($i=0,$j=24; $i<8,$j<32; $i++,$j++) {
// assign    DRV${j}_PWR_EN_L = 0;
// ; }
// ; for ($i=0,$j=32; $i<4,$j<36; $i++,$j++) {
// assign    DRV${j}_PWR_EN_L = 0;
// ; }

GPO_PROTECT #     (
            .GPO_DFT        (8'h00)
          )   
GPO2_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[2]),
			.PORT_CS1_ALL	(PORT_CS_1),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_2_1),						
			.RD_WR1		    (RD_WR_1),
			.DIN1			(I2C_DOUT_1),
			
			.PORT_CS2		(PORT_CS_2[2]),
			.PORT_CS2_ALL	(PORT_CS_2),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_2_2),						
			.RD_WR2		    (RD_WR_2),
			.DIN2			(I2C_DOUT_2),

			.DO0		    (DRV_PWR_EN0),
			.DO1		    (DRV_PWR_EN1),
			.DO2		    (DRV_PWR_EN2),
			.DO3		    (DRV_PWR_EN3),
			.DO4		    (DRV_PWR_EN4),
			.DO5		    (),
			.DO6		    (),
			.DO7		    (),
			.DO8		    (),
			.DO9		    (),
			.DO10		    (),
			.DO11		    (),
			.DO12		    (),
			.DO13		    (),
			.DO14		    (),
			.DO15		    ()
			);

//POWER OK 30H
GPI    	GPI3_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[3]),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_3_1),						
			.RD_WR1		    (RD_WR_1),
			
			.PORT_CS2		(PORT_CS_2[3]),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_3_2),						
			.RD_WR2		    (RD_WR_2),
			
			.DIN0           (  { DRV7_PWR_EN,DRV6_PWR_EN,DRV5_PWR_EN,DRV4_PWR_EN,
			                     DRV3_PWR_EN,DRV2_PWR_EN,DRV1_PWR_EN,DRV0_PWR_EN       }  ),
			.DIN1           (  { DRV15_PWROK,DRV14_PWROK,DRV13_PWROK,DRV12_PWROK,      
			                     DRV11_PWR_EN,DRV10_PWR_EN,DRV9_PWR_EN,DRV8_PWR_EN     }  ),
			.DIN2           (  { DRV23_PWROK,DRV22_PWROK,DRV21_PWROK,DRV20_PWROK,      
			                     DRV19_PWROK,DRV18_PWROK,DRV17_PWROK,DRV16_PWROK       }  ),
			.DIN3           (  { DRV31_PWROK,DRV30_PWROK,DRV29_PWROK,DRV28_PWROK,      
			                     DRV27_PWROK,DRV26_PWROK,DRV25_PWROK,DRV24_PWROK       }  ),
			.DIN4           (  { 4'h0,DRV35_PWROK,DRV34_PWROK,DRV33_PWROK,DRV32_PWROK  }  ),
			//.DIN0           (  { DRV19_PWROK,DRV18_PWROK,DRV17_PWROK,DRV16_PWROK,
			//                     DRV15_PWROK,DRV14_PWROK,DRV13_PWROK,DRV12_PWROK  }  ),
			//.DIN1           (  { DRV27_PWROK,DRV26_PWROK,DRV25_PWROK,DRV24_PWROK,      
			//                     DRV23_PWROK,DRV22_PWROK,DRV21_PWROK,DRV20_PWROK  }  ),
			//.DIN2           (  { DRV35_PWROK,DRV34_PWROK,DRV33_PWROK,DRV32_PWROK,      
			//                     DRV31_PWROK,DRV30_PWROK,DRV29_PWROK,DRV28_PWROK  }  ),
            //.DIN3           (  ),
            //.DIN4           (  ),			
			.DIN5           (  ),
			.DIN6           (  ),
			.DIN7           (  ),
			.DIN8           (  ),
			.DIN9           (  ),
			.DIN10          (  ),
			.DIN11          (  ),
			.DIN12          (  ),
			.DIN13          (  ),
			.DIN14          (  ),
			.DIN15          (  )
			);

//FAULT AMBER LED 40H 50H
; for ($i=0; $i<18; $i++) {
wire    [7:0]  FLT_AMB_LED${i};
; }

GPO    GPO4_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[4]),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_4_1),						
			.RD_WR1		    (RD_WR_1),
			.DIN1			(I2C_DOUT_1),
			
			.PORT_CS2		(PORT_CS_2[4]),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_4_2),						
			.RD_WR2		    (RD_WR_2),
			.DIN2			(I2C_DOUT_2),

			.DO0		    (FLT_AMB_LED0 ),
			.DO1		    (FLT_AMB_LED1 ),
			.DO2		    (FLT_AMB_LED2 ),
			.DO3		    (FLT_AMB_LED3 ),
			.DO4		    (FLT_AMB_LED4 ),
			.DO5		    (FLT_AMB_LED5 ),
			.DO6		    (FLT_AMB_LED6 ),
			.DO7		    (FLT_AMB_LED7 ),
			.DO8		    (FLT_AMB_LED8 ),
			.DO9		    (FLT_AMB_LED9 ),
			.DO10		    (FLT_AMB_LED10),
			.DO11		    (FLT_AMB_LED11),
			.DO12		    (FLT_AMB_LED12),
			.DO13		    (FLT_AMB_LED13),
			.DO14		    (FLT_AMB_LED14),
			.DO15		    (FLT_AMB_LED15)
			);

GPO    GPO5_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[5]),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_5_1),						
			.RD_WR1		    (RD_WR_1),
			.DIN1			(I2C_DOUT_1),
			
			.PORT_CS2		(PORT_CS_2[5]),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_5_2),						
			.RD_WR2		    (RD_WR_2),
			.DIN2			(I2C_DOUT_2),

			.DO0		    (FLT_AMB_LED16 ),
			.DO1		    (FLT_AMB_LED17 ),
			.DO2		    (),
			.DO3		    (),
			.DO4		    (),
			.DO5		    (),
			.DO6		    (),
			.DO7		    (),
			.DO8		    (),
			.DO9		    (),
			.DO10		    (),
			.DO11		    (),
			.DO12		    (),
			.DO13		    (),
			.DO14		    (),
			.DO15		    ()
			);

//IFDET_BLUE_LED 60H 70H
; for ($i=0; $i<18; $i++) {
wire    [7:0]  IFDET_BLUE_LED${i};
; }

GPO    GPO6_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[6]),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_6_1),						
			.RD_WR1		    (RD_WR_1),
			.DIN1			(I2C_DOUT_1),
			
			.PORT_CS2		(PORT_CS_2[6]),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_6_2),						
			.RD_WR2		    (RD_WR_2),
			.DIN2			(I2C_DOUT_2),

			.DO0		    (IFDET_BLUE_LED0 ),
			.DO1		    (IFDET_BLUE_LED1 ),
			.DO2		    (IFDET_BLUE_LED2 ),
			.DO3		    (IFDET_BLUE_LED3 ),
			.DO4		    (IFDET_BLUE_LED4 ),
			.DO5		    (IFDET_BLUE_LED5 ),
			.DO6		    (IFDET_BLUE_LED6 ),
			.DO7		    (IFDET_BLUE_LED7 ),
			.DO8		    (IFDET_BLUE_LED8 ),
			.DO9		    (IFDET_BLUE_LED9 ),
			.DO10		    (IFDET_BLUE_LED10),
			.DO11		    (IFDET_BLUE_LED11),
			.DO12		    (IFDET_BLUE_LED12),
			.DO13		    (IFDET_BLUE_LED13),
			.DO14		    (IFDET_BLUE_LED14),
			.DO15		    (IFDET_BLUE_LED15)
			);

GPO    GPO7_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[7]),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_7_1),						
			.RD_WR1		    (RD_WR_1),
			.DIN1			(I2C_DOUT_1),
			
			.PORT_CS2		(PORT_CS_2[7]),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_7_2),						
			.RD_WR2		    (RD_WR_2),
			.DIN2			(I2C_DOUT_2),

			.DO0		    (IFDET_BLUE_LED16 ),
			.DO1		    (IFDET_BLUE_LED17 ),
			.DO2		    (),
			.DO3		    (),
			.DO4		    (),
			.DO5		    (),
			.DO6		    (),
			.DO7		    (),
			.DO8		    (),
			.DO9		    (),
			.DO10		    (),
			.DO11		    (),
			.DO12		    (),
			.DO13		    (),
			.DO14		    (),
			.DO15		    ()
			);

//CANISTER_A_PCIE_CLK_ACT_L,CANISTER_B_PCIE_CLK_ACT_L 80H CPLD_SLOT_ID 81H
GPI    	GPI8_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[8]),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_8_1),						
			.RD_WR1		    (RD_WR_1),
			
			.PORT_CS2		(PORT_CS_2[8]),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_8_2),						
			.RD_WR2		    (RD_WR_2),
			
			.DIN0           (  { ~CANISTER_B_PCIE_CLK_ACT_L,~CANISTER_A_PCIE_CLK_ACT_L }  ),
			.DIN1           (  { 7'b0,CPLD_SLOT_ID                                   }  ),
			.DIN2           (  0                          ),
			.DIN3           (  0                          ),
			.DIN4           (  0                          ),			
			.DIN5           (  0                          ),
			.DIN6           (  0                          ),
			.DIN7           (  0                          ),
			.DIN8           (  0                          ),
			.DIN9           (  0                          ),
			.DIN10          (  0                          ),
			.DIN11          (  0                          ),
			.DIN12          (  0                          ),
			.DIN13          (  0                          ),
			.DIN14          (  0                          ),
			.DIN15          (  0                          )
			);

//BB_CPLD_ALT_L 90H
GPI    	GPI9_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[9]),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_9_1),						
			.RD_WR1		    (RD_WR_1),
			
			.PORT_CS2		(PORT_CS_2[9]),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_9_2),						
			.RD_WR2		    (RD_WR_2),
			
			.DIN0           ( {7'b0,BB_CPLD_ALT_L} ),
			.DIN1           (  0                   ),
			.DIN2           (  0                   ),
			.DIN3           (  0                   ),
			.DIN4           (  0                   ),			
			.DIN5           (  0                   ),
			.DIN6           (  0                   ),
			.DIN7           (  0                   ),
			.DIN8           (  0                   ),
			.DIN9           (  0                   ),
			.DIN10          (  0                   ),
			.DIN11          (  0                   ),
			.DIN12          (  0                   ),
			.DIN13          (  0                   ),
			.DIN14          (  0                   ),
			.DIN15          (  0                   )
			);

// A0H
GPO    GPOA_INST (
			.RESET_N		(RESET_N),
			.SYSCLK			(SYSCLK),
			
			.PORT_CS1		(PORT_CS_1[10]),
			.OFFSET_SEL1	(OFFSET_SEL_1),
			.DOUT1			(DIN_A_1),						
			.RD_WR1		    (RD_WR_1),
			.DIN1			(I2C_DOUT_1),
			
			.PORT_CS2		(PORT_CS_2[10]),
			.OFFSET_SEL2	(OFFSET_SEL_2),
			.DOUT2			(DIN_A_2),						
			.RD_WR2		    (RD_WR_2),
			.DIN2			(I2C_DOUT_2),

			.DO0		    ( STATUS_BOARD_PRSENT ),
			.DO1		    (                     ),
			.DO2		    (                     ),
			.DO3		    (                     ),
			.DO4		    (                     ),
			.DO5		    (                     ),
			.DO6		    (                     ),
			.DO7		    (                     ),
			.DO8		    (                     ),
			.DO9		    (                     ),
			.DO10		    (                     ),
			.DO11		    (                     ),
			.DO12		    (                     ),
			.DO13		    (                     ),
			.DO14		    (                     ),
			.DO15		    (                     )
			);
			
//LED CONTROL
LED_CNT	LED_CNT_INST (
			.SYSCLK				    (SYSCLK),
			.RESET_N			    (RESET_N),
			.CLK_1HZ			    (CLK_1HZ),
			.CLK_2HZ			    (CLK_2HZ),
			.CLK_4HZ			    (CLK_4HZ),
			.CLK_4HZ_500MS		    (CLK_4HZ_500MS),
			.CLK_4HZ_3500MS	        (CLK_4HZ_3500MS),
			.CLK_07S			    (CLK_07S)
			);

//Fault Amber LED
LED FLT_AMB_LED_INST0(
            .SYSCLK					(SYSCLK),
            .RESET_N				(RESET_N),
            .CLK_1HZ				(CLK_1HZ),
            .CLK_2HZ				(CLK_2HZ),
            .CLK_4HZ				(CLK_4HZ),
            .CLK_4HZ_500MS          (CLK_4HZ_500MS),
            .CLK_4HZ_3500MS         (CLK_4HZ_3500MS),
            .CLK_07S				(CLK_07S),
			
; for ($i=0,$j=0; $i<8,$j<8; $i++,$j++) { 			
            .LED_REG${i}               (FLT_AMB_LED${j}),
; }
 
; for ($i=0,$j=0; $i<15,$j<15; $i++,$j++) { 	
            .LED${i}                   (AMBER_DAT[${j}]),
; }
            .LED15                  (AMBER_DAT[15])
		);

LED FLT_AMB_LED_INST1(
            .SYSCLK					(SYSCLK),
            .RESET_N				(RESET_N),
            .CLK_1HZ				(CLK_1HZ),
            .CLK_2HZ				(CLK_2HZ),
            .CLK_4HZ				(CLK_4HZ),
            .CLK_4HZ_500MS          (CLK_4HZ_500MS),
            .CLK_4HZ_3500MS         (CLK_4HZ_3500MS),
            .CLK_07S				(CLK_07S),

; for ($i=0,$j=8; $i<8,$j<16; $i++,$j++) { 			
            .LED_REG${i}               (FLT_AMB_LED${j}),
; }
 
; for ($i=0,$j=16; $i<15,$j<31; $i++,$j++) { 
            .LED${i}                   (AMBER_DAT[${j}]),
; }
            .LED15                  (AMBER_DAT[31])
		);

LED FLT_AMB_LED_INST2(
            .SYSCLK					(SYSCLK),
            .RESET_N				(RESET_N),
            .CLK_1HZ				(CLK_1HZ),
            .CLK_2HZ				(CLK_2HZ),
            .CLK_4HZ				(CLK_4HZ),
            .CLK_4HZ_500MS          (CLK_4HZ_500MS),
            .CLK_4HZ_3500MS         (CLK_4HZ_3500MS),
            .CLK_07S				(CLK_07S),

            .LED_REG0               (FLT_AMB_LED16),
            .LED_REG1               (FLT_AMB_LED17),
            .LED_REG2               (),
            .LED_REG3               (),
            .LED_REG4               (),
            .LED_REG5               (),
            .LED_REG6               (),
            .LED_REG7               (),
                                    
            .LED0                   (AMBER_DAT[32]),
            .LED1                   (AMBER_DAT[33]),
            .LED2                   (AMBER_DAT[34]),
            .LED3                   (AMBER_DAT[35]),
            .LED4                   (),
            .LED5                   (),
            .LED6                   (),
            .LED7                   (),
            .LED8                   (),
            .LED9                   (),
            .LED10                  (),
            .LED11                  (),
            .LED12                  (),
            .LED13                  (),
            .LED14                  (),
            .LED15                  ()
		);

//IFDEF BLUE LED
LED IFDET_BLUE_LED_INST0(
            .SYSCLK					(SYSCLK),
            .RESET_N				(RESET_N),
            .CLK_1HZ				(CLK_1HZ),
            .CLK_2HZ				(CLK_2HZ),
            .CLK_4HZ				(CLK_4HZ),
            .CLK_4HZ_500MS          (CLK_4HZ_500MS),
            .CLK_4HZ_3500MS         (CLK_4HZ_3500MS),
            .CLK_07S				(CLK_07S),
			
; for ($i=0,$j=0; $i<8,$j<8; $i++,$j++) { 			
            .LED_REG${i}               (IFDET_BLUE_LED${j}),
; }
 
; for ($i=0,$j=0; $i<15,$j<15; $i++,$j++) { 	
            .LED${i}                   (BLUE_DAT[${j}]),
; }
            .LED15                  (BLUE_DAT[15])
		);

LED IFDET_BLUE_LED_INST1(
            .SYSCLK					(SYSCLK),
            .RESET_N				(RESET_N),
            .CLK_1HZ				(CLK_1HZ),
            .CLK_2HZ				(CLK_2HZ),
            .CLK_4HZ				(CLK_4HZ),
            .CLK_4HZ_500MS          (CLK_4HZ_500MS),
            .CLK_4HZ_3500MS         (CLK_4HZ_3500MS),
            .CLK_07S				(CLK_07S),

; for ($i=0,$j=8; $i<8,$j<16; $i++,$j++) { 			
            .LED_REG${i}               (IFDET_BLUE_LED${j}),
; }
 
; for ($i=0,$j=16; $i<15,$j<31; $i++,$j++) { 
            .LED${i}                   (BLUE_DAT[${j}]),
; }
            .LED15                  (BLUE_DAT[31])
		);

LED IFDET_BLUE_LED_INST2(
            .SYSCLK					(SYSCLK),
            .RESET_N				(RESET_N),
            .CLK_1HZ				(CLK_1HZ),
            .CLK_2HZ				(CLK_2HZ),
            .CLK_4HZ				(CLK_4HZ),
            .CLK_4HZ_500MS          (CLK_4HZ_500MS),
            .CLK_4HZ_3500MS         (CLK_4HZ_3500MS),
            .CLK_07S				(CLK_07S),

            .LED_REG0               (IFDET_BLUE_LED16),
            .LED_REG1               (IFDET_BLUE_LED17),
            .LED_REG2               (),
            .LED_REG3               (),
            .LED_REG4               (),
            .LED_REG5               (),
            .LED_REG6               (),
            .LED_REG7               (),
                                    
            .LED0                   (BLUE_DAT[32]),
            .LED1                   (BLUE_DAT[33]),
            .LED2                   (BLUE_DAT[34]),
            .LED3                   (BLUE_DAT[35]),
            .LED4                   (),
            .LED5                   (),
            .LED6                   (),
            .LED7                   (),
            .LED8                   (),
            .LED9                   (),
            .LED10                  (),
            .LED11                  (),
            .LED12                  (),
            .LED13                  (),
            .LED14                  (),
            .LED15                  ()
		);

//PRESENT LED CONTROL
PRSNT_LED_CTRL PRSNT_LED_CTRL_INST(
            .SYSCLK					(SYSCLK),
            .RESET_N				(RESET_N),
			// Driver present and amber LED inout
; for ($i=0; $i<36; $i++) {
			.DRV${i}_PRSNT_AMBER_LED    (DRV${i}_PRSNT_AMBER_LED),
; }
            // Driver identify and blue LED inout
; for ($i=0; $i<36; $i++) {
			.DRV${i}_IFDET_BLUE_LED     (DRV${i}_IFDET_BLUE_LED),
; }
            //input
            .AMBER_DAT                  (AMBER_DAT),
			.BLUE_DAT                   (BLUE_DAT),
			//output
			.PRSNT                      (PRSNT),
			.IDENT                      (IDENT)			
        );		

//PCIE RESET CONTROL
PCIE_RST_CTRL  PCIE_RST_CTRL (
            //POWER OK
; for ($i=0; $i<24; $i++) {
; $j=$i+12;
            .DRV${i}_PWROK                  (DRV${j}_PWROK ),
; }
            //RESET A
; for ($i=0; $i<24; $i++) {
            .PE_RST_DRV${i}_A_L          ( PE_RST_DRV${i}_A_L ),
; }
            //RESET B
; for ($i=0; $i<24; $i++) {
            .PE_RST_DRV${i}_B_L          ( PE_RST_DRV${i}_B_L ),
; }
            .SYSCLK					     (SYSCLK),
            .RESET_N				     (RESET_N)
);

//BB_SGPIO
BB_SGPIO  BB_SGPIO_INST (
            // Driver active led input
; for ($i=0; $i<36; $i++) {
            .DRV${i}_ACT_LED                  ( DRV${i}_ACT_LED ),
; }
            .SGPIO_CK                         ( SGPIO_CK                      ),
            .SGPIO_LD                         ( SGPIO_LD                      ),
            .SGPIO_DATA                       ( SGPIO_DATA                    ),
            .SYSCLK					          ( SYSCLK                        ),
            .RESET_N				          ( RESET_N & STATUS_BOARD_PRSENT )
            );

//Heart Beat
reg    [31:0]  CNT;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
			    CNT                    <= 32'h0;
				HEART                  <= 1'b0;
			end
		else
		    begin
			    CNT                    <= (CNT < `TIME_1S)? (CNT + 32'd1) : 32'd0;
				HEART                  <= (CNT == `TIME_1S)? ~HEART : HEART;
			end
	end
			
endmodule
