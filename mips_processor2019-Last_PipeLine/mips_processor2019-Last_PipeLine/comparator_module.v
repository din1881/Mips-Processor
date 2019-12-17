
module comparator(rd_data1, rd_data2, br_signal);

input [31:0] rd_data1, rd_data2;
output br_signal;


assign br_signal =(rd_data1==rd_data2)?1'b1 : 1'b0 ;


/*
always @ (*)
	begin 
	if(rd_data1==rd_data2) 
		br_signal <= 1'b1;

	else
		br_signal <= 1'b0;
	
	end
*/
endmodule