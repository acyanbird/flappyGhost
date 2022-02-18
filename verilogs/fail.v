`timescale 1ns / 1ps

// moudle to det weather game fail
module fail(
    input [2:0] state,
    input clk,
    input [10:0] birdx,
    input [10:0] birdy,
//    input isbird,
//    input ispillar,
    input [10:0] p1x,
    input [10:0] p1y,
    input [10:0] p2x,
    input [10:0] p2y,
    input sw1,    
    output reg isfail
    );
    
    // now just det weather bird fall out of range
    initial isfail = 1'b0;
    
    always@(posedge clk) begin
        if(state[1]) begin
            if((birdy <= 100) || (birdy >= 827)) isfail <= 1'b1;    // if is playing and birdy is out of range   
//            else if((isbird == 1) && (ispillar == 1)) isfail <= 1'b1;
// cheat code, touch pillar not fail
            else if(((birdy <= p1y) || (birdy >= (p1y + 172))) && (birdx <= p1x) && (birdx >= (p1x - 144 - 84)) && !sw1) isfail <= 1'b1;
            else if(((birdy <= p2y) || (birdy >= (p2y + 172))) && (birdx <= p2x) && (birdx >= (p2x - 144 - 84)) && !sw1) isfail <= 1'b1;            
            else isfail <= 1'b0;
        end
        else isfail <= 1'b0;
    end
    
endmodule
