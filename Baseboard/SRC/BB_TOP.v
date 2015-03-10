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
            input     DRV3_ACT_LED,DRV2_ACT_LED,DRV1_ACT_LED,DRV0_ACT_LED,
            input     DRV7_ACT_LED,DRV6_ACT_LED,DRV5_ACT_LED,DRV4_ACT_LED,
            input     DRV11_ACT_LED,DRV10_ACT_LED,DRV9_ACT_LED,DRV8_ACT_LED,
            input     DRV15_ACT_LED,DRV14_ACT_LED,DRV13_ACT_LED,DRV12_ACT_LED,
            input     DRV19_ACT_LED,DRV18_ACT_LED,DRV17_ACT_LED,DRV16_ACT_LED,
            input     DRV23_ACT_LED,DRV22_ACT_LED,DRV21_ACT_LED,DRV20_ACT_LED,
            input     DRV27_ACT_LED,DRV26_ACT_LED,DRV25_ACT_LED,DRV24_ACT_LED,
            input     DRV31_ACT_LED,DRV30_ACT_LED,DRV29_ACT_LED,DRV28_ACT_LED,
            input     DRV35_ACT_LED,DRV34_ACT_LED,DRV33_ACT_LED,DRV32_ACT_LED,
            // Driver power enable output
            output    DRV3_PWR_EN_L,DRV2_PWR_EN_L,DRV1_PWR_EN_L,DRV0_PWR_EN_L,
            output    DRV7_PWR_EN_L,DRV6_PWR_EN_L,DRV5_PWR_EN_L,DRV4_PWR_EN_L,
            output    DRV11_PWR_EN_L,DRV10_PWR_EN_L,DRV9_PWR_EN_L,DRV8_PWR_EN_L,
            output    DRV15_PWR_EN_L,DRV14_PWR_EN_L,DRV13_PWR_EN_L,DRV12_PWR_EN_L,
            output    DRV19_PWR_EN_L,DRV18_PWR_EN_L,DRV17_PWR_EN_L,DRV16_PWR_EN_L,
            output    DRV23_PWR_EN_L,DRV22_PWR_EN_L,DRV21_PWR_EN_L,DRV20_PWR_EN_L,
            output    DRV27_PWR_EN_L,DRV26_PWR_EN_L,DRV25_PWR_EN_L,DRV24_PWR_EN_L,
            output    DRV31_PWR_EN_L,DRV30_PWR_EN_L,DRV29_PWR_EN_L,DRV28_PWR_EN_L,
            output    DRV35_PWR_EN_L,DRV34_PWR_EN_L,DRV33_PWR_EN_L,DRV32_PWR_EN_L,
            // Driver power ok input
            input     DRV15_PWROK,DRV14_PWROK,DRV13_PWROK,DRV12_PWROK,
            input     DRV19_PWROK,DRV18_PWROK,DRV17_PWROK,DRV16_PWROK,
            input     DRV23_PWROK,DRV22_PWROK,DRV21_PWROK,DRV20_PWROK,
            input     DRV27_PWROK,DRV26_PWROK,DRV25_PWROK,DRV24_PWROK,
            input     DRV31_PWROK,DRV30_PWROK,DRV29_PWROK,DRV28_PWROK,
            input     DRV35_PWROK,DRV34_PWROK,DRV33_PWROK,DRV32_PWROK,
            // Driver present and amber LED inout
			inout     DRV3_PRSNT_AMBER_LED,DRV2_PRSNT_AMBER_LED,DRV1_PRSNT_AMBER_LED,DRV0_PRSNT_AMBER_LED,
			inout     DRV7_PRSNT_AMBER_LED,DRV6_PRSNT_AMBER_LED,DRV5_PRSNT_AMBER_LED,DRV4_PRSNT_AMBER_LED,
			inout     DRV11_PRSNT_AMBER_LED,DRV10_PRSNT_AMBER_LED,DRV9_PRSNT_AMBER_LED,DRV8_PRSNT_AMBER_LED,
			inout     DRV15_PRSNT_AMBER_LED,DRV14_PRSNT_AMBER_LED,DRV13_PRSNT_AMBER_LED,DRV12_PRSNT_AMBER_LED,
			inout     DRV19_PRSNT_AMBER_LED,DRV18_PRSNT_AMBER_LED,DRV17_PRSNT_AMBER_LED,DRV16_PRSNT_AMBER_LED,
			inout     DRV23_PRSNT_AMBER_LED,DRV22_PRSNT_AMBER_LED,DRV21_PRSNT_AMBER_LED,DRV20_PRSNT_AMBER_LED,
			inout     DRV27_PRSNT_AMBER_LED,DRV26_PRSNT_AMBER_LED,DRV25_PRSNT_AMBER_LED,DRV24_PRSNT_AMBER_LED,
			inout     DRV31_PRSNT_AMBER_LED,DRV30_PRSNT_AMBER_LED,DRV29_PRSNT_AMBER_LED,DRV28_PRSNT_AMBER_LED,
			inout     DRV35_PRSNT_AMBER_LED,DRV34_PRSNT_AMBER_LED,DRV33_PRSNT_AMBER_LED,DRV32_PRSNT_AMBER_LED,
            // Driver identify and blue LED inout
			inout     DRV3_IFDET_BLUE_LED,DRV2_IFDET_BLUE_LED,DRV1_IFDET_BLUE_LED,DRV0_IFDET_BLUE_LED,
			inout     DRV7_IFDET_BLUE_LED,DRV6_IFDET_BLUE_LED,DRV5_IFDET_BLUE_LED,DRV4_IFDET_BLUE_LED,
			inout     DRV11_IFDET_BLUE_LED,DRV10_IFDET_BLUE_LED,DRV9_IFDET_BLUE_LED,DRV8_IFDET_BLUE_LED,
			inout     DRV15_IFDET_BLUE_LED,DRV14_IFDET_BLUE_LED,DRV13_IFDET_BLUE_LED,DRV12_IFDET_BLUE_LED,
			inout     DRV19_IFDET_BLUE_LED,DRV18_IFDET_BLUE_LED,DRV17_IFDET_BLUE_LED,DRV16_IFDET_BLUE_LED,
			inout     DRV23_IFDET_BLUE_LED,DRV22_IFDET_BLUE_LED,DRV21_IFDET_BLUE_LED,DRV20_IFDET_BLUE_LED,
			inout     DRV27_IFDET_BLUE_LED,DRV26_IFDET_BLUE_LED,DRV25_IFDET_BLUE_LED,DRV24_IFDET_BLUE_LED,
			inout     DRV31_IFDET_BLUE_LED,DRV30_IFDET_BLUE_LED,DRV29_IFDET_BLUE_LED,DRV28_IFDET_BLUE_LED,
			inout     DRV35_IFDET_BLUE_LED,DRV34_IFDET_BLUE_LED,DRV33_IFDET_BLUE_LED,DRV32_IFDET_BLUE_LED,
            // PCIE reset portA output
            output    PE_RST_DRV3_A_L,PE_RST_DRV2_A_L,PE_RST_DRV1_A_L,PE_RST_DRV0_A_L,
            output    PE_RST_DRV7_A_L,PE_RST_DRV6_A_L,PE_RST_DRV5_A_L,PE_RST_DRV4_A_L,
            output    PE_RST_DRV11_A_L,PE_RST_DRV10_A_L,PE_RST_DRV9_A_L,PE_RST_DRV8_A_L,
            output    PE_RST_DRV15_A_L,PE_RST_DRV14_A_L,PE_RST_DRV13_A_L,PE_RST_DRV12_A_L,
            output    PE_RST_DRV19_A_L,PE_RST_DRV18_A_L,PE_RST_DRV17_A_L,PE_RST_DRV16_A_L,
            output    PE_RST_DRV23_A_L,PE_RST_DRV22_A_L,PE_RST_DRV21_A_L,PE_RST_DRV20_A_L,
            // PCIE reset portB output
            output    PE_RST_DRV3_B_L,PE_RST_DRV2_B_L,PE_RST_DRV1_B_L,PE_RST_DRV0_B_L,
            output    PE_RST_DRV7_B_L,PE_RST_DRV6_B_L,PE_RST_DRV5_B_L,PE_RST_DRV4_B_L,
            output    PE_RST_DRV11_B_L,PE_RST_DRV10_B_L,PE_RST_DRV9_B_L,PE_RST_DRV8_B_L,
            output    PE_RST_DRV15_B_L,PE_RST_DRV14_B_L,PE_RST_DRV13_B_L,PE_RST_DRV12_B_L,
            output    PE_RST_DRV19_B_L,PE_RST_DRV18_B_L,PE_RST_DRV17_B_L,PE_RST_DRV16_B_L,
            output    PE_RST_DRV23_B_L,PE_RST_DRV22_B_L,PE_RST_DRV21_B_L,PE_RST_DRV20_B_L,
            // PCIE clock OE portA output
            output    DRV15_PCIE_CLK_A_OE_L,DRV14_PCIE_CLK_A_OE_L,DRV13_PCIE_CLK_A_OE_L,DRV12_PCIE_CLK_A_OE_L,
            output    DRV19_PCIE_CLK_A_OE_L,DRV18_PCIE_CLK_A_OE_L,DRV17_PCIE_CLK_A_OE_L,DRV16_PCIE_CLK_A_OE_L,
            output    DRV23_PCIE_CLK_A_OE_L,DRV22_PCIE_CLK_A_OE_L,DRV21_PCIE_CLK_A_OE_L,DRV20_PCIE_CLK_A_OE_L,
            output    DRV27_PCIE_CLK_A_OE_L,DRV26_PCIE_CLK_A_OE_L,DRV25_PCIE_CLK_A_OE_L,DRV24_PCIE_CLK_A_OE_L,
            output    DRV31_PCIE_CLK_A_OE_L,DRV30_PCIE_CLK_A_OE_L,DRV29_PCIE_CLK_A_OE_L,DRV28_PCIE_CLK_A_OE_L,
            output    DRV35_PCIE_CLK_A_OE_L,DRV34_PCIE_CLK_A_OE_L,DRV33_PCIE_CLK_A_OE_L,DRV32_PCIE_CLK_A_OE_L,
            // PCIE clock OE portB output
            output    DRV15_PCIE_CLK_B_OE_L,DRV14_PCIE_CLK_B_OE_L,DRV13_PCIE_CLK_B_OE_L,DRV12_PCIE_CLK_B_OE_L,
            output    DRV19_PCIE_CLK_B_OE_L,DRV18_PCIE_CLK_B_OE_L,DRV17_PCIE_CLK_B_OE_L,DRV16_PCIE_CLK_B_OE_L,
            output    DRV23_PCIE_CLK_B_OE_L,DRV22_PCIE_CLK_B_OE_L,DRV21_PCIE_CLK_B_OE_L,DRV20_PCIE_CLK_B_OE_L,
            output    DRV27_PCIE_CLK_B_OE_L,DRV26_PCIE_CLK_B_OE_L,DRV25_PCIE_CLK_B_OE_L,DRV24_PCIE_CLK_B_OE_L,
            output    DRV31_PCIE_CLK_B_OE_L,DRV30_PCIE_CLK_B_OE_L,DRV29_PCIE_CLK_B_OE_L,DRV28_PCIE_CLK_B_OE_L,
            output    DRV35_PCIE_CLK_B_OE_L,DRV34_PCIE_CLK_B_OE_L,DRV33_PCIE_CLK_B_OE_L,DRV32_PCIE_CLK_B_OE_L,
            // Enclosure Signals
            input     BB_CPLD_ALT_L,
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

