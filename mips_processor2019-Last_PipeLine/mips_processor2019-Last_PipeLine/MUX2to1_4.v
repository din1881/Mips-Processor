module MUX2to1_4(cntrl,in1,in2,out);
input cntrl;
input [3:0] in1,in2;
output [3:0] out;
assign out = (cntrl == 1) ? in2 : in1;
endmodule
