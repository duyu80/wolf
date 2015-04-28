//************************************************************************
//**                          Status CPLD								**
//**                          TOP.v										**
//************************************************************************

//**********************      ChangeList      *****************************

`include "../SRC/status_define.v"


module TOP (
            // System
			input     SYSCLK,
			input     RESET_N,
			// I2C
			input     SCL,
			inout     SDA,
			// Driver active led
            output    DRV1_ACT_LED_CATH_L,
            output    DRV2_ACT_LED_CATH_L,
            output    DRV3_ACT_LED_CATH_L,
            output    DRV4_ACT_LED_CATH_L,
            output    DRV5_ACT_LED_CATH_L,
            output    DRV6_ACT_LED_CATH_L,
            output    DRV7_ACT_LED_CATH_L,
            output    DRV8_ACT_LED_CATH_L,
            output    DRV9_ACT_LED_CATH_L,
            output    DRV10_ACT_LED_CATH_L,
            output    DRV11_ACT_LED_CATH_L,
            output    DRV12_ACT_LED_CATH_L,
            output    DRV13_ACT_LED_CATH_L,
            output    DRV14_ACT_LED_CATH_L,
            output    DRV15_ACT_LED_CATH_L,
            output    DRV16_ACT_LED_CATH_L,
            output    DRV17_ACT_LED_CATH_L,
            output    DRV18_ACT_LED_CATH_L,
            output    DRV19_ACT_LED_CATH_L,
            output    DRV20_ACT_LED_CATH_L,
            output    DRV21_ACT_LED_CATH_L,
            output    DRV22_ACT_LED_CATH_L,
            output    DRV23_ACT_LED_CATH_L,
            output    DRV24_ACT_LED_CATH_L,
            output    DRV25_ACT_LED_CATH_L,
            output    DRV26_ACT_LED_CATH_L,
            output    DRV27_ACT_LED_CATH_L,
            output    DRV28_ACT_LED_CATH_L,
            output    DRV29_ACT_LED_CATH_L,
            output    DRV30_ACT_LED_CATH_L,
            output    DRV31_ACT_LED_CATH_L,
            output    DRV32_ACT_LED_CATH_L,
            output    DRV33_ACT_LED_CATH_L,
            output    DRV34_ACT_LED_CATH_L,
            output    DRV35_ACT_LED_CATH_L,
            output    DRV36_ACT_LED_CATH_L,
            output    DRV37_ACT_LED_CATH_L,
            output    DRV38_ACT_LED_CATH_L,
            output    DRV39_ACT_LED_CATH_L,
            output    DRV40_ACT_LED_CATH_L,
            output    DRV41_ACT_LED_CATH_L,
            output    DRV42_ACT_LED_CATH_L,
            output    DRV43_ACT_LED_CATH_L,
            output    DRV44_ACT_LED_CATH_L,
            output    DRV45_ACT_LED_CATH_L,
            output    DRV46_ACT_LED_CATH_L,
            output    DRV47_ACT_LED_CATH_L,
            output    DRV48_ACT_LED_CATH_L,
            output    DRV49_ACT_LED_CATH_L,
            output    DRV50_ACT_LED_CATH_L,
            output    DRV51_ACT_LED_CATH_L,
            output    DRV52_ACT_LED_CATH_L,
            output    DRV53_ACT_LED_CATH_L,
            output    DRV54_ACT_LED_CATH_L,
            output    DRV55_ACT_LED_CATH_L,
            output    DRV56_ACT_LED_CATH_L,
            output    DRV57_ACT_LED_CATH_L,
            output    DRV58_ACT_LED_CATH_L,
            output    DRV59_ACT_LED_CATH_L,
            output    DRV60_ACT_LED_CATH_L,
            output    DRV61_ACT_LED_CATH_L,
            output    DRV62_ACT_LED_CATH_L,
            output    DRV63_ACT_LED_CATH_L,
            output    DRV64_ACT_LED_CATH_L,
            output    DRV65_ACT_LED_CATH_L,
            output    DRV66_ACT_LED_CATH_L,
            output    DRV67_ACT_LED_CATH_L,
            output    DRV68_ACT_LED_CATH_L,
            output    DRV69_ACT_LED_CATH_L,
            output    DRV70_ACT_LED_CATH_L,
            output    DRV71_ACT_LED_CATH_L,
            output    DRV72_ACT_LED_CATH_L,
            // Indicator LEDs Signals
            output    SES_FLT_AMBER_LED_L,
            output    SES_INENT_BLUE_LED_L,
            output    COVER_OPEN_AMBER_LED_L,
            output    COM_FLT_AMBER_LED_L,
            output    DRV_FLT_AMBER_LED_L,
            // SGPIO
            input     SGPIO_CK1,
            input     SGPIO_LD1,
			input     SGPIO_DATA1,
			input     SGPIO_CK2,
            input     SGPIO_LD2,
			input     SGPIO_DATA2,
			// Active led power
			output    DRV_ACT_LED_EN_L
			);


//I2C wire
wire	[7:0]	I2C_DOUT;
wire	[15:0]	PORT_CS;
wire	[15:0]	OFFSET_SEL;    //This two signal port are used for GPIO port selection
wire			RD_WR;         //1 means I2C read operation, and 0 means I2C write operation
wire	[7:0]   DIN_0, DIN_1, DIN_2, DIN_3, DIN_4,  DIN_5, DIN_6, DIN_7, 
                DIN_8, DIN_9, DIN_A, DIN_B, DIN_C, DIN_D, DIN_E, DIN_F;    //16 PORTs for GPIO PORTs
wire			WR_EN;         //This signal is for error code

//LED
wire    [7:0]	LED_REG0;
wire    [7:0]	LED_REG1;
wire    [7:0]	LED_REG2;
wire    [7:0]	LED_REG3;
wire    [7:0]	LED_REG4;
wire    [7:0]	LED_REG5;
wire    [7:0]	LED_REG6;
wire    [7:0]	LED_REG7;

//SGPIO
wire    [35:0]  ACT_LED1;
wire    [35:0]  ACT_LED2;

assign  DRV_ACT_LED_EN_L = 1'b0;

//**************************************************************************
//**                          
//**  This instance is I2C MACHINE, CPLD use this I2C MACHINE to read/write
//**  data from/to GPIO                    
//**                          
//************************************************************************** 
I2C  I2C_INST  (
               .SCL                 (SCL),
               .SDA                 (SDA),
               .I2C_ADDRESS         (`I2C_ADDR),
               .I2C_RESET_N         (RESET_N),
               .SYSCLK              (SYSCLK),
               .PORT_CS             (PORT_CS),
               .OFFSET_SEL          (OFFSET_SEL),
               .RD_WR               (RD_WR),
               .DOUT                (I2C_DOUT),
               .DIN_0               (DIN_0),                
               .DIN_1               (DIN_1), 		
               .DIN_2               (DIN_2), 		
               .DIN_3               (DIN_3), 		
               .DIN_4               (DIN_4), 		
               .DIN_5               (DIN_5), 		
               .DIN_6               (DIN_6), 		
               .DIN_7               (DIN_7),		    
               .DIN_8               (DIN_8), 		
               .DIN_9               (DIN_9), 		
               .DIN_A               (DIN_A), 		
               .DIN_B               (DIN_B), 		
               .DIN_C               (DIN_C), 		
               .DIN_D               (DIN_D), 		
               .DIN_E               (DIN_E), 		
               .DIN_F               (DIN_F)
			   );

