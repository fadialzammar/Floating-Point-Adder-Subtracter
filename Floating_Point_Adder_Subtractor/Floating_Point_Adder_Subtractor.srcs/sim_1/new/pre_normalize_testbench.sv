`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2021 09:36:15 PM
// Design Name: 
// Module Name: pre_normalize_testbench
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


module pre_normalize_testbench();
    // Inputs
    logic sign_A = 0;
    logic [7:0] exp_A = 0;
    logic [22:0] mant_A = 0;
    logic sign_B = 0;
    logic [7:0] exp_B = 0;
    logic [22:0] mant_B = 0;
    // Outputs
    logic norm_sign_A;
    logic norm_sign_B;
    logic [22:0] norm_mant_A;
    logic [22:0] norm_mant_B;
    logic [7:0] exp;
    logic [2:0] GRS;
    logic shift_flag;
    
    Pre_Normalize DUT (.*);
     
     initial 
     begin 
         #10;
         // Checks equal exponent case
         // Set A to 6.9
         sign_A= 0;
         exp_A = 8'b10000001;
         mant_A = 23'b10111001100110011001101;
         // Set B to 4.2
         sign_B= 0;
         exp_B = 8'b10000001;
         mant_B = 23'b00001100110011001100110;
         
         #10;
         // Checks exp A - exp B = 4 case & setting all GRS bits to 111 (mant_B[0] shifted out)
         // Leave A = 6.9
         // Set B = 0.42
         sign_B= 0;
         exp_B = 8'b01111101;
         mant_B = 23'b10101110000101000111101;
         
         #10;
         // Checks GSR set to 101
         // Set B = 0.3 
         sign_B = 0;
         exp_B = 8'b01111101;
         mant_B = 23'b00110011001100110011010;
         
         #10;
         // Checks exp A - exp B = 2 and GSR set to 000
         // Set B = 1.69
         sign_B = 0;
         exp_B = 8'b01111111;
         mant_B = 23'b10110000101000111101100;
         
         #10;
         // Checks exp A - exp B = 2 and GSR set to 010
         // Set B = 1.89
         sign_B = 0;
         exp_B = 8'b01111111;
         mant_B = 23'b11100011110101110000101;
         
         #10;
         // Checks exp A - exp B = 5 and GSR set to 010 (mant_B[1:0] shifted out)
         // Set A to 420.001
         sign_A= 0;
         exp_A = 8'b10000111;
         mant_A = 23'b10100100000000000100001;
         // Set B = 12.0019
         sign_B = 0;
         exp_B = 8'b10000010;
         mant_B = 23'b10000000000011111001000;
         
         #10;
         // Checks exp A - exp B = 5 and GSR set to 001 (mant_B[1:0] shifted out)
         // Set B = 12.0029
         sign_B = 0;
         exp_B = 8'b10000010;
         mant_B = 23'b10000000000101111100001;
     end 


endmodule
