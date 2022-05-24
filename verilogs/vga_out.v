`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2016 09:33:12
// Design Name: 
// Module Name: vga_out
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


/* 
    NOTE YOU WILL NEED TO FIX THE MISSING SECTIONS OF VERILOG BEFORE THIS WILL RUN
*/

module vga_out(
    input clk,
    input [3:0] draw_r,
    input [3:0] draw_g,
    input [3:0] draw_b,
    output [3:0] pix_r,
    output [3:0] pix_g,
    output [3:0] pix_b,
    output [10:0] curr_x,
    output [10:0] curr_y,
    output hsync,
    output vsync
    );
    
//    wire pixclk;
    
    reg [10:0] curr_x_r, curr_y_r = 0;
    
    
//    clk_wiz_0 instance_name(.clk_out1(pixclk),.clk_in1(clk));
    
    reg [10:0] hcount = 0;
    reg [9:0] vcount = 0;
    
    
    wire line_end = (hcount == 11'd1904);
    wire frame_end = (vcount == 10'd932);

    assign display_region = ((hcount >= 11'd384) && (hcount <= 11'd1823) && (vcount >= 10'd31) && (vcount <= 10'd930));
    assign hsync = ((hcount >= 11'd0) && (hcount <= 11'd151));
    assign vsync = ((vcount >= 10'd0) && (vcount <= 10'd2));
        
    // condition ? if true : if false
    assign pix_r = (display_region) ? draw_r : 4'b0000;
    assign pix_g = (display_region) ? draw_g : 4'b0000;
    assign pix_b = (display_region) ? draw_b : 4'b0000;
      
    always@(posedge clk) begin
        if(line_end) begin
            hcount <= 11'd0;
        end else begin
            hcount <= hcount + 1;
        end
    end
    
    always@(posedge clk) begin
        if(frame_end) begin
            vcount <= 10'd0;
        end else begin
            if(line_end) begin
                vcount <= vcount + 1;
            end
        end
    end
    
    // curr_x
    always@(posedge clk) begin
        if((hcount >= 11'd384) && (hcount<= 11'd1824)) begin
            curr_x_r <= curr_x_r + 1;
        end else begin
            curr_x_r <= 11'd0;
        end
    end
    
    // curr_y
    always@(posedge clk) begin
        if(vcount >= 2) begin
            if(line_end) curr_y_r <= curr_y_r + 11'd1;
            else curr_y_r <= curr_y_r;
        end
        else curr_y_r <= 11'd0;
    end
    
    assign curr_x = curr_x_r;
    assign curr_y = curr_y_r;
    
endmodule
