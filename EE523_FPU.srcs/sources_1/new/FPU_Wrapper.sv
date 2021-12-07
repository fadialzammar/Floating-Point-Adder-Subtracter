`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2021 11:07:57 AM
// Design Name: 
// Module Name: FPU_Wrapper
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


module FPU_Wrapper(
    input [31:0] A,
    input [31:0] B,
    input sub,
    output logic [31:0] OUT,
    output logic zflag
    );
    
    logic signA_UN;
    logic signB_UN;
    logic [22:0] mantA_UN;
    logic [22:0] mantB_UN;
    logic [7:0] expA_UN;
    logic [7:0] expB_UN;
    logic signA_SW;
    logic signB_SW;
    logic [22:0] mantA_SW;
    logic [22:0] mantB_SW;
    logic [7:0] expA_SW;
    logic [7:0] expB_SW;
    logic [31:0] A_SW;
    logic signA_PR;
    logic signB_PR;
    logic [22:0] mantA_PR;
    logic [22:0] mantB_PR;
    logic [7:0] exp_PR;
    logic [2:0] GRS_PR;
    logic shift_flag;
    logic sign_AS;
    logic [24:0] mant_AS;
    logic [2:0] GRS_AS;
    logic sign_PO;
    logic [22:0] mant_PO;
    logic [7:0] exp_PO;
    logic [2:0] GRS_PO;
    logic [31:0] S;
    logic zeroB;

    
    
    

    
    Unpack UN(.A(A), .B(B), .sign_A(signA_UN), .sign_B(signB_UN), .mant_A(mantA_UN), .mant_B(mantB_UN), .exp_A(expA_UN), .exp_B(expB_UN));
    
    Swap SW(.sub(sub), .sign_A(signA_UN), .sign_B(signB_UN), .mant_A(mantA_UN), .mant_B(mantB_UN), .exp_A(expA_UN), .exp_B(expB_UN),
            .swap_sign_A(signA_SW), .swap_sign_B(signB_SW), .swap_mant_A(mantA_SW), .swap_mant_B(mantB_SW), .swap_exp_A(expA_SW), .swap_exp_B(expB_SW));
            
    assign A_SW[22:0] = mantA_SW;
    assign A_SW[30:23] = expA_SW;
    assign A_SW[31] = signA_SW;
    
    Zero_Detect ZD(.mant_B(mantB_SW), .exp_B(expB_SW), .zero_B(zeroB));

    Pre_Normalize PR(.sign_A(signA_SW), .sign_B(signB_SW), .mant_A(mantA_SW), .mant_B(mantB_SW), .exp_A(expA_SW), .exp_B(expB_SW),
                    .norm_sign_A(signA_PR), .norm_sign_B(signB_PR), .norm_mant_A(mantA_PR), .norm_mant_B(mantB_PR), .GRS(GRS_PR), .exp(exp_PR), .shift_flag(shift_flag));
    
    Adder_Subtractor AS(.sub(sub), .sign_A(signA_PR), .sign_B(signB_PR), .mant_A(mantA_PR), .mant_B(mantB_PR), 
                        .sign(sign_AS), .mant(mant_AS), .shift_flag(shift_flag), .z_flag(zflag), .GRS_in(GRS_PR), .GRS_out(GRS_AS));
    
    post_normalize PO(.sub(sub), .sign_in(sign_AS), .mant_in(mant_AS), .GRS_in(GRS_AS), .exp_in(exp_PR),
                      .sign_out(sign_PO), .mant_out(mant_PO), .GRS_out(GRS_PO), .exp_out(exp_PO));
                     
    rounder RO(.sign(sign_PO), .mant(mant_PO), .GRS(GRS_PO), .exp(exp_PO), .S(S));
    
    always_comb begin
    case(zeroB)
        0: OUT=S;
        1: OUT=A_SW;
    endcase
    end
    
    
    
    
    
endmodule
