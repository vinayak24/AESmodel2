module aes_rcon(clk, kld, out);
input		clk;
input		kld;
output	[31:0]	out;
reg	[31:0]	out;
reg	[3:0]	rcnt;
wire	[3:0]	rcnt_next;
wire [31:0]RCON_VALUE;

always @(posedge clk)
if(kld)		out <= 32'h01_00_00_00;
else		out <= RCON_VALUE;

assign rcnt_next = rcnt + 4'h1;
always @(posedge clk)
if(kld)		rcnt <= 4'h0;
else		rcnt <=  rcnt_next;

RCON M0 (.i(rcnt_next),.Out(RCON_VALUE));

endmodule

