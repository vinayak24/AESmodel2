module AES_TOP_FINAL(clk,rst,kld,key_tx,key_rx,text_in,enc_data,dec_data,enc_complete,dec_complete);

input		clk;
input		rst;
input		kld;
input	[127:0]	key_tx,key_rx;
input	[127:0]	text_in;
output	[127:0]	enc_data;
output	[127:0]	dec_data;

output		enc_complete;
output  dec_complete;



 

AES_ENCRYPT MM0 (.clk(		clk		),.rst(		rst		),.ld(		kld		),.done(enc_complete),.key(		key_tx		),.text_in(	text_in		),.text_out(enc_data	));

AES_DECRYPT MM1 (.clk(		clk		),.rst(		rst		),.kld(		kld		),.ld(		enc_complete),.done(dec_complete),.key(key_rx),.text_in(	enc_data),.text_out(dec_data));



endmodule