//Present output signal from PRSNT_LED_CTRL.v
wire    [35:0]  PRSNT;
wire    [35:0]  IDENT;
//LED input signal to PRSNT_LED_CTRL.v
wire    [35:0]  AMBER_DAT;
wire    [35:0]  BLUE_DAT;

//CLOCK OE
// PCIE clock OE portA output
assign    DRV12_PCIE_CLK_A_OE_L = DRV12_PWR_EN_L;
assign    DRV13_PCIE_CLK_A_OE_L = DRV13_PWR_EN_L;
assign    DRV14_PCIE_CLK_A_OE_L = DRV14_PWR_EN_L;
assign    DRV15_PCIE_CLK_A_OE_L = DRV15_PWR_EN_L;
assign    DRV16_PCIE_CLK_A_OE_L = DRV16_PWR_EN_L;
assign    DRV17_PCIE_CLK_A_OE_L = DRV17_PWR_EN_L;
assign    DRV18_PCIE_CLK_A_OE_L = DRV18_PWR_EN_L;
assign    DRV19_PCIE_CLK_A_OE_L = DRV19_PWR_EN_L;
assign    DRV20_PCIE_CLK_A_OE_L = DRV20_PWR_EN_L;
assign    DRV21_PCIE_CLK_A_OE_L = DRV21_PWR_EN_L;
assign    DRV22_PCIE_CLK_A_OE_L = DRV22_PWR_EN_L;
assign    DRV23_PCIE_CLK_A_OE_L = DRV23_PWR_EN_L;
assign    DRV24_PCIE_CLK_A_OE_L = DRV24_PWR_EN_L;
assign    DRV25_PCIE_CLK_A_OE_L = DRV25_PWR_EN_L;
assign    DRV26_PCIE_CLK_A_OE_L = DRV26_PWR_EN_L;
assign    DRV27_PCIE_CLK_A_OE_L = DRV27_PWR_EN_L;
assign    DRV28_PCIE_CLK_A_OE_L = DRV28_PWR_EN_L;
assign    DRV29_PCIE_CLK_A_OE_L = DRV29_PWR_EN_L;
assign    DRV30_PCIE_CLK_A_OE_L = DRV30_PWR_EN_L;
assign    DRV31_PCIE_CLK_A_OE_L = DRV31_PWR_EN_L;
assign    DRV32_PCIE_CLK_A_OE_L = DRV32_PWR_EN_L;
assign    DRV33_PCIE_CLK_A_OE_L = DRV33_PWR_EN_L;
assign    DRV34_PCIE_CLK_A_OE_L = DRV34_PWR_EN_L;
assign    DRV35_PCIE_CLK_A_OE_L = DRV35_PWR_EN_L;
// PCIE clock OE portB output
assign    DRV12_PCIE_CLK_B_OE_L = DRV12_PWR_EN_L;
assign    DRV13_PCIE_CLK_B_OE_L = DRV13_PWR_EN_L;
assign    DRV14_PCIE_CLK_B_OE_L = DRV14_PWR_EN_L;
assign    DRV15_PCIE_CLK_B_OE_L = DRV15_PWR_EN_L;
assign    DRV16_PCIE_CLK_B_OE_L = DRV16_PWR_EN_L;
assign    DRV17_PCIE_CLK_B_OE_L = DRV17_PWR_EN_L;
assign    DRV18_PCIE_CLK_B_OE_L = DRV18_PWR_EN_L;
assign    DRV19_PCIE_CLK_B_OE_L = DRV19_PWR_EN_L;
assign    DRV20_PCIE_CLK_B_OE_L = DRV20_PWR_EN_L;
assign    DRV21_PCIE_CLK_B_OE_L = DRV21_PWR_EN_L;
assign    DRV22_PCIE_CLK_B_OE_L = DRV22_PWR_EN_L;
assign    DRV23_PCIE_CLK_B_OE_L = DRV23_PWR_EN_L;
assign    DRV24_PCIE_CLK_B_OE_L = DRV24_PWR_EN_L;
assign    DRV25_PCIE_CLK_B_OE_L = DRV25_PWR_EN_L;
assign    DRV26_PCIE_CLK_B_OE_L = DRV26_PWR_EN_L;
assign    DRV27_PCIE_CLK_B_OE_L = DRV27_PWR_EN_L;
assign    DRV28_PCIE_CLK_B_OE_L = DRV28_PWR_EN_L;
assign    DRV29_PCIE_CLK_B_OE_L = DRV29_PWR_EN_L;
assign    DRV30_PCIE_CLK_B_OE_L = DRV30_PWR_EN_L;
assign    DRV31_PCIE_CLK_B_OE_L = DRV31_PWR_EN_L;
assign    DRV32_PCIE_CLK_B_OE_L = DRV32_PWR_EN_L;
assign    DRV33_PCIE_CLK_B_OE_L = DRV33_PWR_EN_L;
assign    DRV34_PCIE_CLK_B_OE_L = DRV34_PWR_EN_L;
assign    DRV35_PCIE_CLK_B_OE_L = DRV35_PWR_EN_L;

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

