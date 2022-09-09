module RCON (i,Out);
  input [3:0]i;
  output reg  [31:0]Out;
  wire [31:0]rc,Outa;
  
  assign rc=32'h01_00_00_00;
  assign  Outa=rc<<i;
  

  always @ (*) 
  begin
  if(i==4'd8)
    Out=32'h1b_00_00_00;
  else if (i==4'd9)
    Out=32'h36_00_00_00;
  else
    Out=Outa;
  end
endmodule
