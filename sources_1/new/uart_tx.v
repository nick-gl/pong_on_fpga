`timescale 1ns / 1ps
`include "UartStates.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2026 09:24:40 AM
// Design Name: 
// Module Name: uart_tx
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
module Uart8Transmitter #(
    parameter TURBO_FRAMES = 0
)(
    input wire clk,      // baud rate
    input wire en,
    input wire start,    // start transmission
    input wire [7:0] in, // parallel data to transmit
    output reg busy,     // transmit is in progress
    output reg done,     // end of transmission
    output reg out       // tx line for serial data
);

reg [2:0] state     = `RESET;
reg [7:0] in_data   = 8'b0; // shift reg for the data to transmit serially
reg [2:0] bit_index = 3'b0; // index for 8-bit data


/*
 * State machine
 */
always @(posedge clk) begin
    case (state)
        `RESET: begin
            out       <= 1'b1;
            busy      <= 1'b0;
            done      <= 1'b0;
            bit_index <= 3'd0;
            state     <= en ? `IDLE : `RESET;
        end

        `IDLE: begin
            done <= 1'b0;
            if (start && en) begin
                in_data <= in;
                state   <= `START_BIT;
            end
        end

        `START_BIT: begin
            out       <= 1'b0;
            busy      <= 1'b1;
            bit_index <= 3'd0;
            state     <= `DATA_BITS;
        end

        `DATA_BITS: begin
            out <= in_data[0];
            in_data <= {1'b0, in_data[7:1]};
            if (bit_index == 3'd7)
                state <= `STOP_BIT;
            else
                bit_index <= bit_index + 1'b1;
        end

        `STOP_BIT: begin
            out  <= 1'b1;
            busy <= 1'b0;
            done <= 1'b1;
            state <= `IDLE;
        end
    endcase
end

endmodule
