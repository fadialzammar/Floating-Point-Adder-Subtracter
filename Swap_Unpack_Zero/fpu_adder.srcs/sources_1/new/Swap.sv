`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2021 02:55:48 PM
// Design Name: 
// Module Name: Swap
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

module Swap(
    input sign_A,
    input sign_B,
    input [7:0] exp_A,
    input [7:0] exp_B,
    input [22:0] mant_A,
    input [22:0] mant_B,
    input sub,
    output logic swap_sign_A,
    output logic swap_sign_B,
    output logic [7:0] swap_exp_A,
    output logic [7:0] swap_exp_B,
    output logic [22:0] swap_mant_A,
    output logic [22:0] swap_mant_B
    );
    
    always_comb begin
        // swap A and B if exponent of A is less than B
        if (exp_A < exp_B) begin
            swap_exp_A = exp_B;
            swap_exp_B = exp_A;
            swap_mant_A = mant_B;
            swap_mant_B = mant_A;
            // switch signs if sub
            case (sub)
                0: begin
                       swap_sign_A = sign_B; 
                       swap_sign_B = sign_A;
                   end
                1: begin
                       swap_sign_A = !sign_B; 
                       swap_sign_B = !sign_A;
                   end
                default: begin
                       swap_sign_A = !sign_B; 
                       swap_sign_B = !sign_A;
                   end
            endcase                
        end
        // keep A and B the same
        else begin
            swap_sign_A = sign_A;
            swap_sign_B = sign_B;
            swap_exp_A = exp_A;
            swap_exp_B = exp_B;
            swap_mant_A = mant_A;
            swap_mant_B = mant_B;
        end
    end
    
endmodule
