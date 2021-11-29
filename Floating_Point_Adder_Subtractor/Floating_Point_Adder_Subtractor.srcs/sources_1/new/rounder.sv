module rounder(
    input sign,
    input [22:0] mant,
    input [7:0] exp,
    input [2:0] GRS,
    output [31:0] S
    );

    always_comb begin
        priority case (GRS) inside
            // round down
            3'b0??: S = {sign, exp, mant};

            // "halfway" case, round to nearest even
            3'b100: begin 
                
            end

            // round up - if incrementing would overflow, don't increment
            3'b1??: S = ({exp, mant} == {31{1'b1}}) ? {sign, exp, mant} : {sign, exp, mant} + 1;

            default: S = {sign, exp, mant};
        endcase
    end

endmodule