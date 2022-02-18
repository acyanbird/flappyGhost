`timescale 1ns / 1ps

module ready(
    input clk,
    input [10:0] pos_x,
    input [10:0] pos_y,
    input [5:0] count,
    output reg [3:0] readyr,
    output reg [3:0] readyg,
    output reg [3:0] readyb,
    output reg isreadyregion
    );
    
//    for image handling
    reg [18:0] pic_addr;
    wire [11:0] pic_color;
    reg [11:0] font_color;

    
    always@(posedge clk) begin
        if((pos_y >= 100) && (pos_y < 750) && (350 <= pos_x) && (1090 > pos_x)) begin   // if pix in ready pic region
            isreadyregion <= 1'b1;
            pic_addr <= ((pos_y - 100)*740 + (pos_x - 350 -1));
            readyr <= pic_color[11:8];
            readyg <= pic_color[7:4];
            readyb <= pic_color[3:0];
        end
        else begin  // outside region
            readyr <= 4'h7;
            readyg <= 4'hc;
            readyb <= 4'hc;
            isreadyregion <= 1'b0;
        end
    end
    
     always@(posedge clk) begin
        if(count <= 30) font_color <= 12'h836;
        else font_color <= 12'hf53;
    end
    
    assign pic_color = (out)?12'h7cc:font_color;
    
startPic startpic (
  .clka(clk),    // input wire clka
  .addra(pic_addr),  // input wire [18 : 0] addra
  .douta(out)  // output wire [0 : 0] douta
);
        
endmodule
