//************************************************************************
//**                          Baseboard CPLD							**
//**                          PCIE_RST_CTRL.v                           **
//************************************************************************ 

//**********************      ChangeList      *****************************

`include "../SRC/baseboard_define.v"

module PCIE_RST_CTRL (

            // Driver power ok input
; for ($i=0; $i<24; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            input       DRV${j3}_PWROK,DRV${j2}_PWROK,DRV${j1}_PWROK,DRV${j0}_PWROK,
; }
            // PCIE reset portA output
; for ($i=0; $i<24; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            output reg  PE_RST_DRV${j3}_A_L,PE_RST_DRV${j2}_A_L,PE_RST_DRV${j1}_A_L,PE_RST_DRV${j0}_A_L,
; }
            // PCIE reset portB output
; for ($i=0; $i<24; $i=$i+4) {
; $j0=$i;
; $j1=$i+1;
; $j2=$i+2;
; $j3=$i+3;
            output reg  PE_RST_DRV${j3}_B_L,PE_RST_DRV${j2}_B_L,PE_RST_DRV${j1}_B_L,PE_RST_DRV${j0}_B_L,
; }
            // System
			input     SYSCLK,
			input     RESET_N
			
            );

; for ($i=0; $i<24; $i++) {
//PCIE RESET ${i}
reg       [17:0]  CNT${i};
always@(posedge SYSCLK or negedge RESET_N)
	begin
		if(RESET_N == 1'b0)
			begin
				CNT${i}                  <= 'b0;
				PE_RST_DRV${i}_A_L       <= 'b1;
				PE_RST_DRV${i}_B_L       <= 'b1;
			end
		else
		    begin
				CNT${i}                  <= ((CNT${i} < `TIME_100MS) && (DRV${i}_PWROK == 1'b1))? (CNT${i} + 18'b1) : ((DRV${i}_PWROK == 1'b1)? CNT${i} : 0);
				PE_RST_DRV${i}_A_L       <= (CNT${i} == `TIME_100MS)? 1'b0 : 1'b1;
				PE_RST_DRV${i}_B_L       <= (CNT${i} == `TIME_100MS)? 1'b0 : 1'b1;
			end
	end
; }	

endmodule