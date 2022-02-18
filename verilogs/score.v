`timescale 1ns / 1ps

module score(
    input clk,
    input [13:0] score,
    output [7:0] an,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
    );
    
    reg [3:0] d1, d2, d3, d4;
    
    always@* begin
        d1 <= score % 10;
        d2 <= score / 10 % 10;
        d3 <= score / 100 % 10;
        d4 <= score / 1000;
    end
    
    segInterface interface(
        .clk(clk),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .d4(d4),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .an(an)
     );  
endmodule
