`timescale 1ns / 1ps
module display(
    input clk,
    input istop,
    input isground,
    input isreadyregion,
    input isendingregion,
    input isleft,
    input isright,
    input isbird,
    input ispillar,
    input [2:0] state,
    output reg [4:0] display
    );
    
    // mode 0 is defalt display black, in case of edge
    
    always@(posedge clk) begin
        if(istop) display <= 5'd1;  // always display
        else if(isleft) display <= 5'd2;    // always has, left bar
        else if(isright) display <= 5'd3;   // always has, right bar
        else if(!state[1] && isground) display <= 5'd9;   // always has, bottom, but at playing is under ghost
        else if(state[0] && isreadyregion) display <= 5'd4;     // else if ready state and in ready pic
        else if(state[2] && isendingregion) display <= 5'd5;    // else if ready state and in ending pic
        else if(state[1]) begin // when playing
            if(isbird) display <= 5'd8; // bird
            else if(ispillar) display <= 5'd10; // pillar above ground
            else if(isground) display <= 5'd6;   // ground should be under bird
            else display <= 5'd7;    // playing background
        end
        else display <= 5'd0;   // default black
    end
endmodule
