`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// // Create Date: 12/31/2025 04:15:23 PM
// Design Name: 
// Module Name: ball
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

module ball (
    input              clk,
    input              reset,


    input      [3:0]   angle,       // 0-15 direction
    input      [3:0]   ball_radius,  // pixels
    input              flip_x,
    input              flip_y,

    output     [5:0]   ball_x,
    output     [5:0]   ball_y
);

    // Fixed-point position (Q6.4)
    reg [9:0] ball_x_fp;
    reg [9:0] ball_y_fp;

    // Fixed-point velocity (Q4.4 signed)
    reg signed [7:0] vx;
    reg signed [7:0] vy;


    always @(posedge clk) begin
            case (angle)
            4'd0:  begin vx =  16; vy =   0; end // 0°
            4'd1:  begin vx =  15; vy =   6; end // 22.5°
            4'd2:  begin vx =  14; vy =   8; end // 30°
            4'd3:  begin vx =  11; vy =  11; end // 45°
            4'd4:  begin vx =   8; vy =  14; end // 60°
            4'd5:  begin vx =   6; vy =  15; end // 67.5°
            4'd6:  begin vx =   0; vy =  16; end // 90°
            4'd7:  begin vx =  -6; vy =  15; end
            4'd8:  begin vx =  -8; vy =  14; end
            4'd9:  begin vx = -11; vy =  11; end
            4'd10: begin vx = -14; vy =   8; end
            4'd11: begin vx = -15; vy =   6; end
            4'd12: begin vx = -16; vy =   0; end
            4'd13: begin vx = -15; vy =  -6; end
            4'd14: begin vx = -14; vy =  -8; end
            4'd15: begin vx = -11; vy = -11; end
            default: begin vx = 0; vy = 0; end
        endcase
        if (reset) begin
            ball_x_fp <= 10'd32 << 4; 
            ball_y_fp <= 10'd32 << 4;
        end else begin
            ball_x_fp <= ball_x_fp + vx;
            ball_y_fp <= ball_y_fp + vy;


            if (ball_x <= ball_radius)
                vx <= -vx;
            else if (ball_x >= (6'd63 - ball_radius))
                vx <= -vx;


            if (ball_y <= ball_radius)
                vy <= -vy;
            else if (ball_y >= (6'd63 - ball_radius))
                vy <= -vy;
            if(flip_x)
                 vx <= -vx;
            if (flip_y)
                vy <= -vy;

        end
    end

    assign ball_x = ball_x_fp[9:4];
    assign ball_y = ball_y_fp[9:4];

endmodule
