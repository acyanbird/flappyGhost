`timescale 1ns / 1ps
module leftbar(
    input clk,
    input [10:0] pos_x,
    input [10:0] pos_y,
    input [2:0] state,
    output reg [3:0] leftr,
    output reg [3:0] leftg,
    output reg [3:0] leftb,
    output reg isleft
    );
    
    //    for image handling
    reg [18:0] pic_addr;
    wire [11:0] pic_color;
        
    always@(posedge clk) begin
        if((100 <= pos_y) && (pos_y < 900) && (pos_x >= 0) && (pos_x <= 349)) begin  // is in display region
            isleft <= 1'b1;
            pic_addr <= ((pos_y - 100)*350 + (pos_x - 1));
            leftr <= pic_color[11:8];
            leftg <= pic_color[7:4];
            leftb <= pic_color[3:0];                  
        end
        else begin  
            isleft <= 1'b0;
            leftr <= 4'h0;
            leftg <= 4'h0;
            leftb <= 4'h0;
        end
    end
    
assign pic_color = (out)?12'hfff:12'h213;
    
sidel leftpic (
  .clka(clk),    // input wire clka
  .addra(pic_addr),  // input wire [18 : 0] addra
  .douta(out)  // output wire [0 : 0] douta
);
    
endmodule
