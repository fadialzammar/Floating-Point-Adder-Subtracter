`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2021 03:09:17 PM
// Design Name: 
// Module Name: Zero_Detect
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


module Zero_Detect(
    input [7:0] exp_B,
    input [22:0] mant_B,
    output logic zero_B
    );

    always_comb begin
        zero_B = (mant_B == 0 && exp_B == 0) ? 1'b1 : 1'b0;
    end

endmodule