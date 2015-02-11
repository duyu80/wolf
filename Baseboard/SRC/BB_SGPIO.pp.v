//************************************************************************
//**                          Baseboard CPLD							**
//**                          SGPIO.v                                   **
//************************************************************************ 

//**********************      ChangeList      *****************************

`include "../SRC/baseboard_define.v"

module BB_SGPIO (
            // System
			input        SYSCLK,
			input        RESET_N,
			// Driver active led input
; for ($i=0; $i<36; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            input        DRV${j3}_ACT_LED,DRV${j2}_ACT_LED,DRV${j1}_ACT_LED,DRV${j0}_ACT_LED,
; }			
            // SGPIO
            output reg   SGPIO_CK,
            output reg   SGPIO_LD,
			output reg   SGPIO_DATA
			);

reg		[35:0]	ACT_LED;
reg		[35:0]	ACT_LED_TMP;

reg		[7:0]	STATE;
reg		[7:0]	HDD_CNT;

reg				SGPIO_CK_D3,SGPIO_CK_D2,SGPIO_CK_D1;

reg		[31:0]	CNT;
reg				TIME_OUT;

wire			SGPIO_CK_P = ~SGPIO_CK_D3 & SGPIO_CK_D2 & SGPIO_CK_D1 & SGPIO_CK;
wire			SGPIO_CK_N = SGPIO_CK_D3 & ~SGPIO_CK_D2 & ~SGPIO_CK_D1 & ~SGPIO_CK;

always@(posedge SYSCLK or negedge RESET_N)
    begin
		if(RESET_N == 1'b0)
			begin
			    CNT       <= 'b0;
				SGPIO_CK  <= 'b0;
				ACT_LED   <= 'b0;
			end
		else
		    begin
			    CNT <= (CNT < `FRQ_100K)? (CNT + 1'b1) : 0;
				SGPIO_CK <= (CNT == `FRQ_100K)? ~SGPIO_CK : SGPIO_CK;
				ACT_LED   <=  { DRV35_ACT_LED,DRV34_ACT_LED,DRV33_ACT_LED,DRV32_ACT_LED,
								DRV31_ACT_LED,DRV30_ACT_LED,DRV29_ACT_LED,DRV28_ACT_LED,
								DRV27_ACT_LED,DRV26_ACT_LED,DRV25_ACT_LED,DRV24_ACT_LED,
								DRV23_ACT_LED,DRV22_ACT_LED,DRV21_ACT_LED,DRV20_ACT_LED,
								DRV19_ACT_LED,DRV18_ACT_LED,DRV17_ACT_LED,DRV16_ACT_LED,
								DRV15_ACT_LED,DRV14_ACT_LED,DRV13_ACT_LED,DRV12_ACT_LED,
								DRV11_ACT_LED,DRV10_ACT_LED,DRV9_ACT_LED,DRV8_ACT_LED,
								DRV7_ACT_LED,DRV6_ACT_LED,DRV5_ACT_LED,DRV4_ACT_LED,
								DRV3_ACT_LED,DRV2_ACT_LED,DRV1_ACT_LED,DRV0_ACT_LED };
			end
	end

always@(posedge SYSCLK or negedge RESET_N)
	 begin
		if(RESET_N == 1'b0)
			begin
				{SGPIO_CK_D3,SGPIO_CK_D2,SGPIO_CK_D1} <= 3'b000;
			end
		else
			begin
				{SGPIO_CK_D3,SGPIO_CK_D2,SGPIO_CK_D1} <=  {SGPIO_CK_D2,SGPIO_CK_D1,SGPIO_CK};
			end
	end


always@(posedge SYSCLK or negedge RESET_N)
	 begin
		if(RESET_N == 1'b0)
			begin
				STATE         <= `IDLE;
				HDD_CNT       <= 8'h0;
				ACT_LED_TMP   <= 'h0;
				SGPIO_LD      <= 1'b0;
				SGPIO_DATA    <= 1'b0;
			end
		else
			begin
				case(STATE)
					`IDLE:	        begin
							        	HDD_CNT      <= 8'h0;
							        	ACT_LED_TMP  <= ACT_LED;
										SGPIO_DATA   <= 1'b0;
							        	STATE        <= `ACT_RECV;
							        end
					`ACT_RECV:	    begin
					                    SGPIO_LD     <= SGPIO_CK_P? 1'b0 : SGPIO_LD;
					                    ACT_LED_TMP  <= SGPIO_CK_P? (ACT_LED_TMP >> 1) : ACT_LED_TMP;
								    	SGPIO_DATA   <= SGPIO_CK_P? ACT_LED_TMP[0] : SGPIO_DATA;
								    	STATE        <= (SGPIO_CK_P? `NULL_RECV1 : STATE);
								    end
					`NULL_RECV1:	begin
					                    SGPIO_DATA   <= SGPIO_CK_P? 1'b0 : SGPIO_DATA;
									    STATE        <= (SGPIO_CK_P? `NULL_RECV2 : STATE);
								    end
					`NULL_RECV2:	begin
									    HDD_CNT      <= SGPIO_CK_P? ((HDD_CNT < `HDD_NUM)? (HDD_CNT + 1'b1) : 0) : HDD_CNT;
										SGPIO_LD     <= (SGPIO_CK_P && (HDD_CNT== (`HDD_NUM - 1)))? 1'b1 : 1'b0;
										SGPIO_DATA   <= SGPIO_CK_P? 1'b0 : SGPIO_DATA;
									    STATE        <= SGPIO_CK_P? ((HDD_CNT== (`HDD_NUM - 1))? `IDLE : `ACT_RECV) : STATE;
								    end
					default:	    begin
								        STATE <= `IDLE;
							        end
				endcase
			end
	end

endmodule