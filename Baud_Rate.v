module BaudRateGenerator #(
    parameter CLOCK_RATE         = 12_000_000, // board clock (default 100MHz)
    parameter BAUD_RATE          = 9600
)(
    input wire clk,   // board clock (*note: at the {CLOCK_RATE} rate)
    output reg txClk  // baud rate for tx
);

localparam TX_ACC_MAX   = CLOCK_RATE / (2 * BAUD_RATE);
localparam TX_ACC_WIDTH = $clog2(TX_ACC_MAX);

reg [TX_ACC_WIDTH-1:0] tx_counter = 0;

initial begin
    txClk = 1'b0;
end

always @(posedge clk) begin

    // tx clock
    if (tx_counter == TX_ACC_MAX[TX_ACC_WIDTH-1:0]) begin
        tx_counter <= 0;
        txClk      <= ~txClk;
    end else begin
        tx_counter <= tx_counter + 1'b1;
    end
end

endmodule