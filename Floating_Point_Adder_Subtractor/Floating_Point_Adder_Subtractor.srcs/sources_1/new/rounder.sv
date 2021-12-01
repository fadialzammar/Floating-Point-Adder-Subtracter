module rounder(
    input sign,
    input [22:0] mant,
    input [7:0] exp,
    input [2:0] GRS,
    output logic [31:0] S
    );

    always_comb begin
        priority case ({mant[0], GRS}) inside
            // nearest even, round down
            4'b0100: S = {sign, exp, mant};
            // nearest even, round up - if incrementing would overflow, don't increment
            4'b1100: S = ({exp, mant} == {31{1'b1}}) ? {sign, exp, mant} : {sign, exp, mant} + 1;
            // round down
            4'b?0??: S = {sign, exp, mant};         
            // round up - if incrementing would overflow, don't increment
            4'b?1??: S = ({exp, mant} == {31{1'b1}}) ? {sign, exp, mant} : {sign, exp, mant} + 1;
            default: S = {sign, exp, mant};
        endcase
    end

endmodule