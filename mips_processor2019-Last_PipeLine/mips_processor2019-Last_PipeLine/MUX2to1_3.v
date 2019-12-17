module MUX2to1_3(cntrl,in1,in2,out);
input cntrl;
input [2:0] in1,in2;
output [2:0] out;
assign out = (cntrl == 1) ? in2 : in1;
endmodule
