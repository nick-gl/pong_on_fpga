`timescale 1ns / 1ps

module top #(
    parameter CLOCK_RATE = 12_000_000,
    parameter BAUD_RATE = 9600,
    parameter TURBO_FRAMES = 0
    )(
    input         clk,   
    input         rst,
    input  [3:0]  ball_radius,   // Linked to Switches in XDC
    input         up_right,      // Linked to Buttons in XDC
    input         down_right,
    input         up_left,
    input         down_left,
    output        tx             // Linked to the UART Pin in XDC
);
 
    reg        txStart = 1'b1;
    reg  [7:0] txData;
    wire      txBusy;
    wire       txDone;
    
    Uart8 #(
        .CLOCK_RATE(12_000_000),
        .BAUD_RATE(9600)
    ) uart_inst (
        .clk(clk),
         .txEn(1'b1),
        .txStart(txStart),
        .in(txData),
        .txBusy(txBusy),
        .txDone(txDone),
        .tx(tx)
    );
        
    // -------------------------------------------------------

    reg [3:0] angle;
    reg [3:0]  score_left, score_right;
    wire [3:0] pos_left, pos_right;
    wire [5:0] ball_x, ball_y;

    

    
    paddle pong_l (
        .clk(clk), .rst(rst),
        .up(up_left), .down(down_left),
        .pos(pos_left)
    );

    paddle pong_r (
        .clk(clk), .rst(rst),
        .up(up_right), .down(down_right),
        .pos(pos_right)
    );

    wire flip_x = (ball_x <= ball_radius) || 
                  (ball_x >= 63 - ball_radius) || 
                  (ball_x == 2 + ball_radius && ball_y >= pos_left && ball_y <= pos_left + 4) || 
                  (ball_x == 61 - ball_radius && ball_y >= pos_right && ball_y <= pos_right + 4);

    wire flip_y = (ball_y <= ball_radius) || 
                  (ball_y >= 63 - ball_radius);

    ball ball_in_game (
        .clk(clk), .reset(rst), 
        .angle(angle), .ball_radius(ball_radius),
        .flip_x(flip_x), .flip_y(flip_y),
        .ball_x(ball_x), .ball_y(ball_y)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            score_left  <= 4'd0;
            score_right <= 4'd0;
        end else begin
            if (ball_x <= 0)  score_right <= score_right + 1;
            if (ball_x >= 63) score_left  <= score_left + 1;
        end
    end
   reg [3:0] tx_state;

localparam
    TX_IDLE  = 0,
    TX_SL    = 1,
    TX_SR    = 2,
    TX_PL    = 3,
    TX_PR    = 4,
    TX_BX    = 5,
    TX_BY    = 6,
    TX_BR    = 7,
    TX_FTR   = 8;

always @(posedge clk) begin
    txStart <= 1'b0;

    if (!txBusy) begin
        case (tx_state)
            TX_IDLE: begin
                txData <= 8'hAA;
                txStart  <= 1'b1;
                tx_state <= TX_SL;
            end

            TX_SL: begin
                txData   <= {4'b0000, score_left};
                txStart  <= 1'b1;
                tx_state <= TX_SR;
            end

            TX_SR: begin
                txData   <= {4'b0000, score_right};
                txStart  <= 1'b1;
                tx_state <= TX_PL;
            end

            TX_PL: begin
                txData   <= {4'b0000, pos_left};
                txStart  <= 1'b1;
                tx_state <= TX_PR;
            end

            TX_PR: begin
                txData   <= {4'b0000, pos_right};
                txStart  <= 1'b1;
                tx_state <= TX_BX;
            end

            TX_BX: begin
                txData   <= {2'b00, ball_x};
                txStart  <= 1'b1;
                tx_state <= TX_BY;
            end

            TX_BY: begin
                txData   <= {2'b00, ball_y};
                txStart  <= 1'b1;
                tx_state <= TX_BR;
            end

            TX_BR: begin
                txData   <= {4'b0000, ball_radius};
                txStart  <= 1'b1;
                tx_state <= TX_FTR;
            end

            TX_FTR: begin
                txData   <= 8'h55;
                txStart  <= 1'b1;
                tx_state <= TX_IDLE;
            end
        endcase
    end
end

endmodule