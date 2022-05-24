`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2020 15:04:15
// Design Name: 
// Module Name: game_top
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



module game_top(
    input clk,
    input [4:0] btn,
    output [3:0] pix_r,
    output [3:0] pix_g,
    output [3:0] pix_b,
    output hsync,
    output vsync
    );
    
   wire pix_clk;
   
   // reg type of draw
   reg [3:0] draw_r_r = 0;
   reg [3:0] draw_g_r = 0;
   reg [3:0] draw_b_r = 0;
   
   
   wire [10:0] curr_x;
   wire [10:0] curr_y;
   
   // init mode
   wire [3:0] mode;
   
   // area to put isobject
   wire istop;
   wire isbottom;
   
   // area to get each output
   wire [3:0] top_r;
   wire [3:0] top_g;
   wire [3:0] top_b;
   
   wire [3:0] bottom_r;
   wire [3:0] bottom_g;
   wire [3:0] bottom_b;
   
   wire [3:0] back_r;
   wire [3:0] back_g;
   wire [3:0] back_b;
   
   
   
   reg game_clk = 0;
   reg [20:0] clk_div = 0;
   
//   reg [10:0] blkpos_x = 11'd703;
//   reg [10:0] blkpos_y = 11'd424;
   
   always@(posedge clk) begin
    if(clk_div == 888742) begin
        clk_div <= 20'd0;
        game_clk <= !game_clk;
    end 
    else begin
        clk_div <= clk_div +1;
    end
   end
   
   // decide which color to vga
   
//   always@(posedge clk) begin
//    case(mode)
//        4'd1: begin
//            draw_r_r <= top_r;
//            draw_g_r <= top_g;
//            draw_b_r <= top_b;
//        end
//        4'd2: begin 
//            draw_r_r <= bottom_r;
//            draw_g_r <= bottom_g;
//            draw_b_r <= bottom_b;
//        end
//        default: begin
//            draw_r_r <= back_r;
//            draw_g_r <= back_g;
//            draw_b_r <= back_b;
//        end
//      endcase
//    end
    
    
//     let reg to wire
//    assign draw_r = draw_r_r;
//    assign draw_g = draw_g_r;
//    assign draw_b = draw_b_r;

assign draw_r = 4'b1000;
assign draw_g = 4'b0000;
assign draw_b = 4'b0000;


   always@* begin
//        if((curr_x < 11'd920) && (curr_x > 11'd520) && (curr_y < 11'd600) && (curr_y > 11'd300)) begin
            draw_r_r <= 4'b1000;
            draw_g_r <= 4'b0000;
            draw_b_r <= 4'b0000;
//        end
    end
    
        
   
//   always@(posedge game_clk) begin
//        if(btn[0]) begin
//            blkpos_x <= 11'd703;
//            blkpos_y <= 11'd424;
//        end
//        else begin
//            case(btn[4:1])
//                4'b0001: begin
//                    if(blkpos_x > 11'd10) begin
//                       blkpos_x <= blkpos_x - 4;
//                    end
//                end
//                default: begin
//                    blkpos_x <= blkpos_x;
//                    blkpos_y <= blkpos_y; 
//                end
//                endcase
//         end
//     end
        
    
    clk_wiz_0 inst_0 (.clk_out1(pix_clk),.clkin1(clk));
    
    vga_out inst_1 (
        .clk(pix_clk),
        .draw_r(draw_r),
        .draw_g(draw_g),
        .draw_b(draw_b),
        .pix_r(pix_r),
        .pix_g(pix_g),
        .pix_b(pix_b),
        .curr_x(curr_x),
        .curr_y(curr_y),
        .hsync(hsync),
        .vsync(vsync)
     );
     
     mode inst_mode(
        .clk(pix_clk),
        .istop(istop),
        .isbottom(isbottom),
        .mode(mode)
        );
        
     top inst_top(
        .clk(pix_clk),
        .draw_r(top_r),
        .draw_g(top_g),
        .draw_b(top_b),
        .curr_x(curr_x),
        .curr_y(curr_y)
        );
        
     bottom inst_bottom(
        .clk(pix_clk),
        .draw_r(bottom_r),
        .draw_g(bottom_g),
        .draw_b(bottom_b),
        .curr_x(curr_x),
        .curr_y(curr_y)
        );
        
     back inst_back(
        .clk(pix_clk),
        .draw_r(back_r),
        .draw_g(back_g),
        .draw_b(back_b),
        .curr_x(curr_x),
        .curr_y(curr_y)
        );
        
     
endmodule
