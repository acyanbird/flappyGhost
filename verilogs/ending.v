module ending(
    input clk,
    input [10:0] pos_x,
    input [10:0] pos_y,
    input [5:0] count,
    output reg [3:0] endingr,
    output reg [3:0] endingg,
    output reg [3:0] endingb,
    output reg isendingregion
    );
    
    reg [18:0] pic_addr;
    wire [11:0] pic_color;
    reg [11:0] font_color;
    
    always@(posedge clk) begin
        if((pos_y >= 100) && (pos_y < 750) && (350 <= pos_x) && (1090 > pos_x)) begin   // if pix in ending pic region
            isendingregion <= 1'b1;
            pic_addr <= ((pos_y - 100)*740 + (pos_x - 350 - 1));
            endingr <= pic_color[11:8];
            endingg <= pic_color[7:4];
            endingb <= pic_color[3:0];
        end
        else begin  // outside region
            endingr <= 4'h7;
            endingg <= 4'hc;
            endingb <= 4'hc;
            isendingregion <= 1'b0;
        end
    end
    
    always@(posedge clk) begin
        if(count <= 30) font_color <= 12'h104;
        else font_color <= 12'hf73;
    end
    
    assign pic_color = (out)?12'h7cc:font_color;
    
endPic endpic (
  .clka(clk),    // input wire clka
  .addra(pic_addr),  // input wire [18 : 0] addra
  .douta(out)  // output wire [0 : 0] douta
);
            
endmodule