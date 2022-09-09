module KEY_GENERATE_PROCESS(clk,
                            kld,
                            key,
                            wo_0,
                            wo_1,
                            wo_2,
                            wo_3);
input		clk;
input		kld;
input	[127:0]	key;
output	[31:0]	wo_0, wo_1, wo_2, wo_3;
reg	[31:0]	w[3:0];
wire	[31:0]	tmp_w;
wire	[31:0]	subword;
wire	[31:0]	rcon;

assign wo_0 = w[0];
assign wo_1 = w[1];
assign wo_2 = w[2];
assign wo_3 = w[3];
always @(posedge clk)	w[0] <= kld ? key[127:096] : w[0]^subword^rcon;
always @(posedge clk)	w[1] <= kld ? key[095:064] : w[0]^w[1]^subword^rcon;
always @(posedge clk)	w[2] <= kld ? key[063:032] : w[0]^w[2]^w[1]^subword^rcon;
always @(posedge clk)	w[3] <= kld ? key[031:000] : w[0]^w[3]^w[2]^w[1]^subword^rcon;
assign tmp_w = w[3];

aes_sbox u0(	.Clk(clk),.a(tmp_w[23:16]), .d(subword[31:24]));
aes_sbox u1(	.Clk(clk),.a(tmp_w[15:08]), .d(subword[23:16]));
aes_sbox u2(	.Clk(clk),.a(tmp_w[07:00]), .d(subword[15:08]));
aes_sbox u3(	.Clk(clk),.a(tmp_w[31:24]), .d(subword[07:00]));
aes_rcon r0(	.clk(clk), .kld(kld), .out(rcon));
endmodule

