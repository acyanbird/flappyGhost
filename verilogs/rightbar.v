`timescale 1ns / 1ps

module rightbar(
    input clk,
    input [10:0] pos_x,
    input [10:0] pos_y,
    input [2:0] state,
    output reg [3:0] rightr,
    output reg [3:0] rightg,
    output reg [3:0] rightb,
    output reg isright
    );
    
    //    for image handling
    reg [18:0] pic_addr;
    wire [11:0] pic_color;
    
    always@(posedge clk) begin
        if((100 <= pos_y) && (pos_y < 900) && (pos_x >= 1090) && (pos_x < 1440)) begin  // is in display region
            isright <= 1'b1;
            pic_addr <= ((pos_y - 100)*350 + (pos_x - 1090 - 1));
            rightr <= pic_color[11:8];
            rightg <= pic_color[7:4];
            rightb <= pic_color[3:0];
        end
        else begin  // out of range
            isright <= 1'b0;
            rightr <= 4'h0;
            rightg <= 4'h0;
            rightb <= 4'h0;
        end
    end

assign pic_color = (out)?12'hfff:12'h213;
    
sider rightpic (
  .clka(clk),    // input wire clka
  .addra(pic_addr),  // input wire [18 : 0] addra
  .douta(out)  // output wire [0 : 0] douta
);
endmodule
