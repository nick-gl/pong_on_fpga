`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2025 04:15:23 PM
// Design Name: 
// Module Name: paddle
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


module paddle(
    input up,
    input down,
    input rst,
    input clk,
    output reg [3:0] pos
    );
    always @(posedge clk or posedge rst) begin
        if (rst) pos = 4'd8;
        else if (up) pos = pos + 1;
        else if (down) pos = pos -1;
    end 
endmodule
