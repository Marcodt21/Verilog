// -----------------------------------------------------------------------------
// Autor: Angel Terrones <aterrones@usb.ve>
// Modulo: Driver 7-segmentos
// -----------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module banner #(
                parameter CLK_XTAL    = 50000000,
                parameter CLK_DISPLAY = 60,
                parameter CLK_BANNER  = 1
                )(
                  input wire        clk,
                  input wire        rst,
                  output wire [3:0] anodos,
                  output wire [7:0] segmentos,
                  output reg        shift
                  );
    //--------------------------------------------------------------------------
    // WARNING: READ ONLY
    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire                tick_banner;            // From clkdiv of clk_div.v
    wire                tick_display;           // From clkdiv of clk_div.v
    // End of automatics
    reg [3:0] number2show;
    reg       off_display;
    // ---------------------------------
    reg [3:0] n1;
	reg [3:0] n2;
	reg [3:0] n3;
	reg [3:0] n0;
	reg [3:0] nextstate; 
    // Escriba su código acá :)
 parameter s0=4'b0000;
 parameter s1=4'b0001;
 parameter s2=4'b0010;
 parameter s3=4'b0011;
 parameter s4=4'b0100;
 parameter s5=4'b0101;
 parameter s6=4'b0110;
 parameter s7=4'b0111;
 parameter s8=4'b1000;
 parameter s9=4'b1001;
parameter s10=4'b1010;
parameter s11=4'b1011;
parameter s12=4'b1100;
parameter s13=4'b1101;
parameter s14=4'b1110;
parameter s15=4'b1111;

always @(posedge tick_banner)
   if(rst)begin
   n3<=off_display;
   n2<=off_display;
   n1<=off_display;
   n0<=off_display;
   number2show=s0;
   end
   
   else 
   begin 
    n3<=number2show;
	n2<=n3;
	n1<=n2;
	n0<=n1;
	number2show<=nextstate;
	end
   
always @(*)begin
	shift = tick_banner;
	case(number2show)
	s0:nextstate =s1;
	s1:nextstate=s2;
	s2:nextstate=s3;
	s3:nextstate=s4;
	s4:nextstate=s5;
	s5:nextstate=s6;
	s6:nextstate=s7;
	s7:nextstate=s8;
	s8:nextstate=s9;
	s9:nextstate=s10;
	s10:nextstate=s11;
	s11:nextstate=s12;
	s12:nextstate=s13;
	s13:nextstate=s14;
	s14:nextstate=s15;
	s15:nextstate=s0;
	default: nextstate=s0;
	endcase
end

    // ---------------------------------
    // WARNING: READ ONLY
    // instanciacion
    clk_div #(/*AUTOINSTPARAM*/
              // Parameters
              .CLK_XTAL                 (CLK_XTAL),
              .CLK_DISPLAY              (CLK_DISPLAY),
              .CLK_BANNER               (CLK_BANNER)
              ) clkdiv (/*AUTOINST*/
                        // Outputs
                        .tick_display     (tick_display),
                        .tick_banner      (tick_banner),
                        // Inputs
                        .clk              (clk),
                        .rst              (rst));

    driver7seg driver(.value            (number2show[3:0]),
                      /*AUTOINST*/
                      // Outputs
                      .anodos           (anodos[3:0]),
                      .segmentos        (segmentos[7:0]),
                      // Inputs
                      .clk              (clk),
                      .rst              (rst),
                      .tick_display     (tick_display),
                      .off_display      (off_display));
    //--------------------------------------------------------------------------
endmodule
// EOF
