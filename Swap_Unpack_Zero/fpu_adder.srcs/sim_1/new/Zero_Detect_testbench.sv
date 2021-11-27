`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 02:40:16 PM
// Design Name: 
// Module Name: Zero_Detect_testbench
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


module Zero_Detect_testbench();
    logic [7:0] exp_B = 0;
    logic [22:0] mant_B = 0;
    logic zero_B;
    
    Zero_Detect DUT (.*);
    
    initial
    begin
        // set B to 6.9
        // should give 0 for Zero_B flag
        #10
        exp_B = 8'b10000001;
        mant_B = 23'b10111001100110011001101;
        
        // set exp_B to 0
        // should stil return 0
        #10
        exp_B = 0;
        
        // set mant_B to zero
        // should set zero_B flag to 1
        #10
        mant_B = 0;
    end

endmodule
