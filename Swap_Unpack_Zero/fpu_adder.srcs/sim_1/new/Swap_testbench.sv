`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 01:52:19 PM
// Design Name: 
// Module Name: Swap_testbench
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


module Swap_testbench();
    //inputs
    logic sign_A = 0;
    logic sign_B = 0;
    logic [7:0] exp_A = 0;
    logic [7:0] exp_B = 0;
    logic [22:0] mant_A = 0;
    logic [22:0] mant_B = 0;
    logic sub = 0;
    // outputs
    logic swap_sign_A;
    logic swap_sign_B;
    logic [7:0] swap_exp_A;
    logic [7:0] swap_exp_B;
    logic [22:0] swap_mant_A;
    logic [22:0] swap_mant_B;
    
    Swap DUT (.*);
    
    initial
    begin
        #10
         // Set A to 6.9
         sign_A= 0;
         exp_A = 8'b10000001;
         mant_A = 23'b10111001100110011001101;
         // Set B to 4.2
         sign_B= 0;
         exp_B = 8'b10000001;
         mant_B = 23'b00001100110011001100110;
         
         #10
         // Leave B = 4.2
         // Set A = 0.69
         // should switch A and B
         sign_A = 0;
         exp_A = 8'b01111110;
         mant_A = 23'b01100001010001111010111;
         
         #10
         // Leave A and B
         // change sub to 1
         sub = 1;
         
     end    
endmodule
