`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2025 04:15:23 PM
// Design Name: 
// Module Name: logic
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


module logic(
    input [4:0] pong_position,
    input [4:0] ball_radius,
    input [5:0] ball_x,
    input [5:0] ball_y,
    output [4:0] change_in_direction,
    input rst,
    input clk,
    output [3:0] score
    );
endmodule
