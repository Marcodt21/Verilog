// -----------------------------------------------------------------------------
// Autor: Angel Terrones <aterrones@usb.ve>
// Modulo: clock divider
// -----------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module clk_div #(
                 parameter CLK_XTAL    = 50000000,
                 parameter CLK_DISPLAY = 60,
                 parameter CLK_BANNER  = 1
                 )(
                   input wire clk,
                   input wire rst,
                   output reg tick_display,
                   output reg tick_banner
                   );
    //--------------------------------------------------------------------------
    //WARNING: (CLK_DISPLAY/CLK_BANNER) % 4 == 0

    // Escriba su código acá :)
reg [19:0] cd=20'b11111111111111111111;
reg [25:0] cb=26'b11111111111111111111111111;

always@(posedge clk)
    begin
	if(rst)
	   begin
	    cb<=0;
		cd<=0;
	   end
	else if(cd>=829999 && cb<49999999)
	   begin
	     cd<=0;
		 cb<=cb+1;
	   end
	else if(cb>=49999999 && cd<829999)
	   begin
	    cb<=0;
		cd<=cd+1;
	   end
	else
	   begin 
	    cd<=cd+1;
		cb<=cb+1;
	   end
	end
assign tick_banner=(cb<=(50000000/2)-1)? 1'b1: 1'b0;
assign tick_display=(cd<=(83000/2)-1) ? 1'b1: 1b'0;

    //--------------------------------------------------------------------------
endmodule // clk_div
// EOF
