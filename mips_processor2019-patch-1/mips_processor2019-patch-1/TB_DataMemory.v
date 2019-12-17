/***************************************TB_Data Memory Module***************************************/
module tb();
reg [31:0] w;
reg [17:0] a;
reg rs,ws,Clk;
wire [31:0] out;
DATAMEMORY_op ahmed(out,a,ws,rs,w,Clk);
integer i;
always
begin
#5 Clk = ~Clk;
end
initial
begin
$monitor ($time ,, " write data is %h, address is %h , memread is %d , memwrite is %d , Read data is %h ",w,a,rs,ws,out);
Clk = 0;
rs = 1;
ws = 0;
for(i=0;i<6;i=i+1)
begin
#5
w = $random();
rs = ~rs;
ws = ~ws;
a = 32'h00000001;
end
end
endmodule 