`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2026 02:21:22 PM
// Design Name: 
// Module Name: button
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
module debounce(
    input clk,
    input rst,
    input button_in,
    output reg button_out
);

    reg [15:0] counter;
    reg button_sync;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            button_out <= 0;
            button_sync <= 0;
        end else begin
            // synchronize to clock
            button_sync <= button_in;

            if (button_sync) begin
                if (counter < 16'hFFFF) counter <= counter + 1;
                if (counter == 16'hFFFF) button_out <= 1;
            end else begin
                counter <= 0;
                button_out <= 0;
            end
        end
    end

endmodule
