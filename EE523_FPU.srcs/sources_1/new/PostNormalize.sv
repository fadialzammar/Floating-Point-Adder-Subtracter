`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2021 11:07:57 AM
// Design Name: 
// Module Name: post_normalize
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

module post_normalize(
    input sign_in, sub, // TODO: update diagram w/ sub, more bits of mant_in
    input [24:0] mant_in,
    input [7:0] exp_in,
    input [2:0] GRS_in,
    output sign_out,
    output logic [22:0] mant_out,
    output logic [7:0] exp_out,
    output logic [2:0] GRS_out
    );

    logic [24:0] mant_full;
    // logic [2:0] GRS_sub;

    always_comb begin
        if (sub) begin // Subtraction
            case (mant_in[24:23])
                2'b00: begin // normalize due to underflow
                    mant_full = {mant_in, GRS_in[2]}; // left shift in G
                    exp_out = (exp_in == 8'hFF) ? exp_in : exp_in - 1; // prevent exp_out from underflowing
                    GRS_out = GRS_in << 1;
                end
                2'b01: begin
                    mant_full = mant_in;
                    exp_out = exp_in;
                    GRS_out = GRS_in;
                end
                default: begin
                    //$error("bad mantissa header before post-normalization");
                    mant_full = mant_in;
                    exp_out = exp_in;
                    GRS_out = GRS_in;
                end
            endcase
        end else begin // Addition
            case (mant_in[24:23])
                2'b10: begin // normalize due to overflow
                    mant_full = mant_in >> 1;
                    exp_out = (exp_in == 8'h00) ? exp_in : exp_in + 1; // prevent exp_out from overflowing
                    GRS_out = GRS_in >> 1;
                end
                2'b01: begin
                    mant_full = mant_in;
                    exp_out = exp_in;
                    GRS_out = GRS_in;
                end
                default: begin
                    //$error("bad mantissa header before post-normalization");
                    mant_full = mant_in;
                    exp_out = exp_in;
                    GRS_out = GRS_in;
                end
            endcase
        end
        assert (mant_full[24:23] == 2'b01); //else $error("bad mantissa header after post-normalization");
    end

    assign mant_out = mant_full[22:0]; // leading 01 is implicit
    assign sign_out = sign_in; // not modified // TODO: remove from module

endmodule