//GPIO0
GPIO   GPIO_INST (
			.RESET_N		        (RESET_N),
			.SYSCLK			        (SYSCLK),
			                        
			.PORT_CS		        (PORT_CS[1]),
			.OFFSET_SEL	            (OFFSET_SEL),
			.DOUT			        (DIN_1),						
			.RD_WR		            (RD_WR),
			.DIN			        (I2C_DOUT),
                                    
			.GPIO_0		            (LED_REG0),
			.GPIO_1		            (LED_REG1),
			.GPIO_2		            (LED_REG2),
			.GPIO_3		            (LED_REG3),
			.GPIO_4		            (LED_REG4),
			.GPIO_5		            (LED_REG5),
			.GPIO_6		            (LED_REG6),
			.GPIO_7		            (LED_REG7),
			.GPIO_8		            (),
			.GPIO_9		            (),
			.GPIO_A		            (),
			.GPIO_B		            (),
			.GPIO_C		            (),
			.GPIO_D		            (),
			.GPIO_E		            (),
			.GPIO_F		            ()
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

LED LED_INST(
            .SYSCLK					(SYSCLK),
            .RESET_N				(RESET_N),
            .CLK_1HZ				(CLK_1HZ),
            .CLK_2HZ				(CLK_2HZ),
            .CLK_4HZ				(CLK_4HZ),
            .CLK_4HZ_500MS          (CLK_4HZ_500MS),
            .CLK_4HZ_3500MS         (CLK_4HZ_3500MS),
            .CLK_07S				(CLK_07S),
			
            .LED_REG0               (LED_REG0),
            .LED_REG1               (LED_REG1),
            .LED_REG2               (LED_REG2),
            .LED_REG3               (LED_REG3),
            .LED_REG4               (LED_REG4),
            .LED_REG5               (LED_REG5),
            .LED_REG6               (LED_REG6),
            .LED_REG7               (LED_REG7),
            
            .LED0                   (SES_FLT_AMBER_LED_L),
            .LED1                   (SES_INENT_BLUE_LED_L),
            .LED2                   (COVER_OPEN_AMBER_LED_L),
            .LED3                   (),
            .LED4                   (),
            .LED5                   (),
            .LED6                   (COM_FLT_AMBER_LED_L),
            .LED7                   (DRV_FLT_AMBER_LED_L),
                                            
            .LED8                   (),
            .LED9                   (),
            .LED10                  (),
            .LED11                  (),
            .LED12                  (),
            .LED13                  (),
            .LED14                  (),
            .LED15                  ()
		);

HEADER HEADER_INST (
                    .RESET_N		    (RESET_N),
                    .SYSCLK			    (SYSCLK),						
                    .PORT_CS		    (PORT_CS[0]),
                    .OFFSET_SEL		    (OFFSET_SEL),
                    .DOUT			    (DIN_0),						
                    .RD_WR			    (RD_WR),
                    .DIN				(I2C_DOUT)
                    );

// SGPIO
SGPIO	SGPIO_INST1 (
					.SYSCLK			(SYSCLK),
					.RESET_N		(RESET_N),
					.SCLK			(SGPIO_CK1),
					.SLOAD			(SGPIO_LD1),
					.SDOUT			(SGPIO_DATA1),
					.ACT_LED		(ACT_LED1)
					);

SGPIO	SGPIO_INST2 (
					.SYSCLK			(SYSCLK),
					.RESET_N		(RESET_N),
					.SCLK			(SGPIO_CK2),
					.SLOAD			(SGPIO_LD2),
					.SDOUT			(SGPIO_DATA2),
					.ACT_LED		(ACT_LED2)
					);

assign    DRV1_ACT_LED_CATH_L = ~ACT_LED1[0];
assign    DRV2_ACT_LED_CATH_L = ~ACT_LED1[1];
assign    DRV3_ACT_LED_CATH_L = ~ACT_LED1[2];
assign    DRV4_ACT_LED_CATH_L = ~ACT_LED1[3];
assign    DRV5_ACT_LED_CATH_L = ~ACT_LED1[4];
assign    DRV6_ACT_LED_CATH_L = ~ACT_LED1[5];
assign    DRV7_ACT_LED_CATH_L = ~ACT_LED1[6];
assign    DRV8_ACT_LED_CATH_L = ~ACT_LED1[7];
assign    DRV9_ACT_LED_CATH_L = ~ACT_LED1[8];
assign    DRV10_ACT_LED_CATH_L = ~ACT_LED1[9];
assign    DRV11_ACT_LED_CATH_L = ~ACT_LED1[10];
assign    DRV12_ACT_LED_CATH_L = ~ACT_LED1[11];

assign    DRV13_ACT_LED_CATH_L = ~ACT_LED2[0];
assign    DRV14_ACT_LED_CATH_L = ~ACT_LED2[1];
assign    DRV15_ACT_LED_CATH_L = ~ACT_LED2[2];
assign    DRV16_ACT_LED_CATH_L = ~ACT_LED2[3];
assign    DRV17_ACT_LED_CATH_L = ~ACT_LED2[4];
assign    DRV18_ACT_LED_CATH_L = ~ACT_LED2[5];
assign    DRV19_ACT_LED_CATH_L = ~ACT_LED2[6];
assign    DRV20_ACT_LED_CATH_L = ~ACT_LED2[7];
assign    DRV21_ACT_LED_CATH_L = ~ACT_LED2[8];
assign    DRV22_ACT_LED_CATH_L = ~ACT_LED2[9];
assign    DRV23_ACT_LED_CATH_L = ~ACT_LED2[10];
assign    DRV24_ACT_LED_CATH_L = ~ACT_LED2[11];

assign    DRV25_ACT_LED_CATH_L = ~ACT_LED1[12];
assign    DRV26_ACT_LED_CATH_L = ~ACT_LED1[13];
assign    DRV27_ACT_LED_CATH_L = ~ACT_LED1[14];
assign    DRV28_ACT_LED_CATH_L = ~ACT_LED1[15];
assign    DRV29_ACT_LED_CATH_L = ~ACT_LED1[16];
assign    DRV30_ACT_LED_CATH_L = ~ACT_LED1[17];
assign    DRV31_ACT_LED_CATH_L = ~ACT_LED1[18];
assign    DRV32_ACT_LED_CATH_L = ~ACT_LED1[19];
assign    DRV33_ACT_LED_CATH_L = ~ACT_LED1[20];
assign    DRV34_ACT_LED_CATH_L = ~ACT_LED1[21];
assign    DRV35_ACT_LED_CATH_L = ~ACT_LED1[22];
assign    DRV36_ACT_LED_CATH_L = ~ACT_LED1[23];

assign    DRV37_ACT_LED_CATH_L = ~ACT_LED2[12];
assign    DRV38_ACT_LED_CATH_L = ~ACT_LED2[13];
assign    DRV39_ACT_LED_CATH_L = ~ACT_LED2[14];
assign    DRV40_ACT_LED_CATH_L = ~ACT_LED2[15];
assign    DRV41_ACT_LED_CATH_L = ~ACT_LED2[16];
assign    DRV42_ACT_LED_CATH_L = ~ACT_LED2[17];
assign    DRV43_ACT_LED_CATH_L = ~ACT_LED2[18];
assign    DRV44_ACT_LED_CATH_L = ~ACT_LED2[19];
assign    DRV45_ACT_LED_CATH_L = ~ACT_LED2[20];
assign    DRV46_ACT_LED_CATH_L = ~ACT_LED2[21];
assign    DRV47_ACT_LED_CATH_L = ~ACT_LED2[22];
assign    DRV48_ACT_LED_CATH_L = ~ACT_LED2[23];

assign    DRV49_ACT_LED_CATH_L = ~ACT_LED1[24];
assign    DRV50_ACT_LED_CATH_L = ~ACT_LED1[25];
assign    DRV51_ACT_LED_CATH_L = ~ACT_LED1[26];
assign    DRV52_ACT_LED_CATH_L = ~ACT_LED1[27];
assign    DRV53_ACT_LED_CATH_L = ~ACT_LED1[28];
assign    DRV54_ACT_LED_CATH_L = ~ACT_LED1[29];
assign    DRV55_ACT_LED_CATH_L = ~ACT_LED1[30];
assign    DRV56_ACT_LED_CATH_L = ~ACT_LED1[31];
assign    DRV57_ACT_LED_CATH_L = ~ACT_LED1[32];
assign    DRV58_ACT_LED_CATH_L = ~ACT_LED1[33];
assign    DRV59_ACT_LED_CATH_L = ~ACT_LED1[34];
assign    DRV60_ACT_LED_CATH_L = ~ACT_LED1[35];

assign    DRV61_ACT_LED_CATH_L = ~ACT_LED2[24];
assign    DRV62_ACT_LED_CATH_L = ~ACT_LED2[25];
assign    DRV63_ACT_LED_CATH_L = ~ACT_LED2[26];
assign    DRV64_ACT_LED_CATH_L = ~ACT_LED2[27];
assign    DRV65_ACT_LED_CATH_L = ~ACT_LED2[28];
assign    DRV66_ACT_LED_CATH_L = ~ACT_LED2[29];
assign    DRV67_ACT_LED_CATH_L = ~ACT_LED2[30];
assign    DRV68_ACT_LED_CATH_L = ~ACT_LED2[31];
assign    DRV69_ACT_LED_CATH_L = ~ACT_LED2[32];
assign    DRV70_ACT_LED_CATH_L = ~ACT_LED2[33];
assign    DRV71_ACT_LED_CATH_L = ~ACT_LED2[34];
assign    DRV72_ACT_LED_CATH_L = ~ACT_LED2[35];

endmodule
