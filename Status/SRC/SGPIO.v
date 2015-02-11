//************************************************************************
//**                          Status CPLD								**
//**                          SGPIO.v									**
//************************************************************************

//**********************      ChangeList      *****************************

`include "../SRC/status_define.v"

module SGPIO	(
				SYSCLK,RESET_N,
				SCLK,SLOAD,SDOUT,
				ACT_LED,
				FLT_LED
				);

input		SYSCLK;
input		RESET_N;

input		SCLK;
input		SLOAD;
input		SDOUT;

output	[`HDD_NUM-1:0]	ACT_LED;
output	[`HDD_NUM-1:0]	FLT_LED;

reg		[`HDD_NUM-1:0]	ACT_LED;
reg		[`HDD_NUM-1:0]	FLT_LED;

reg		[`HDD_NUM-1:0]	ACT_LED_TMP;
reg		[`HDD_NUM-1:0]	FLT_LED_TMP;

reg		[7:0]	STATE;
reg		[7:0]	HDD_CNT;

reg				SCLK_D1,SCLK_D2,SCLK_D3;
//reg				SLOAD_D1,SLOAD_D2,SLOAD_D3;

reg		[31:0]	CNT;
reg				TIME_OUT;

wire			SCLK_P = ~SCLK_D3 & SCLK_D2 & SCLK_D1 & SCLK;
wire			SCLK_N = SCLK_D3 & ~SCLK_D2 & ~SCLK_D1 & ~SCLK;
//wire			FRM_STAT = SCLK_D1 & ~SCLK & SLOAD;
wire			FRM_STAT = SCLK_N & SLOAD;

always@(posedge SYSCLK or negedge RESET_N)
	 begin
		if(RESET_N == 1'b0)
			begin
				{SCLK_D3,SCLK_D2,SCLK_D1} <= 3'b000;
				//{SLOAD_D3,SLOAD_D2,SLOAD_D1} <= 3'b000;
			end
		else
			begin
				{SCLK_D3,SCLK_D2,SCLK_D1} <=  {SCLK_D2,SCLK_D1,SCLK};
				//{SLOAD_D3,SLOAD_D2,SLOAD_D1} <=  {SLOAD_D2,SLOAD_D1,SLOAD};
			end
	end


always@(posedge SYSCLK or negedge RESET_N)
	 begin
		if(RESET_N == 1'b0)
			begin
				STATE <= `IDLE;
				HDD_CNT <= 8'h0;
				ACT_LED <= `ACT_LED_DFT;
				FLT_LED <= `FLT_LED_DFT;
				ACT_LED_TMP <= `ACT_LED_DFT;
				FLT_LED_TMP <= `FLT_LED_DFT;
			end
		else
			begin
				case(STATE)
					`IDLE:	begin
								HDD_CNT <= 8'h0;
								ACT_LED <= ACT_LED;
								FLT_LED <= FLT_LED;
								ACT_LED_TMP <= `ACT_LED_DFT;
								FLT_LED_TMP <= `FLT_LED_DFT;
								STATE <= (SCLK_N & SLOAD)? `ACT_RECV : STATE;
							end
					`ACT_RECV:	begin
									ACT_LED_TMP <= SCLK_N? {SDOUT,ACT_LED_TMP[`HDD_NUM-1:1]} : ACT_LED_TMP;
									STATE <= (FRM_STAT | TIME_OUT)? `IDLE : (SCLK_N? `NULL_RECV : STATE);
								end
					`NULL_RECV:	begin
									STATE <= (FRM_STAT | TIME_OUT)? `IDLE : (SCLK_N? `FLT_RECV : STATE);
								end
					`FLT_RECV:	begin
									FLT_LED_TMP <= SCLK_N? {SDOUT,FLT_LED_TMP[`HDD_NUM-1:1]} : FLT_LED_TMP;
									HDD_CNT <= SCLK_N? ((HDD_CNT < `HDD_NUM)? (HDD_CNT + 1'b1) : 0) : HDD_CNT;
									STATE <= SCLK_N? ((HDD_CNT== (`HDD_NUM - 1))? `END : `ACT_RECV) : ((FRM_STAT | TIME_OUT)? `IDLE : STATE);
								end
					`END:	begin
								ACT_LED <= ACT_LED_TMP;
								FLT_LED <= FLT_LED_TMP;
								STATE <= `ACT_RECV;
								ACT_LED_TMP <= `ACT_LED_DFT;
								FLT_LED_TMP <= `FLT_LED_DFT;
								HDD_CNT <= 8'h0;
							end
				endcase
			end
	end


//SGPIO time out
always@(posedge SYSCLK or negedge RESET_N)
	 begin
		if(RESET_N == 1'b0)
			begin
				CNT <= 32'h0;
				TIME_OUT <= 1'b0;
			end
		else
			begin
				CNT <= (STATE ==`IDLE)? 0 : ((CNT< `SGPIO_TIMEOUT)? CNT+1 : CNT);
				TIME_OUT <= (CNT == `SGPIO_TIMEOUT)? 1'b1 : 0;
			end
	end

endmodule