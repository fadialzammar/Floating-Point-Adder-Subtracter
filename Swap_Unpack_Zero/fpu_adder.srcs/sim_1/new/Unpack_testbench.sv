`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 02:33:25 PM
// Design Name: 
// Module Name: Unpack_testbench
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


module Unpack_testbench();
    // inputs
    logic [31:0] A = 0;
    logic [31:0] B = 0;
    //outputs
    logic sign_A;
    logic sign_B;
    logic [7:0] exp_A;
    logic [7:0] exp_B;
    logic [22:0] mant_A;
    logic [22:0] mant_B;
    
    Unpack DUT (.*);
    
    initial
    begin
        // set A and B to 4.2 and .69
        #10
        A = 32'b01000000110111001100110011001101;
        B = 32'b00111111001100001010001111010111;
    end

    
endmodule
