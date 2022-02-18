`timescale 1ns / 1ps

module light(
    input [2:0] state,
    input [1:0] sw,
    output [1:0] LED,
    output LED16_B,
    output LED16_G,
    output LED16_R,
    output LED17_B,
    output LED17_G,
    output LED17_R
    );
    
    assign LED16_B = state[0];
    assign LED17_B = state[0];
    assign LED16_R = state[2];
    assign LED17_R = state[2];
    assign LED16_G = state[1];
    assign LED17_G = state[1];
    assign LED[0] = sw[0];
    assign LED[1] = sw[1];


endmodule
