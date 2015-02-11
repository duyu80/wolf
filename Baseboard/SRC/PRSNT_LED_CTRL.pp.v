//************************************************************************
//**                          Baseboard CPLD							**
//**                          PRSNT_LED_CTRL.v						    **
//************************************************************************ 

//**********************      ChangeList      *****************************

`include "../SRC/baseboard_define.v"

module PRSNT_LED_CTRL (
            // System
			input      SYSCLK,
			input      RESET_N,
            // Driver present and amber LED inout
; for ($i=0; $i<36; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
			inout      DRV${j3}_PRSNT_AMBER_LED,DRV${j2}_PRSNT_AMBER_LED,DRV${j1}_PRSNT_AMBER_LED,DRV${j0}_PRSNT_AMBER_LED,
; }
            // Driver identify and blue LED inout
; for ($i=0; $i<36; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
			inout      DRV${j3}_IFDET_BLUE_LED,DRV${j2}_IFDET_BLUE_LED,DRV${j1}_IFDET_BLUE_LED,DRV${j0}_IFDET_BLUE_LED,
; }
            // Amber LED data
			input      [35:0]    AMBER_DAT,
            // Blue LED data
            input      [35:0]    BLUE_DAT,			
            // Present signal
			output reg [35:0]    PRSNT,
			// Identify signal
			output reg [35:0]    IDENT
			);

reg    [31:0]  CNT;
reg    [35:0]  DRV_PRSNT_AMBER_LED_EN;
reg    [35:0]  DRV_IFDET_BLUE_LED_EN;

always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
			    CNT                    <= 32'h0;
				DRV_PRSNT_AMBER_LED_EN <= 36'h0;
				DRV_IFDET_BLUE_LED_EN  <= 36'h0;
			end
		else
		    begin
			    CNT                    <= (CNT < `TIME_100MS)? (CNT + 32'd1) : 32'd0;
				DRV_PRSNT_AMBER_LED_EN <= (CNT < `TIME_99MS)? 36'hf_ffff_ffff : 36'h0;
				DRV_IFDET_BLUE_LED_EN  <= (CNT < `TIME_99MS)? 36'hf_ffff_ffff : 36'h0;
			end
	end

always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
			    PRSNT <= 36'h0;
				IDENT <= 36'h0;
			end
		else
		    begin
			
			    PRSNT <= (CNT == `TIME_100MS)? {
; for ($i=35; $i>4; $i=$i-4) {
; $j0=$i;
; $j1=$i-1;
; $j2=$i-2;
; $j3=$i-3;
			    ~DRV${j0}_IFDET_BLUE_LED,~DRV${j1}_IFDET_BLUE_LED,~DRV${j2}_IFDET_BLUE_LED,~DRV${j3}_IFDET_BLUE_LED,			
; }
                ~DRV3_IFDET_BLUE_LED,~DRV2_IFDET_BLUE_LED,~DRV1_IFDET_BLUE_LED,~DRV0_IFDET_BLUE_LED
                } : PRSNT;
				
                IDENT <= (CNT == `TIME_100MS)? {
; for ($i=35; $i>4; $i=$i-4) {
; $j0=$i;
; $j1=$i-1;
; $j2=$i-2;
; $j3=$i-3;
			    DRV${j0}_PRSNT_AMBER_LED,DRV${j1}_PRSNT_AMBER_LED,DRV${j2}_PRSNT_AMBER_LED,DRV${j3}_PRSNT_AMBER_LED,			
; }
                DRV3_PRSNT_AMBER_LED,DRV2_PRSNT_AMBER_LED,DRV1_PRSNT_AMBER_LED,DRV0_PRSNT_AMBER_LED
                } : IDENT;

			end
	end


; for ($i=0; $i<36; $i++) {
assign    DRV${i}_PRSNT_AMBER_LED = DRV_PRSNT_AMBER_LED_EN[${i}]? AMBER_DAT[${i}] : 1'bz;
; }

; for ($i=0; $i<36; $i++) {
assign    DRV${i}_IFDET_BLUE_LED = DRV_IFDET_BLUE_LED_EN[${i}]? BLUE_DAT[${i}] : 1'bz;
; }	

endmodule