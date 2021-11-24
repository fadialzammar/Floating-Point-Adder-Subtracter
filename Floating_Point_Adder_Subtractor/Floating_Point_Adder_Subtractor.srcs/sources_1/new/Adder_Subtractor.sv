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
    output logic z_flag,
    output logic c_flag,
    output logic sign,
    output logic [24:0] mant
    );
    
    logic [24:0] mant_B_2s_cmp;
    
    always_comb begin
        case (sub)
            // Addition
            0: begin
                    case (shift_flag)
                        // There is no shift -> add both leading 1's back
                        0:  begin
                                mant = {1'b1,mant_A} + {1'b1, mant_B};
                                // set C flag if there is an overflow (MSB of mant_full set to 0)
                                c_flag = !(mant[24]) ? 1'b1 : 1'b0;
                            end
                        // There is a shift -> only add leading 1 to mant_A
                        1:  begin
                                mant = {1'b1,mant_A} + {1'b0, mant_B};
                                // set C flag if there is an overflow (MSB of mant set to 1)
                                c_flag = (mant[24]) ? 1'b1 : 1'b0;
                            end
                    endcase
                    // A is larger than B, so the sign of A will be preserved
                    sign = sign_A;
                    // Set Z flag if result is 0
                    z_flag = (mant == 0) ? 1'b1 : 1'b0;
               end
            
            // Subtraction
            1: begin
                    case (shift_flag)
                        // There is no shift -> add both leading 1's back
                        0:  begin
                                mant_B_2s_cmp = {1'b1, mant_B} ^ 24'b111111111111111111111111;
                                mant_B_2s_cmp = mant_B_2s_cmp + 1;
                                mant = {1'b1,mant_A} + mant_B_2s_cmp;
                                // set C flag if there is an overflow (MSB of mant_full set to 0)
                                c_flag = !(mant[24]) ? 1'b1 : 1'b0;
                            end
                        // There is a shift -> only add leading 1 to mant_A
                        1:  begin
                                mant_B_2s_cmp = {1'b0, mant_B} ^ 24'b111111111111111111111111;
                                mant_B_2s_cmp = mant_B_2s_cmp + 1;
                                mant = {1'b1,mant_A} + mant_B_2s_cmp;
                                // set C flag if there is an overflow (MSB of mant set to 1)
                                c_flag = (mant[24]) ? 1'b1 : 1'b0;
                            end
                    endcase
                    // Set Z flag if result is 0
                    z_flag = (mant == 0) ? 1'b1 : 1'b0;
                    // Sign bit set is either of the sign bits or MSB is set
                    sign = sign_A | sign_B;
               end
    
        endcase
    
    end
endmodule
