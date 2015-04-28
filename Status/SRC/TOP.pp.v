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
; for ($i=1; $i<73; $i++) {
            output    DRV${i}_ACT_LED_CATH_L,
; }
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

; for ($i=1,$j=0; $i<=12,$j<12; $i++,$j++) {
assign    DRV${i}_ACT_LED_CATH_L = ~ACT_LED1[${j}];
; }

; for ($i=13,$j=0; $i<=24,$j<12; $i++,$j++) {
assign    DRV${i}_ACT_LED_CATH_L = ~ACT_LED2[${j}];
; }

; for ($i=25,$j=12; $i<=36,$j<24; $i++,$j++) {
assign    DRV${i}_ACT_LED_CATH_L = ~ACT_LED1[${j}];
; }

; for ($i=37,$j=12; $i<=48,$j<24; $i++,$j++) {
assign    DRV${i}_ACT_LED_CATH_L = ~ACT_LED2[${j}];
; }

; for ($i=49,$j=24; $i<=60,$j<36; $i++,$j++) {
assign    DRV${i}_ACT_LED_CATH_L = ~ACT_LED1[${j}];
; }

; for ($i=61,$j=24; $i<=72,$j<36; $i++,$j++) {
assign    DRV${i}_ACT_LED_CATH_L = ~ACT_LED2[${j}];
; }

endmodule
