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

// cases
// 000 - no special case
// 001 - positive zero
// 101 - negative zero
// 010 - positive infinity
// 110 - negative infinity
// 101 - NaN

module Zero_Detect(
    input sign_B,
    input [7:0] exp_B,
    input [22:0] mant_B,
    output logic [3:0] special_B
    );
    
    always_comb begin
        if (exp_B == 8'b11111111) begin
            case (mant_B)
                // case for 
                0: begin
                    special_B = {sign_B, 2'b10};
                end
                default: begin
                    special_B = 3'b101;
                end
            endcase
        end
        else begin
            special_B = (mant_B == 0 && exp_B == 0) ? {sign_B, 2'b01} : 1'b0;
        end
    end
    
endmodule