//POWER ENABLE 20H
wire  [7:0]  DRV_PWR_EN0,DRV_PWR_EN1,DRV_PWR_EN2,DRV_PWR_EN3,DRV_PWR_EN4;
assign    DRV0_PWR_EN_L = !(DRV_PWR_EN0[0] && PRSNT[0]);
assign    DRV1_PWR_EN_L = !(DRV_PWR_EN0[1] && PRSNT[1]);
assign    DRV2_PWR_EN_L = !(DRV_PWR_EN0[2] && PRSNT[2]);
assign    DRV3_PWR_EN_L = !(DRV_PWR_EN0[3] && PRSNT[3]);
assign    DRV4_PWR_EN_L = !(DRV_PWR_EN0[4] && PRSNT[4]);
assign    DRV5_PWR_EN_L = !(DRV_PWR_EN0[5] && PRSNT[5]);
assign    DRV6_PWR_EN_L = !(DRV_PWR_EN0[6] && PRSNT[6]);
assign    DRV7_PWR_EN_L = !(DRV_PWR_EN0[7] && PRSNT[7]);
assign    DRV8_PWR_EN_L = !(DRV_PWR_EN1[0] && PRSNT[8]);
assign    DRV9_PWR_EN_L = !(DRV_PWR_EN1[1] && PRSNT[9]);
assign    DRV10_PWR_EN_L = !(DRV_PWR_EN1[2] && PRSNT[10]);
assign    DRV11_PWR_EN_L = !(DRV_PWR_EN1[3] && PRSNT[11]);
assign    DRV12_PWR_EN_L = !(DRV_PWR_EN1[4] && PRSNT[12]);
assign    DRV13_PWR_EN_L = !(DRV_PWR_EN1[5] && PRSNT[13]);
assign    DRV14_PWR_EN_L = !(DRV_PWR_EN1[6] && PRSNT[14]);
assign    DRV15_PWR_EN_L = !(DRV_PWR_EN1[7] && PRSNT[15]);
assign    DRV16_PWR_EN_L = !(DRV_PWR_EN2[0] && PRSNT[16]);
assign    DRV17_PWR_EN_L = !(DRV_PWR_EN2[1] && PRSNT[17]);
assign    DRV18_PWR_EN_L = !(DRV_PWR_EN2[2] && PRSNT[18]);
assign    DRV19_PWR_EN_L = !(DRV_PWR_EN2[3] && PRSNT[19]);
assign    DRV20_PWR_EN_L = !(DRV_PWR_EN2[4] && PRSNT[20]);
assign    DRV21_PWR_EN_L = !(DRV_PWR_EN2[5] && PRSNT[21]);
assign    DRV22_PWR_EN_L = !(DRV_PWR_EN2[6] && PRSNT[22]);
assign    DRV23_PWR_EN_L = !(DRV_PWR_EN2[7] && PRSNT[23]);
assign    DRV24_PWR_EN_L = !(DRV_PWR_EN3[0] && PRSNT[24]);
assign    DRV25_PWR_EN_L = !(DRV_PWR_EN3[1] && PRSNT[25]);
assign    DRV26_PWR_EN_L = !(DRV_PWR_EN3[2] && PRSNT[26]);
assign    DRV27_PWR_EN_L = !(DRV_PWR_EN3[3] && PRSNT[27]);
assign    DRV28_PWR_EN_L = !(DRV_PWR_EN3[4] && PRSNT[28]);
assign    DRV29_PWR_EN_L = !(DRV_PWR_EN3[5] && PRSNT[29]);
assign    DRV30_PWR_EN_L = !(DRV_PWR_EN3[6] && PRSNT[30]);
assign    DRV31_PWR_EN_L = !(DRV_PWR_EN3[7] && PRSNT[31]);
assign    DRV32_PWR_EN_L = !(DRV_PWR_EN4[0] && PRSNT[32]);
assign    DRV33_PWR_EN_L = !(DRV_PWR_EN4[1] && PRSNT[33]);
assign    DRV34_PWR_EN_L = !(DRV_PWR_EN4[2] && PRSNT[34]);
assign    DRV35_PWR_EN_L = !(DRV_PWR_EN4[3] && PRSNT[35]);
// wire  [7:0]  DRV_PWR_EN0,DRV_PWR_EN1,DRV_PWR_EN2,DRV_PWR_EN3,DRV_PWR_EN4;
// ; for (4=0,36=0; 4<8,36<8; 4++,36++) {
// assign    DRV36_PWR_EN_L = 0;
// ; }
// ; for (4=0,36=8; 4<8,36<16; 4++,36++) {
// assign    DRV36_PWR_EN_L = 0;
// ; }
// ; for (4=0,36=16; 4<8,36<24; 4++,36++) {
// assign    DRV36_PWR_EN_L = 0;
// ; }
// ; for (4=0,36=24; 4<8,36<32; 4++,36++) {
// assign    DRV36_PWR_EN_L = 0;
// ; }
// ; for (4=0,36=32; 4<4,36<36; 4++,36++) {
// assign    DRV36_PWR_EN_L = 0;
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
			
			.DIN0           (  { DRV7_PWR_EN_L,DRV6_PWR_EN_L,DRV5_PWR_EN_L,DRV4_PWR_EN_L,
			                     DRV3_PWR_EN_L,DRV2_PWR_EN_L,DRV1_PWR_EN_L,DRV0_PWR_EN_L           }  ),
			.DIN1           (  { DRV15_PWROK,DRV14_PWROK,DRV13_PWROK,DRV12_PWROK,      
			                     DRV11_PWR_EN_L,DRV10_PWR_EN_L,DRV9_PWR_EN_L,DRV8_PWR_EN_L         }  ),
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
wire    [7:0]  FLT_AMB_LED0;
wire    [7:0]  FLT_AMB_LED1;
wire    [7:0]  FLT_AMB_LED2;
wire    [7:0]  FLT_AMB_LED3;
wire    [7:0]  FLT_AMB_LED4;
wire    [7:0]  FLT_AMB_LED5;
wire    [7:0]  FLT_AMB_LED6;
wire    [7:0]  FLT_AMB_LED7;
wire    [7:0]  FLT_AMB_LED8;
wire    [7:0]  FLT_AMB_LED9;
wire    [7:0]  FLT_AMB_LED10;
wire    [7:0]  FLT_AMB_LED11;
wire    [7:0]  FLT_AMB_LED12;
wire    [7:0]  FLT_AMB_LED13;
wire    [7:0]  FLT_AMB_LED14;
wire    [7:0]  FLT_AMB_LED15;
wire    [7:0]  FLT_AMB_LED16;
wire    [7:0]  FLT_AMB_LED17;

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
wire    [7:0]  IFDET_BLUE_LED0;
wire    [7:0]  IFDET_BLUE_LED1;
wire    [7:0]  IFDET_BLUE_LED2;
wire    [7:0]  IFDET_BLUE_LED3;
wire    [7:0]  IFDET_BLUE_LED4;
wire    [7:0]  IFDET_BLUE_LED5;
wire    [7:0]  IFDET_BLUE_LED6;
wire    [7:0]  IFDET_BLUE_LED7;
wire    [7:0]  IFDET_BLUE_LED8;
wire    [7:0]  IFDET_BLUE_LED9;
wire    [7:0]  IFDET_BLUE_LED10;
wire    [7:0]  IFDET_BLUE_LED11;
wire    [7:0]  IFDET_BLUE_LED12;
wire    [7:0]  IFDET_BLUE_LED13;
wire    [7:0]  IFDET_BLUE_LED14;
wire    [7:0]  IFDET_BLUE_LED15;
wire    [7:0]  IFDET_BLUE_LED16;
wire    [7:0]  IFDET_BLUE_LED17;

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
			
            .LED_REG0               (FLT_AMB_LED0),
            .LED_REG1               (FLT_AMB_LED1),
            .LED_REG2               (FLT_AMB_LED2),
            .LED_REG3               (FLT_AMB_LED3),
            .LED_REG4               (FLT_AMB_LED4),
            .LED_REG5               (FLT_AMB_LED5),
            .LED_REG6               (FLT_AMB_LED6),
            .LED_REG7               (FLT_AMB_LED7),
 
            .LED0                   (AMBER_DAT[0]),
            .LED1                   (AMBER_DAT[1]),
            .LED2                   (AMBER_DAT[2]),
            .LED3                   (AMBER_DAT[3]),
            .LED4                   (AMBER_DAT[4]),
            .LED5                   (AMBER_DAT[5]),
            .LED6                   (AMBER_DAT[6]),
            .LED7                   (AMBER_DAT[7]),
            .LED8                   (AMBER_DAT[8]),
            .LED9                   (AMBER_DAT[9]),
            .LED10                   (AMBER_DAT[10]),
            .LED11                   (AMBER_DAT[11]),
            .LED12                   (AMBER_DAT[12]),
            .LED13                   (AMBER_DAT[13]),
            .LED14                   (AMBER_DAT[14]),
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

            .LED_REG0               (FLT_AMB_LED8),
            .LED_REG1               (FLT_AMB_LED9),
            .LED_REG2               (FLT_AMB_LED10),
            .LED_REG3               (FLT_AMB_LED11),
            .LED_REG4               (FLT_AMB_LED12),
            .LED_REG5               (FLT_AMB_LED13),
            .LED_REG6               (FLT_AMB_LED14),
            .LED_REG7               (FLT_AMB_LED15),
 
            .LED0                   (AMBER_DAT[16]),
            .LED1                   (AMBER_DAT[17]),
            .LED2                   (AMBER_DAT[18]),
            .LED3                   (AMBER_DAT[19]),
            .LED4                   (AMBER_DAT[20]),
            .LED5                   (AMBER_DAT[21]),
            .LED6                   (AMBER_DAT[22]),
            .LED7                   (AMBER_DAT[23]),
            .LED8                   (AMBER_DAT[24]),
            .LED9                   (AMBER_DAT[25]),
            .LED10                   (AMBER_DAT[26]),
            .LED11                   (AMBER_DAT[27]),
            .LED12                   (AMBER_DAT[28]),
            .LED13                   (AMBER_DAT[29]),
            .LED14                   (AMBER_DAT[30]),
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
			
            .LED_REG0               (IFDET_BLUE_LED0),
            .LED_REG1               (IFDET_BLUE_LED1),
            .LED_REG2               (IFDET_BLUE_LED2),
            .LED_REG3               (IFDET_BLUE_LED3),
            .LED_REG4               (IFDET_BLUE_LED4),
            .LED_REG5               (IFDET_BLUE_LED5),
            .LED_REG6               (IFDET_BLUE_LED6),
            .LED_REG7               (IFDET_BLUE_LED7),
 
            .LED0                   (BLUE_DAT[0]),
            .LED1                   (BLUE_DAT[1]),
            .LED2                   (BLUE_DAT[2]),
            .LED3                   (BLUE_DAT[3]),
            .LED4                   (BLUE_DAT[4]),
            .LED5                   (BLUE_DAT[5]),
            .LED6                   (BLUE_DAT[6]),
            .LED7                   (BLUE_DAT[7]),
            .LED8                   (BLUE_DAT[8]),
            .LED9                   (BLUE_DAT[9]),
            .LED10                   (BLUE_DAT[10]),
            .LED11                   (BLUE_DAT[11]),
            .LED12                   (BLUE_DAT[12]),
            .LED13                   (BLUE_DAT[13]),
            .LED14                   (BLUE_DAT[14]),
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

            .LED_REG0               (IFDET_BLUE_LED8),
            .LED_REG1               (IFDET_BLUE_LED9),
            .LED_REG2               (IFDET_BLUE_LED10),
            .LED_REG3               (IFDET_BLUE_LED11),
            .LED_REG4               (IFDET_BLUE_LED12),
            .LED_REG5               (IFDET_BLUE_LED13),
            .LED_REG6               (IFDET_BLUE_LED14),
            .LED_REG7               (IFDET_BLUE_LED15),
 
            .LED0                   (BLUE_DAT[16]),
            .LED1                   (BLUE_DAT[17]),
            .LED2                   (BLUE_DAT[18]),
            .LED3                   (BLUE_DAT[19]),
            .LED4                   (BLUE_DAT[20]),
            .LED5                   (BLUE_DAT[21]),
            .LED6                   (BLUE_DAT[22]),
            .LED7                   (BLUE_DAT[23]),
            .LED8                   (BLUE_DAT[24]),
            .LED9                   (BLUE_DAT[25]),
            .LED10                   (BLUE_DAT[26]),
            .LED11                   (BLUE_DAT[27]),
            .LED12                   (BLUE_DAT[28]),
            .LED13                   (BLUE_DAT[29]),
            .LED14                   (BLUE_DAT[30]),
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
			.DRV0_PRSNT_AMBER_LED    (DRV0_PRSNT_AMBER_LED),
			.DRV1_PRSNT_AMBER_LED    (DRV1_PRSNT_AMBER_LED),
			.DRV2_PRSNT_AMBER_LED    (DRV2_PRSNT_AMBER_LED),
			.DRV3_PRSNT_AMBER_LED    (DRV3_PRSNT_AMBER_LED),
			.DRV4_PRSNT_AMBER_LED    (DRV4_PRSNT_AMBER_LED),
			.DRV5_PRSNT_AMBER_LED    (DRV5_PRSNT_AMBER_LED),
			.DRV6_PRSNT_AMBER_LED    (DRV6_PRSNT_AMBER_LED),
			.DRV7_PRSNT_AMBER_LED    (DRV7_PRSNT_AMBER_LED),
			.DRV8_PRSNT_AMBER_LED    (DRV8_PRSNT_AMBER_LED),
			.DRV9_PRSNT_AMBER_LED    (DRV9_PRSNT_AMBER_LED),
			.DRV10_PRSNT_AMBER_LED    (DRV10_PRSNT_AMBER_LED),
			.DRV11_PRSNT_AMBER_LED    (DRV11_PRSNT_AMBER_LED),
			.DRV12_PRSNT_AMBER_LED    (DRV12_PRSNT_AMBER_LED),
			.DRV13_PRSNT_AMBER_LED    (DRV13_PRSNT_AMBER_LED),
			.DRV14_PRSNT_AMBER_LED    (DRV14_PRSNT_AMBER_LED),
			.DRV15_PRSNT_AMBER_LED    (DRV15_PRSNT_AMBER_LED),
			.DRV16_PRSNT_AMBER_LED    (DRV16_PRSNT_AMBER_LED),
			.DRV17_PRSNT_AMBER_LED    (DRV17_PRSNT_AMBER_LED),
			.DRV18_PRSNT_AMBER_LED    (DRV18_PRSNT_AMBER_LED),
			.DRV19_PRSNT_AMBER_LED    (DRV19_PRSNT_AMBER_LED),
			.DRV20_PRSNT_AMBER_LED    (DRV20_PRSNT_AMBER_LED),
			.DRV21_PRSNT_AMBER_LED    (DRV21_PRSNT_AMBER_LED),
			.DRV22_PRSNT_AMBER_LED    (DRV22_PRSNT_AMBER_LED),
			.DRV23_PRSNT_AMBER_LED    (DRV23_PRSNT_AMBER_LED),
			.DRV24_PRSNT_AMBER_LED    (DRV24_PRSNT_AMBER_LED),
			.DRV25_PRSNT_AMBER_LED    (DRV25_PRSNT_AMBER_LED),
			.DRV26_PRSNT_AMBER_LED    (DRV26_PRSNT_AMBER_LED),
			.DRV27_PRSNT_AMBER_LED    (DRV27_PRSNT_AMBER_LED),
			.DRV28_PRSNT_AMBER_LED    (DRV28_PRSNT_AMBER_LED),
			.DRV29_PRSNT_AMBER_LED    (DRV29_PRSNT_AMBER_LED),
			.DRV30_PRSNT_AMBER_LED    (DRV30_PRSNT_AMBER_LED),
			.DRV31_PRSNT_AMBER_LED    (DRV31_PRSNT_AMBER_LED),
			.DRV32_PRSNT_AMBER_LED    (DRV32_PRSNT_AMBER_LED),
			.DRV33_PRSNT_AMBER_LED    (DRV33_PRSNT_AMBER_LED),
			.DRV34_PRSNT_AMBER_LED    (DRV34_PRSNT_AMBER_LED),
			.DRV35_PRSNT_AMBER_LED    (DRV35_PRSNT_AMBER_LED),
            // Driver identify and blue LED inout
			.DRV0_IFDET_BLUE_LED     (DRV0_IFDET_BLUE_LED),
			.DRV1_IFDET_BLUE_LED     (DRV1_IFDET_BLUE_LED),
			.DRV2_IFDET_BLUE_LED     (DRV2_IFDET_BLUE_LED),
			.DRV3_IFDET_BLUE_LED     (DRV3_IFDET_BLUE_LED),
			.DRV4_IFDET_BLUE_LED     (DRV4_IFDET_BLUE_LED),
			.DRV5_IFDET_BLUE_LED     (DRV5_IFDET_BLUE_LED),
			.DRV6_IFDET_BLUE_LED     (DRV6_IFDET_BLUE_LED),
			.DRV7_IFDET_BLUE_LED     (DRV7_IFDET_BLUE_LED),
			.DRV8_IFDET_BLUE_LED     (DRV8_IFDET_BLUE_LED),
			.DRV9_IFDET_BLUE_LED     (DRV9_IFDET_BLUE_LED),
			.DRV10_IFDET_BLUE_LED     (DRV10_IFDET_BLUE_LED),
			.DRV11_IFDET_BLUE_LED     (DRV11_IFDET_BLUE_LED),
			.DRV12_IFDET_BLUE_LED     (DRV12_IFDET_BLUE_LED),
			.DRV13_IFDET_BLUE_LED     (DRV13_IFDET_BLUE_LED),
			.DRV14_IFDET_BLUE_LED     (DRV14_IFDET_BLUE_LED),
			.DRV15_IFDET_BLUE_LED     (DRV15_IFDET_BLUE_LED),
			.DRV16_IFDET_BLUE_LED     (DRV16_IFDET_BLUE_LED),
			.DRV17_IFDET_BLUE_LED     (DRV17_IFDET_BLUE_LED),
			.DRV18_IFDET_BLUE_LED     (DRV18_IFDET_BLUE_LED),
			.DRV19_IFDET_BLUE_LED     (DRV19_IFDET_BLUE_LED),
			.DRV20_IFDET_BLUE_LED     (DRV20_IFDET_BLUE_LED),
			.DRV21_IFDET_BLUE_LED     (DRV21_IFDET_BLUE_LED),
			.DRV22_IFDET_BLUE_LED     (DRV22_IFDET_BLUE_LED),
			.DRV23_IFDET_BLUE_LED     (DRV23_IFDET_BLUE_LED),
			.DRV24_IFDET_BLUE_LED     (DRV24_IFDET_BLUE_LED),
			.DRV25_IFDET_BLUE_LED     (DRV25_IFDET_BLUE_LED),
			.DRV26_IFDET_BLUE_LED     (DRV26_IFDET_BLUE_LED),
			.DRV27_IFDET_BLUE_LED     (DRV27_IFDET_BLUE_LED),
			.DRV28_IFDET_BLUE_LED     (DRV28_IFDET_BLUE_LED),
			.DRV29_IFDET_BLUE_LED     (DRV29_IFDET_BLUE_LED),
			.DRV30_IFDET_BLUE_LED     (DRV30_IFDET_BLUE_LED),
			.DRV31_IFDET_BLUE_LED     (DRV31_IFDET_BLUE_LED),
			.DRV32_IFDET_BLUE_LED     (DRV32_IFDET_BLUE_LED),
			.DRV33_IFDET_BLUE_LED     (DRV33_IFDET_BLUE_LED),
			.DRV34_IFDET_BLUE_LED     (DRV34_IFDET_BLUE_LED),
			.DRV35_IFDET_BLUE_LED     (DRV35_IFDET_BLUE_LED),
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
            .DRV0_PWROK                  (DRV12_PWROK ),
            .DRV1_PWROK                  (DRV13_PWROK ),
            .DRV2_PWROK                  (DRV14_PWROK ),
            .DRV3_PWROK                  (DRV15_PWROK ),
            .DRV4_PWROK                  (DRV16_PWROK ),
            .DRV5_PWROK                  (DRV17_PWROK ),
            .DRV6_PWROK                  (DRV18_PWROK ),
            .DRV7_PWROK                  (DRV19_PWROK ),
            .DRV8_PWROK                  (DRV20_PWROK ),
            .DRV9_PWROK                  (DRV21_PWROK ),
            .DRV10_PWROK                  (DRV22_PWROK ),
            .DRV11_PWROK                  (DRV23_PWROK ),
            .DRV12_PWROK                  (DRV24_PWROK ),
            .DRV13_PWROK                  (DRV25_PWROK ),
            .DRV14_PWROK                  (DRV26_PWROK ),
            .DRV15_PWROK                  (DRV27_PWROK ),
            .DRV16_PWROK                  (DRV28_PWROK ),
            .DRV17_PWROK                  (DRV29_PWROK ),
            .DRV18_PWROK                  (DRV30_PWROK ),
            .DRV19_PWROK                  (DRV31_PWROK ),
            .DRV20_PWROK                  (DRV32_PWROK ),
            .DRV21_PWROK                  (DRV33_PWROK ),
            .DRV22_PWROK                  (DRV34_PWROK ),
            .DRV23_PWROK                  (DRV35_PWROK ),
            //RESET A
            .PE_RST_DRV0_A_L          ( PE_RST_DRV0_A_L ),
            .PE_RST_DRV1_A_L          ( PE_RST_DRV1_A_L ),
            .PE_RST_DRV2_A_L          ( PE_RST_DRV2_A_L ),
            .PE_RST_DRV3_A_L          ( PE_RST_DRV3_A_L ),
            .PE_RST_DRV4_A_L          ( PE_RST_DRV4_A_L ),
            .PE_RST_DRV5_A_L          ( PE_RST_DRV5_A_L ),
            .PE_RST_DRV6_A_L          ( PE_RST_DRV6_A_L ),
            .PE_RST_DRV7_A_L          ( PE_RST_DRV7_A_L ),
            .PE_RST_DRV8_A_L          ( PE_RST_DRV8_A_L ),
            .PE_RST_DRV9_A_L          ( PE_RST_DRV9_A_L ),
            .PE_RST_DRV10_A_L          ( PE_RST_DRV10_A_L ),
            .PE_RST_DRV11_A_L          ( PE_RST_DRV11_A_L ),
            .PE_RST_DRV12_A_L          ( PE_RST_DRV12_A_L ),
            .PE_RST_DRV13_A_L          ( PE_RST_DRV13_A_L ),
            .PE_RST_DRV14_A_L          ( PE_RST_DRV14_A_L ),
            .PE_RST_DRV15_A_L          ( PE_RST_DRV15_A_L ),
            .PE_RST_DRV16_A_L          ( PE_RST_DRV16_A_L ),
            .PE_RST_DRV17_A_L          ( PE_RST_DRV17_A_L ),
            .PE_RST_DRV18_A_L          ( PE_RST_DRV18_A_L ),
            .PE_RST_DRV19_A_L          ( PE_RST_DRV19_A_L ),
            .PE_RST_DRV20_A_L          ( PE_RST_DRV20_A_L ),
            .PE_RST_DRV21_A_L          ( PE_RST_DRV21_A_L ),
            .PE_RST_DRV22_A_L          ( PE_RST_DRV22_A_L ),
            .PE_RST_DRV23_A_L          ( PE_RST_DRV23_A_L ),
            //RESET B
            .PE_RST_DRV0_B_L          ( PE_RST_DRV0_B_L ),
            .PE_RST_DRV1_B_L          ( PE_RST_DRV1_B_L ),
            .PE_RST_DRV2_B_L          ( PE_RST_DRV2_B_L ),
            .PE_RST_DRV3_B_L          ( PE_RST_DRV3_B_L ),
            .PE_RST_DRV4_B_L          ( PE_RST_DRV4_B_L ),
            .PE_RST_DRV5_B_L          ( PE_RST_DRV5_B_L ),
            .PE_RST_DRV6_B_L          ( PE_RST_DRV6_B_L ),
            .PE_RST_DRV7_B_L          ( PE_RST_DRV7_B_L ),
            .PE_RST_DRV8_B_L          ( PE_RST_DRV8_B_L ),
            .PE_RST_DRV9_B_L          ( PE_RST_DRV9_B_L ),
            .PE_RST_DRV10_B_L          ( PE_RST_DRV10_B_L ),
            .PE_RST_DRV11_B_L          ( PE_RST_DRV11_B_L ),
            .PE_RST_DRV12_B_L          ( PE_RST_DRV12_B_L ),
            .PE_RST_DRV13_B_L          ( PE_RST_DRV13_B_L ),
            .PE_RST_DRV14_B_L          ( PE_RST_DRV14_B_L ),
            .PE_RST_DRV15_B_L          ( PE_RST_DRV15_B_L ),
            .PE_RST_DRV16_B_L          ( PE_RST_DRV16_B_L ),
            .PE_RST_DRV17_B_L          ( PE_RST_DRV17_B_L ),
            .PE_RST_DRV18_B_L          ( PE_RST_DRV18_B_L ),
            .PE_RST_DRV19_B_L          ( PE_RST_DRV19_B_L ),
            .PE_RST_DRV20_B_L          ( PE_RST_DRV20_B_L ),
            .PE_RST_DRV21_B_L          ( PE_RST_DRV21_B_L ),
            .PE_RST_DRV22_B_L          ( PE_RST_DRV22_B_L ),
            .PE_RST_DRV23_B_L          ( PE_RST_DRV23_B_L ),
            .SYSCLK					     (SYSCLK),
            .RESET_N				     (RESET_N)
);

