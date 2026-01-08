`timescale 1ns / 1ps
module Uart8 #(
    parameter CLOCK_RATE   = 12_000_000, // board clock (default 100MHz)
    parameter BAUD_RATE    = 9600,
    parameter TURBO_FRAMES = 0        
)(
    input wire clk, // board clock (*note: at the {CLOCK_RATE} rate)


    // tx interface
    input wire txEn,
    input wire txStart,
    input wire [7:0] in,
    output wire txBusy,
    output wire txDone,
    output wire tx
);

// this value cannot be changed in the current implementation

wire txClk;

BaudRateGenerator #(
    .CLOCK_RATE(CLOCK_RATE),
    .BAUD_RATE(BAUD_RATE)
) generatorInst (
    .clk(clk),
    .txClk(txClk)
);


Uart8Transmitter #(
    .TURBO_FRAMES(TURBO_FRAMES)
) txInst (
    .clk(txClk),
    .en(txEn),
    .start(txStart),
    .in(in),
    .busy(txBusy),
    .done(txDone),
    .out(tx)
);

endmodule