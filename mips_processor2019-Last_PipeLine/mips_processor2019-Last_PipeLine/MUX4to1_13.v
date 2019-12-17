module MUX3to1_13(select,in1,in2,in3,out);
input [12:0] in1,in2,in3;
input [1:0] select;
output reg [12:0] out;

always @(*)
begin
case(select)
2'b00: out <= in1;
2'b01: out <= in2;
2'b10: out <= in3;
endcase
end

endmodule
