//************************************************************************
//**                          Baseboard CPLD							**
//**                          PCIE_RST_CTRL.v                           **
//************************************************************************ 

//**********************      ChangeList      *****************************

`include "../SRC/baseboard_define.v"

module PCIE_RST_CTRL (

            // Driver power ok input
            input       DRV3_PWROK,DRV2_PWROK,DRV1_PWROK,DRV0_PWROK,
            input       DRV7_PWROK,DRV6_PWROK,DRV5_PWROK,DRV4_PWROK,
            input       DRV11_PWROK,DRV10_PWROK,DRV9_PWROK,DRV8_PWROK,
            input       DRV15_PWROK,DRV14_PWROK,DRV13_PWROK,DRV12_PWROK,
            input       DRV19_PWROK,DRV18_PWROK,DRV17_PWROK,DRV16_PWROK,
            input       DRV23_PWROK,DRV22_PWROK,DRV21_PWROK,DRV20_PWROK,
            // PCIE reset portA output
            output reg  PE_RST_DRV3_A_L,PE_RST_DRV2_A_L,PE_RST_DRV1_A_L,PE_RST_DRV0_A_L,
            output reg  PE_RST_DRV7_A_L,PE_RST_DRV6_A_L,PE_RST_DRV5_A_L,PE_RST_DRV4_A_L,
            output reg  PE_RST_DRV11_A_L,PE_RST_DRV10_A_L,PE_RST_DRV9_A_L,PE_RST_DRV8_A_L,
            output reg  PE_RST_DRV15_A_L,PE_RST_DRV14_A_L,PE_RST_DRV13_A_L,PE_RST_DRV12_A_L,
            output reg  PE_RST_DRV19_A_L,PE_RST_DRV18_A_L,PE_RST_DRV17_A_L,PE_RST_DRV16_A_L,
            output reg  PE_RST_DRV23_A_L,PE_RST_DRV22_A_L,PE_RST_DRV21_A_L,PE_RST_DRV20_A_L,
            // PCIE reset portB output
            output reg  PE_RST_DRV3_B_L,PE_RST_DRV2_B_L,PE_RST_DRV1_B_L,PE_RST_DRV0_B_L,
            output reg  PE_RST_DRV7_B_L,PE_RST_DRV6_B_L,PE_RST_DRV5_B_L,PE_RST_DRV4_B_L,
            output reg  PE_RST_DRV11_B_L,PE_RST_DRV10_B_L,PE_RST_DRV9_B_L,PE_RST_DRV8_B_L,
            output reg  PE_RST_DRV15_B_L,PE_RST_DRV14_B_L,PE_RST_DRV13_B_L,PE_RST_DRV12_B_L,
            output reg  PE_RST_DRV19_B_L,PE_RST_DRV18_B_L,PE_RST_DRV17_B_L,PE_RST_DRV16_B_L,
            output reg  PE_RST_DRV23_B_L,PE_RST_DRV22_B_L,PE_RST_DRV21_B_L,PE_RST_DRV20_B_L,
            // System
			input     SYSCLK,
			input     RESET_N
			
            );

//PCIE RESET 0
reg       [31:0]  CNT0;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT0                  <= 'b0;
				PE_RST_DRV0_A_L       <= 'b0;
				PE_RST_DRV0_B_L       <= 'b0;
			end
		else
		    begin
				CNT0                  <= ((CNT0 < `TIME_100MS) && (DRV0_PWROK == 1'b1))? (CNT0 + 32'h1) : ((DRV0_PWROK == 1'b1)? CNT0 : 0);
				PE_RST_DRV0_A_L       <= (CNT0 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV0_B_L       <= (CNT0 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 1
reg       [31:0]  CNT1;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT1                  <= 'b0;
				PE_RST_DRV1_A_L       <= 'b0;
				PE_RST_DRV1_B_L       <= 'b0;
			end
		else
		    begin
				CNT1                  <= ((CNT1 < `TIME_100MS) && (DRV1_PWROK == 1'b1))? (CNT1 + 32'h1) : ((DRV1_PWROK == 1'b1)? CNT1 : 0);
				PE_RST_DRV1_A_L       <= (CNT1 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV1_B_L       <= (CNT1 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 2
reg       [31:0]  CNT2;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT2                  <= 'b0;
				PE_RST_DRV2_A_L       <= 'b0;
				PE_RST_DRV2_B_L       <= 'b0;
			end
		else
		    begin
				CNT2                  <= ((CNT2 < `TIME_100MS) && (DRV2_PWROK == 1'b1))? (CNT2 + 32'h1) : ((DRV2_PWROK == 1'b1)? CNT2 : 0);
				PE_RST_DRV2_A_L       <= (CNT2 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV2_B_L       <= (CNT2 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 3
reg       [31:0]  CNT3;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT3                  <= 'b0;
				PE_RST_DRV3_A_L       <= 'b0;
				PE_RST_DRV3_B_L       <= 'b0;
			end
		else
		    begin
				CNT3                  <= ((CNT3 < `TIME_100MS) && (DRV3_PWROK == 1'b1))? (CNT3 + 32'h1) : ((DRV3_PWROK == 1'b1)? CNT3 : 0);
				PE_RST_DRV3_A_L       <= (CNT3 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV3_B_L       <= (CNT3 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 4
reg       [31:0]  CNT4;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT4                  <= 'b0;
				PE_RST_DRV4_A_L       <= 'b0;
				PE_RST_DRV4_B_L       <= 'b0;
			end
		else
		    begin
				CNT4                  <= ((CNT4 < `TIME_100MS) && (DRV4_PWROK == 1'b1))? (CNT4 + 32'h1) : ((DRV4_PWROK == 1'b1)? CNT4 : 0);
				PE_RST_DRV4_A_L       <= (CNT4 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV4_B_L       <= (CNT4 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 5
reg       [31:0]  CNT5;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT5                  <= 'b0;
				PE_RST_DRV5_A_L       <= 'b0;
				PE_RST_DRV5_B_L       <= 'b0;
			end
		else
		    begin
				CNT5                  <= ((CNT5 < `TIME_100MS) && (DRV5_PWROK == 1'b1))? (CNT5 + 32'h1) : ((DRV5_PWROK == 1'b1)? CNT5 : 0);
				PE_RST_DRV5_A_L       <= (CNT5 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV5_B_L       <= (CNT5 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 6
reg       [31:0]  CNT6;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT6                  <= 'b0;
				PE_RST_DRV6_A_L       <= 'b0;
				PE_RST_DRV6_B_L       <= 'b0;
			end
		else
		    begin
				CNT6                  <= ((CNT6 < `TIME_100MS) && (DRV6_PWROK == 1'b1))? (CNT6 + 32'h1) : ((DRV6_PWROK == 1'b1)? CNT6 : 0);
				PE_RST_DRV6_A_L       <= (CNT6 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV6_B_L       <= (CNT6 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 7
reg       [31:0]  CNT7;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT7                  <= 'b0;
				PE_RST_DRV7_A_L       <= 'b0;
				PE_RST_DRV7_B_L       <= 'b0;
			end
		else
		    begin
				CNT7                  <= ((CNT7 < `TIME_100MS) && (DRV7_PWROK == 1'b1))? (CNT7 + 32'h1) : ((DRV7_PWROK == 1'b1)? CNT7 : 0);
				PE_RST_DRV7_A_L       <= (CNT7 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV7_B_L       <= (CNT7 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 8
reg       [31:0]  CNT8;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT8                  <= 'b0;
				PE_RST_DRV8_A_L       <= 'b0;
				PE_RST_DRV8_B_L       <= 'b0;
			end
		else
		    begin
				CNT8                  <= ((CNT8 < `TIME_100MS) && (DRV8_PWROK == 1'b1))? (CNT8 + 32'h1) : ((DRV8_PWROK == 1'b1)? CNT8 : 0);
				PE_RST_DRV8_A_L       <= (CNT8 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV8_B_L       <= (CNT8 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 9
reg       [31:0]  CNT9;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT9                  <= 'b0;
				PE_RST_DRV9_A_L       <= 'b0;
				PE_RST_DRV9_B_L       <= 'b0;
			end
		else
		    begin
				CNT9                  <= ((CNT9 < `TIME_100MS) && (DRV9_PWROK == 1'b1))? (CNT9 + 32'h1) : ((DRV9_PWROK == 1'b1)? CNT9 : 0);
				PE_RST_DRV9_A_L       <= (CNT9 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV9_B_L       <= (CNT9 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 10
reg       [31:0]  CNT10;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT10                  <= 'b0;
				PE_RST_DRV10_A_L       <= 'b0;
				PE_RST_DRV10_B_L       <= 'b0;
			end
		else
		    begin
				CNT10                  <= ((CNT10 < `TIME_100MS) && (DRV10_PWROK == 1'b1))? (CNT10 + 32'h1) : ((DRV10_PWROK == 1'b1)? CNT10 : 0);
				PE_RST_DRV10_A_L       <= (CNT10 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV10_B_L       <= (CNT10 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 11
reg       [31:0]  CNT11;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT11                  <= 'b0;
				PE_RST_DRV11_A_L       <= 'b0;
				PE_RST_DRV11_B_L       <= 'b0;
			end
		else
		    begin
				CNT11                  <= ((CNT11 < `TIME_100MS) && (DRV11_PWROK == 1'b1))? (CNT11 + 32'h1) : ((DRV11_PWROK == 1'b1)? CNT11 : 0);
				PE_RST_DRV11_A_L       <= (CNT11 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV11_B_L       <= (CNT11 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 12
reg       [31:0]  CNT12;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT12                  <= 'b0;
				PE_RST_DRV12_A_L       <= 'b0;
				PE_RST_DRV12_B_L       <= 'b0;
			end
		else
		    begin
				CNT12                  <= ((CNT12 < `TIME_100MS) && (DRV12_PWROK == 1'b1))? (CNT12 + 32'h1) : ((DRV12_PWROK == 1'b1)? CNT12 : 0);
				PE_RST_DRV12_A_L       <= (CNT12 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV12_B_L       <= (CNT12 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 13
reg       [31:0]  CNT13;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT13                  <= 'b0;
				PE_RST_DRV13_A_L       <= 'b0;
				PE_RST_DRV13_B_L       <= 'b0;
			end
		else
		    begin
				CNT13                  <= ((CNT13 < `TIME_100MS) && (DRV13_PWROK == 1'b1))? (CNT13 + 32'h1) : ((DRV13_PWROK == 1'b1)? CNT13 : 0);
				PE_RST_DRV13_A_L       <= (CNT13 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV13_B_L       <= (CNT13 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 14
reg       [31:0]  CNT14;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT14                  <= 'b0;
				PE_RST_DRV14_A_L       <= 'b0;
				PE_RST_DRV14_B_L       <= 'b0;
			end
		else
		    begin
				CNT14                  <= ((CNT14 < `TIME_100MS) && (DRV14_PWROK == 1'b1))? (CNT14 + 32'h1) : ((DRV14_PWROK == 1'b1)? CNT14 : 0);
				PE_RST_DRV14_A_L       <= (CNT14 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV14_B_L       <= (CNT14 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 15
reg       [31:0]  CNT15;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT15                  <= 'b0;
				PE_RST_DRV15_A_L       <= 'b0;
				PE_RST_DRV15_B_L       <= 'b0;
			end
		else
		    begin
				CNT15                  <= ((CNT15 < `TIME_100MS) && (DRV15_PWROK == 1'b1))? (CNT15 + 32'h1) : ((DRV15_PWROK == 1'b1)? CNT15 : 0);
				PE_RST_DRV15_A_L       <= (CNT15 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV15_B_L       <= (CNT15 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 16
reg       [31:0]  CNT16;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT16                  <= 'b0;
				PE_RST_DRV16_A_L       <= 'b0;
				PE_RST_DRV16_B_L       <= 'b0;
			end
		else
		    begin
				CNT16                  <= ((CNT16 < `TIME_100MS) && (DRV16_PWROK == 1'b1))? (CNT16 + 32'h1) : ((DRV16_PWROK == 1'b1)? CNT16 : 0);
				PE_RST_DRV16_A_L       <= (CNT16 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV16_B_L       <= (CNT16 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 17
reg       [31:0]  CNT17;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT17                  <= 'b0;
				PE_RST_DRV17_A_L       <= 'b0;
				PE_RST_DRV17_B_L       <= 'b0;
			end
		else
		    begin
				CNT17                  <= ((CNT17 < `TIME_100MS) && (DRV17_PWROK == 1'b1))? (CNT17 + 32'h1) : ((DRV17_PWROK == 1'b1)? CNT17 : 0);
				PE_RST_DRV17_A_L       <= (CNT17 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV17_B_L       <= (CNT17 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 18
reg       [31:0]  CNT18;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT18                  <= 'b0;
				PE_RST_DRV18_A_L       <= 'b0;
				PE_RST_DRV18_B_L       <= 'b0;
			end
		else
		    begin
				CNT18                  <= ((CNT18 < `TIME_100MS) && (DRV18_PWROK == 1'b1))? (CNT18 + 32'h1) : ((DRV18_PWROK == 1'b1)? CNT18 : 0);
				PE_RST_DRV18_A_L       <= (CNT18 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV18_B_L       <= (CNT18 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 19
reg       [31:0]  CNT19;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT19                  <= 'b0;
				PE_RST_DRV19_A_L       <= 'b0;
				PE_RST_DRV19_B_L       <= 'b0;
			end
		else
		    begin
				CNT19                  <= ((CNT19 < `TIME_100MS) && (DRV19_PWROK == 1'b1))? (CNT19 + 32'h1) : ((DRV19_PWROK == 1'b1)? CNT19 : 0);
				PE_RST_DRV19_A_L       <= (CNT19 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV19_B_L       <= (CNT19 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 20
reg       [31:0]  CNT20;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT20                  <= 'b0;
				PE_RST_DRV20_A_L       <= 'b0;
				PE_RST_DRV20_B_L       <= 'b0;
			end
		else
		    begin
				CNT20                  <= ((CNT20 < `TIME_100MS) && (DRV20_PWROK == 1'b1))? (CNT20 + 32'h1) : ((DRV20_PWROK == 1'b1)? CNT20 : 0);
				PE_RST_DRV20_A_L       <= (CNT20 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV20_B_L       <= (CNT20 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 21
reg       [31:0]  CNT21;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT21                  <= 'b0;
				PE_RST_DRV21_A_L       <= 'b0;
				PE_RST_DRV21_B_L       <= 'b0;
			end
		else
		    begin
				CNT21                  <= ((CNT21 < `TIME_100MS) && (DRV21_PWROK == 1'b1))? (CNT21 + 32'h1) : ((DRV21_PWROK == 1'b1)? CNT21 : 0);
				PE_RST_DRV21_A_L       <= (CNT21 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV21_B_L       <= (CNT21 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 22
reg       [31:0]  CNT22;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT22                  <= 'b0;
				PE_RST_DRV22_A_L       <= 'b0;
				PE_RST_DRV22_B_L       <= 'b0;
			end
		else
		    begin
				CNT22                  <= ((CNT22 < `TIME_100MS) && (DRV22_PWROK == 1'b1))? (CNT22 + 32'h1) : ((DRV22_PWROK == 1'b1)? CNT22 : 0);
				PE_RST_DRV22_A_L       <= (CNT22 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV22_B_L       <= (CNT22 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
//PCIE RESET 23
reg       [31:0]  CNT23;
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT23                  <= 'b0;
				PE_RST_DRV23_A_L       <= 'b0;
				PE_RST_DRV23_B_L       <= 'b0;
			end
		else
		    begin
				CNT23                  <= ((CNT23 < `TIME_100MS) && (DRV23_PWROK == 1'b1))? (CNT23 + 32'h1) : ((DRV23_PWROK == 1'b1)? CNT23 : 0);
				PE_RST_DRV23_A_L       <= (CNT23 < `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV23_B_L       <= (CNT23 < `TIME_100MS)? 1'b0 : 1'b1;
			end
	end

endmodule