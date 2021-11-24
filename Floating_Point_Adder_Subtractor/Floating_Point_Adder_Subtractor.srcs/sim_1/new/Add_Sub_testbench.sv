`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2021 11:41:02 PM
// Design Name: 
// Module Name: Add_Sub_testbench
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


module Add_Sub_testbench();
    // Inputs
    logic sub = 0;
    logic shift_flag = 0;
    logic sign_A = 0;
    logic [22:0] mant_A = 0;
    logic sign_B = 0;
    logic [22:0] mant_B = 0;
    // Outputs
    logic sign;
    logic z_flag, c_flag;
    logic [24:0] mant;
    
    Adder_Subtractor DUT (.*);
     
     initial 
     begin 
         #10;
         // Addition
         sub = 0;
         // Different powers of 2 -> shift
         shift_flag = 1;
         // Set A to 0.54
         sign_A= 0;
         mant_A = 23'b00010100011110101110000;
         // Set B to 0.42
         sign_B= 0;
         mant_B = 23'b11010111000010100011110;
         #10;
         // Subtraction
         sub = 1;
         // Different powers of 2 -> shift
         shift_flag = 1;
         // Set A to 0.54
         sign_A= 0;
         mant_A = 23'b00010100011110101110000;
         // Set B to 0.42
         sign_B= 0;
         mant_B = 23'b11010111000010100011110;
     end
endmodule
