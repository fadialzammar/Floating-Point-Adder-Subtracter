`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2021 02:50:00 PM
// Design Name: 
// Module Name: Unpack
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


module Unpack(
    input [31:0] A,
    input [31:0] B,
    output logic sign_A,
    output logic sign_B,
    output logic [7:0] exp_A,
    output logic [7:0] exp_B,
    output logic [22:0] mant_A,
    output logic [22:0] mant_B
    );
    
    // 
    always_comb begin
        sign_A = A[31];
        sign_B = B[31];
        exp_A = A[30:23];
        exp_B = B[30:23];
        mant_A = A[22:0];
        mant_B = B[22:0];
    end
    
endmodule