//BB_SGPIO
BB_SGPIO  BB_SGPIO_INST (
            // Driver active led input
            .DRV0_ACT_LED                  ( DRV0_ACT_LED ),
            .DRV1_ACT_LED                  ( DRV1_ACT_LED ),
            .DRV2_ACT_LED                  ( DRV2_ACT_LED ),
            .DRV3_ACT_LED                  ( DRV3_ACT_LED ),
            .DRV4_ACT_LED                  ( DRV4_ACT_LED ),
            .DRV5_ACT_LED                  ( DRV5_ACT_LED ),
            .DRV6_ACT_LED                  ( DRV6_ACT_LED ),
            .DRV7_ACT_LED                  ( DRV7_ACT_LED ),
            .DRV8_ACT_LED                  ( DRV8_ACT_LED ),
            .DRV9_ACT_LED                  ( DRV9_ACT_LED ),
            .DRV10_ACT_LED                  ( DRV10_ACT_LED ),
            .DRV11_ACT_LED                  ( DRV11_ACT_LED ),
            .DRV12_ACT_LED                  ( DRV12_ACT_LED ),
            .DRV13_ACT_LED                  ( DRV13_ACT_LED ),
            .DRV14_ACT_LED                  ( DRV14_ACT_LED ),
            .DRV15_ACT_LED                  ( DRV15_ACT_LED ),
            .DRV16_ACT_LED                  ( DRV16_ACT_LED ),
            .DRV17_ACT_LED                  ( DRV17_ACT_LED ),
            .DRV18_ACT_LED                  ( DRV18_ACT_LED ),
            .DRV19_ACT_LED                  ( DRV19_ACT_LED ),
            .DRV20_ACT_LED                  ( DRV20_ACT_LED ),
            .DRV21_ACT_LED                  ( DRV21_ACT_LED ),
            .DRV22_ACT_LED                  ( DRV22_ACT_LED ),
            .DRV23_ACT_LED                  ( DRV23_ACT_LED ),
            .DRV24_ACT_LED                  ( DRV24_ACT_LED ),
            .DRV25_ACT_LED                  ( DRV25_ACT_LED ),
            .DRV26_ACT_LED                  ( DRV26_ACT_LED ),
            .DRV27_ACT_LED                  ( DRV27_ACT_LED ),
            .DRV28_ACT_LED                  ( DRV28_ACT_LED ),
            .DRV29_ACT_LED                  ( DRV29_ACT_LED ),
            .DRV30_ACT_LED                  ( DRV30_ACT_LED ),
            .DRV31_ACT_LED                  ( DRV31_ACT_LED ),
            .DRV32_ACT_LED                  ( DRV32_ACT_LED ),
            .DRV33_ACT_LED                  ( DRV33_ACT_LED ),
            .DRV34_ACT_LED                  ( DRV34_ACT_LED ),
            .DRV35_ACT_LED                  ( DRV35_ACT_LED ),
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
