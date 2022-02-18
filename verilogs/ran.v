`timescale 1ns / 1ps

module ran(
    input clk,
    output reg [9:0] out
    );
	 
	 reg [20:0] rand;
	 initial rand = ~(20'b0);
	 reg [20:0] next;
	 wire f0, f1, f2, f3;
	 	 
	 assign f0 = rand[20] ^ rand[13];
	 assign f1 = rand[2] ^ rand [9];
	 assign f2 = rand[0] ^ rand[16];
	 assign f3 = rand[5] ^ rand[17]; 
	 
	 always @ (posedge clk)
	 begin
		rand <= next;
		out = rand[9:0];
	 end
	 
	 always@*
	 begin
		next = {rand[13:0],f3, f2, rand[4:3], f0, f1};
	 end

endmodule
