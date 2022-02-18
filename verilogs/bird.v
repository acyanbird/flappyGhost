`timescale 1ns / 1ps
module bird(
    input clk,
    input frameclk,
    input up,
    input down,
    input [2:0] state,
    input [5:0] count,
    input [10:0] pos_x,
    input [10:0] pos_y,
    input sw0,
    output reg isbird,
    output reg [3:0] birdr,
    output reg [3:0] birdg,
    output reg [3:0] birdb,
    output reg [10:0] birdx,
    output reg [10:0] birdy
    );
    
    // for image handling
    reg [17:0] pic_addr;
    reg [11:0] pic_color;
    wire [11:0] pic1;
    wire [11:0] pic2;

    // init position of bird, left top corner    
 
    initial begin
        birdx = 420;
        birdy = 460;
    end
    
    always@(posedge frameclk) begin // det bird moving
        if(state[1]) begin  // if is playing
            if(up) birdy <= birdy - 11'd8;
            else if(down) birdy <= birdy + 11'd8;
            else if(sw0) birdy <= birdy;    // cheat code, prevent bird falling
            else birdy <= birdy + 11'd3;
        end
        else birdy <= 11'd460;  // reset position
    end
    
    always@(posedge clk) begin
        if((pos_x >= birdx) && (pos_x <= (birdx+84)) && (pos_y >= birdy) && (pos_y <= (birdy+90))) begin
            isbird <= 1'b1;
            pic_addr <= ((pos_y - birdy)*84 + (pos_x - birdx - 1));
            birdr <= pic_color[11:8];
            birdg <= pic_color[7:4];
            birdb <= pic_color[3:0];
         end
        else begin
            isbird <= 1'b0;
            birdr <= 4'h7;
            birdg <= 4'hc;
            birdb <= 4'hc;
            pic_addr <= 1;
        end
    end
    
    always@(posedge clk) begin
    if (count <= 30) pic_color <= pic1;
    else pic_color <= pic2;
    end
    
    
ghost1 ghost1 (
  .clka(clk),    // input wire clka
  .addra(pic_addr),  // input wire [12 : 0] addra
  .douta(pic1)  // output wire [11 : 0] douta
);

ghost2 ghost2 (
  .clka(clk),    // input wire clka
  .addra(pic_addr),  // input wire [12 : 0] addra
  .douta(pic2)  // output wire [11 : 0] douta
);
            
endmodule
