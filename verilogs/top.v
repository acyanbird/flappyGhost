`timescale 1ns / 1ps

module top(
    input clk,
    input [5:0] count,
    input [10:0] pos_x,
    input [10:0] pos_y,
    // color of top
    output reg [3:0] topr,
    output reg [3:0] topg,
    output reg [3:0] topb,
    // if is in top range
    output reg istop
    );
    
    reg [17:0] pic_addr;
    wire [11:0] pic_color;
    
    // 1 is orange, 0 purple
        
    always@(posedge clk) begin
        if((pos_x >= 0) && (pos_x < 1440) && (pos_y >= 0) && (pos_y < 100)) begin
            istop <= 1'b1;
            pic_addr <= (pos_y * 1440 + pos_x - 1);
            topr <= pic_color[11:8];
            topg <= pic_color[7:4];
            topb <= pic_color[3:0];
        end
        else begin
            topr <= 4'h7;
            topg <= 4'hc;
            topb <= 4'hc;
            istop <= 1'b0;
            pic_addr <= 18'd1;
        end
    end
    
    assign pic_color = (out)?12'hf73:12'h213;       
    
info img (
  .clka(clk),    // input wire clka
  .addra(pic_addr),  // input wire [17 : 0] addra
  .douta(out)  // output wire [0 : 0] douta
);
    
endmodule
