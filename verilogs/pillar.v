`timescale 1ns / 1ps

module pillar(
    input sysclk,
    input clk,
    input frameclk,
    input [10:0] pos_x,
    input [10:0] pos_y,
    input [2:0] state,
    input [10:0] birdy,
    output reg ispillar,
    output reg [10:0] p1x,
    output reg [10:0] p1y,
    output reg [10:0] p2x,
    output reg [10:0] p2y, 
    output reg [3:0] pillarr,
    output reg [3:0] pillarg,
    output reg [3:0] pillarb,
    output reg [13:0] score
    );
    // totally 2 pillar
    // pillar start with x:1270, y: 400
    
    // det pillar co
    wire [8:0] outy;    


    always@(posedge frameclk) begin
        if(state[0]) begin   // ready
            p1x <= 11'd1234;
            p1y <= 11'd400;
            p2x <= 11'd1640;
            p2y <= 11'd400;
            score <= 0;
        end
        else if(state[1]) begin // playing
            // moving each pillar
            if(p1x <= 420) begin    // bird pass pillar1
                score <= score + 1;
                p1x <= p2x + 406;
                p1y <= 108 + (outy % 524);
                p2x <= p2x - 5;
                p2y <= p2y;
            end
            else if(p2x <= 420) begin    // bird pass pillar2
                score <= score + 1;
                p2x <= p1x + 406;
                p2y <= 108 + (outy % 524);
                p1x <= p1x - 5;
                p1y <= p1y;
            end
            else begin
                p1x <= p1x - 5;
                p1y <= p1y;
                p2x <= p2x - 5;
                p2y <= p2y;
                score <= score;
            end         
        end
        else begin  //end
            score <= score;
            p1x <= 11'd1234;
            p1y <= 11'd400;
            p2x <= 11'd1640;
            p2y <= 11'd400;
        end
    end
    
    // output pix info
    always@(posedge clk) begin
    // pink
        if(((pos_y <= p1y) || (pos_y >= (p1y + 260))) && (pos_x <= p1x) && (pos_x >= (p1x - 144))) begin
            pillarr <= 4'hf;
            pillarg <= 4'h0;
            pillarb <= 4'h7;
            ispillar <= 1;
        end
        // brown
        else if(((pos_y <= p2y) || (pos_y >= (p2y + 260))) && (pos_x <= p2x) && (pos_x >= (p2x - 144))) begin
            pillarr <= 4'h9;
            pillarg <= 4'h5;
            pillarb <= 4'h0;
            ispillar <= 1;
        end
        else begin
            pillarr <= 4'h7;
            pillarg <= 4'hc;
            pillarb <= 4'hc;
            ispillar <= 0;
        end
    end
    
ran ranNum(
    .clk(sysclk),
    .out(outy)
);
                           
                    
endmodule
