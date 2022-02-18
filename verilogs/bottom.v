`timescale 1ns / 1ps
module bottom(
    input clk,
    input [10:0] pos_y,
    input [10:0] pos_x,
    // color of ground
    output reg [3:0] groundr,
    output reg [3:0] groundg,
    output reg [3:0] groundb,
    // if is in ground range
    output reg isground
    );
    

// image def
    reg [17:0] pic_addr;
    wire [11:0] pic_color;
        
    always@(posedge clk) begin
        if((pos_y < 900) && (pos_y >= 750) && (350 <= pos_x) && (1090 > pos_x)) begin
            isground <= 1'b1;
            pic_addr <= ((pos_y - 750)*740 + (pos_x - 350 - 1));
            groundr <= pic_color[11:8];
            groundg <= pic_color[7:4];
            groundb <= pic_color[3:0];
        end
        else begin
            groundr <= 4'h7;
            groundg <= 4'hc;
            groundb <= 4'hc;
            isground <= 1'b0;
            pic_addr <= 1;
        end
    end
    
ground inst_ground (
  .clka(clk),    // input wire clka
  .addra(pic_addr),  // input wire [16 : 0] addra
  .douta(pic_color)  // output wire [11 : 0] douta
);
    
    
endmodule

