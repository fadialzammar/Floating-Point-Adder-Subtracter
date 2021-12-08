`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2021 11:58:33 AM
// Design Name: 
// Module Name: FPU_Wrapper_Wrapper
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


module FPU_Wrapper_Wrapper(input clk, output logic [31:0] OUT

    );
    
    logic [31:0] A;
    logic [31:0] B;
    logic sub;
    logic zflag;
    FPU_Wrapper DUT(.*);
    
    always@(posedge clk) begin
        A^=32'b10101010101010101010101010101010;
        B^=32'b10101010101010101010101010101010;
        sub^='b1;
    end
    
endmodule
