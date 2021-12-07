`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2021 03:45:20 PM
// Design Name: 
// Module Name: TestBench
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


module TestBench(

    );
    
    logic [31:0] A;
    logic [31:0] B;
    logic [31:0] OUT;
    logic sub;
    logic zflag;
    logic CLK=0;
    logic correct=0;
    logic [5:0] test_num=0;
    
    FPU_Wrapper DUT(.*);
    initial forever  #10  CLK =  ! CLK; 
    
    initial
    begin
    
    //pos + pos (pos result)
    test_num=1;
    B=32'b00111111100011001100110011001100;
    A=32'b01000000000011001100110011001100;
    sub=0; #1;
    if (OUT == 32'b01000000010100110011001100110010)
        correct=1;
    else
        correct=0;
    #9;
    
    
    //pos - pos (pos result)
    test_num=2;
    A=32'b00000110100111000100001111110011;
    B=32'b00000011010010001000000101111100;
    sub=1; #2;
    if (OUT == 32'b00000110100110101011001011110000)
        correct=1;
    else
        correct=0;
    #9;
    
    //pos - pos(neg result)
    test_num=3;
    A=32'b00111110100000000000000000000000;
    B=32'b00111111010000000000000000000000;
    sub=1; #1;
    if (OUT == 32'b10111111000000000000000000000000)
        correct=1;
    else
        correct=0;
    #9;
    
    //pos + 0
    test_num=4;
    A=32'b0;
    B=32'b00000000100011001100110011001100;
    sub=0; #1;
    if (OUT == 32'b00000000100011001100110011001100)
        correct=1;
    else
        correct=0;
    #9;
    
    //neg + 0
    test_num=5;
    A=32'b0;
    B=32'b10111111100011001100110011001100;
    sub=0; #1;
    if (OUT == 32'b10111111100011001100110011001100)
        correct=1;
    else
        correct=0;
    #9;
    
    //0 + 0
    test_num=6;
    A=32'b0;
    B=32'b0;
    sub=0; #1;
    if (OUT == 32'b0)
        correct=1;
    else
        correct=0;
    #9;
    

    
    //0 - pos
    test_num=7;
    A=32'b0;
    B=32'b00111111100011001100110011001100;
    sub=1; #1;
    if (OUT == 32'b10111111100011001100110011001100)
        correct=1;
    else
        correct=0;
    #9;
    
    //0 - neg
    test_num=8;
    A=32'b0;
    B=32'b10000010001100110111010010111100;
    sub=1; #1;
    if (OUT == 32'b00000010001100110111010010111100)
        correct=1;
    else
        correct=0;
    #9;

    //neg - neg (neg result)
    test_num=9;
    A=32'b11001001011101000010100110010100;
    B=32'b11000111000011111001110111011100;
    sub=1; #1;
    if (OUT == 32'b11001001011010110010111110110110)
        correct=1;
    else
        correct=0;
    #9;
            
    //neg - neg (pos result)
    test_num=10;
    A=32'b11000000001111101111001101001101;
    B=32'b11000010110010011101101011101110;
    sub=1; #1;
    if (OUT == 32'b01000010110000111110001101010100)
        correct=1;
    else
        correct=0;
    #9;
    
    //neg + neg (neg result)
    test_num=11;
    A=32'b11001010101001110101000111001100;
    B=32'b11001001000110111001000100101101;
    sub=0; #1;
    if (OUT == 32'b11001010101110101100001111110010)
        correct=1;
    else
        correct=0;
    #9;
    
    
    //halfway rounding
    test_num=12;
    A=32'b11000001011100000000000000001001;
    B=32'b11000000011000000000000000011110;
    sub=0; #1;
    if (OUT == 32'b11000001100101000000000000001000)
        correct=1;
    else
        correct=0;
    #9;
    
    //0 - 0
    test_num=13;
    A=32'b0;
    B=32'b0;
    sub=1; #1;
    if (OUT == 32'b0)
        correct=1;
    else
        correct=0;
    #9;
    
    A='h0FF;
    B='h0FF;
    
    
    end
    

endmodule
