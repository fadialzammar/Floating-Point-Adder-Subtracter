`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2021 11:00:36 PM
// Design Name: 
// Module Name: Adder_Subtractor
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


module Adder_Subtractor(
    input sub,
    input shift_flag,
    input sign_A,
    input sign_B,
    input [22:0] mant_A,
    input [22:0] mant_B,
    input [2:0] GRS_in,
    output logic z_flag,
    output logic sign,
    output logic [24:0] mant,
    output logic [2:0] GRS_out
    );
    
    logic [27:0] mant_B_2s_cmp;
    logic [27:0] int_mant;
    
    always_comb begin
        case (sub)
            // Addition
            0: begin
                    case (shift_flag)
                        // There is no shift -> add both leading 1's back
                        0:  begin
                                int_mant = {1'b1, mant_A,3'b000} + {1'b1, mant_B, GRS_in};
                            end
                        // There is a shift -> only add leading 1 to mant_A
                        1:  begin
                                int_mant = {1'b1, mant_A,3'b000} + {1'b0, mant_B, GRS_in};
                            end
                    endcase
                    // Set outputs
                    mant = int_mant[27:3];
                    GRS_out = int_mant[2:0];
                    // A is larger than B, so the sign of A will be preserved
                    sign = sign_A;
                    // Set Z flag if result is 0
                    z_flag = (int_mant == 0);
               end
            
            // Subtraction
            1: begin
                    case (shift_flag)
                        // There is no shift -> add both leading 1's back
                        0:  begin
                                mant_B_2s_cmp = ~{1'b1, mant_B, GRS_in};
                                mant_B_2s_cmp = mant_B_2s_cmp + 1;
                                int_mant = {1'b1, mant_A, 3'b000} + mant_B_2s_cmp;
                            end
                        // There is a shift -> only add leading 1 to mant_A
                        1:  begin
                                mant_B_2s_cmp = ~{1'b0, mant_B, GRS_in};
                                mant_B_2s_cmp = mant_B_2s_cmp + 1;
                                int_mant = {1'b1, mant_A, 3'b000} + mant_B_2s_cmp;
                            end
                    endcase
                    // Set outputs
                    mant = int_mant[27:3];
                    GRS_out = int_mant[2:0];
                    // Set Z flag if result is 0
                    z_flag = (int_mant == 0);
                    // Sign bit set if   either of the sign bits is set
                    sign = sign_A | sign_B;
               end
        endcase
        
    end
endmodule