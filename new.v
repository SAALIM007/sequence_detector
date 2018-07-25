`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:35:43 11/09/2017 
// Design Name: 
// Module Name:    new 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
module detector(x,clk,y,reset); //

input x,reset;
input clk;
output y;

reg q0,q1,q2;
wire d0,d1,d2;

wire y;

// external circuit for inputs of the D-filpflops.

// d0

assign d0 = ( (q1 & (~q0)) | (x & (~q1)) );

// d1

assign d1 = ((~x) & ( q2 | (q1^q0) ));


//d2

assign d2 = ( q1 & q0 & x );


// y

assign y = ( x & (~q2) & q1 & q0 );

always @(negedge clk) // three D filpflops with d0,d1,d2 as input and q0,q1,q2 as outputs
begin
if(reset) 
begin
	q0 <= 1'b0 ;
	q1 <= 1'b0 ;
	q2 <= 1'b0 ;
end

else
begin
	q0 <= d0 ;
	q1 <= d1 ;
	q2 <= d2 ;
end
end



endmodule

module testbench ;

reg reset, clk, x;
reg [15:0] data;
integer i;
detector det (.x(x),.clk(clk),.y(y),.reset(reset));
reg q0,q1,q2;


initial 
begin
data = 16'b0010010001001001;
i = 0;
$monitor($time, , ,"clk=%b",clk,,"output=%b",y,,"reset=%b",reset,,"input=%b",x);
reset = 1'b1; 
#10 reset = 1'b0;
#300 $stop;
end

initial 
begin

clk = 0;

forever begin
#5 clk = ~clk;
end
end






always @ (posedge clk)

begin
 x = data >> i;
i = i+1;
end
endmodule







