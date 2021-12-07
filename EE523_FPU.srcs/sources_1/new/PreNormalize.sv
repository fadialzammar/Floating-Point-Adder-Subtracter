`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Izak Walker
// 
// Create Date: 11/23/2021 07:39:01 PM
// Design Name: 
// Module Name: Pre_Normalize
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Pre-normailzes FP values for addition / subtraction 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Pre_Normalize(
    input sign_A,
    input [7:0] exp_A,
    input [22:0] mant_A,
    input sign_B,
    input [7:0] exp_B,
    input [22:0] mant_B,
    output logic norm_sign_A,
    output logic norm_sign_B,
    output logic [22:0] norm_mant_A,
    output logic [22:0] norm_mant_B,
    output logic [7:0] exp,
    output logic [2:0] GRS,
    output logic shift_flag
    );
    
    logic [7:0] exp_diff;
    logic [25:0] int_mant_B;
    
    always_comb begin
        // The sign bits do not change
        norm_sign_A = sign_A;
        norm_sign_B = sign_B;
        // Input A will allways have the larger exponent -> output exponent
        exp = exp_A;
        
        // Mantissa B needs to be shifted to the right by the difference in the exponent values
        exp_diff = exp_A - exp_B;
        // Shift flag is set if the exponents do not align and B is shifted to accomodate
        shift_flag = (exp_diff != 0);
        
        // Pad mant_B with three trailing zeros
        int_mant_B = {mant_B, 3'b000};
        // Pad MSB with leading 1 that is not stored
        int_mant_B = {1'b1,int_mant_B} >> exp_diff;
        
        // Mantissa A is already normalized
        norm_mant_A = mant_A;
        // Set Mantissa B to shifted int_mant_B without the GRS bits
        norm_mant_B = int_mant_B[25:3];
        
        // GRS are the Guard, Rouund,and Sticky bits, used for extra precision when rounding
        GRS[2:1] = int_mant_B[2:1];
        // Variable difference length means need to cover most probable possible cases
        // Simplified to save on hardware
        if (exp_diff > 2) 
            begin
                case (exp_diff - 2)
                    0: GRS[0] = int_mant_B[0];
                    1: GRS[0] = int_mant_B[0];
                    2: GRS[0] = mant_B[0] | int_mant_B[0];
                    3: GRS[0] = |mant_B[1:0] | int_mant_B[0];
                    4: GRS[0] = |mant_B[2:0] | int_mant_B[0];
                    5: GRS[0] = |mant_B[3:0] | int_mant_B[0];
                    6: GRS[0] = |mant_B[4:0] | int_mant_B[0];
                    7: GRS[0] = |mant_B[5:0] | int_mant_B[0];
                    8: GRS[0] = |mant_B[6:0] | int_mant_B[0];
                    9: GRS[0] = |mant_B[7:0] | int_mant_B[0];
                    10: GRS[0] = |mant_B[8:0] | int_mant_B[0];
                    11: GRS[0] = |mant_B[9:0] | int_mant_B[0];
                    12: GRS[0] = |mant_B[10:0] | int_mant_B[0];
                    13: GRS[0] = |mant_B[11:0] | int_mant_B[0];
                    14: GRS[0] = |mant_B[12:0] | int_mant_B[0];
                    15: GRS[0] = |mant_B[13:0] | int_mant_B[0];
                    16: GRS[0] = |mant_B[14:0] | int_mant_B[0];
                    17: GRS[0] = |mant_B[15:0] | int_mant_B[0];
                    18: GRS[0] = |mant_B[16:0] | int_mant_B[0];
                    19: GRS[0] = |mant_B[17:0] | int_mant_B[0];
                    20: GRS[0] = |mant_B[18:0] | int_mant_B[0];
                    21: GRS[0] = |mant_B[19:0] | int_mant_B[0];
                    22: GRS[0] = |mant_B[20:0] | int_mant_B[0];
                    23: GRS[0] = |mant_B[21:0] | int_mant_B[0];
                    24: GRS[0] = |mant_B[22:0] | int_mant_B[0];
                    //Rest of cases default to the logical OR of all bits for larger shifts
                    default: GRS[0] = |mant_B[22:0] | int_mant_B[0];
                endcase
            end
        else
            begin
                GRS[0] = int_mant_B[0];
            end
    end
    
endmodule