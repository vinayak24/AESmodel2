module aes_inv_sbox(Clk,a,d); 
  input Clk; 
  input [7:0]a;  
  output [7:0]d;
  wire [3:0]C,Dd,E,F,G,I,J,H,M,N;  
  wire [7:0]B,O,P; 
  wire [7:0]outa; 
  reg [7:0]d; 


  always @ (Clk)
    d= outa;
  
  assign C=B[7:4];  
  assign Dd=B[3:0];  
  assign O[7:4]=M;  
  assign O[3:0]=N;
  
  
    
  S_InvAffine S0(.q(a),.i(P));
  S_Isomorphic_Map S1(.X(P),.Y(B));
  S_Square_Block S2(.X(C),.Y(E));  
  S_4bitAdd S3(.X(Dd),.Y(C),.Z(F));
  S_4bitmulitiplication S4(.A(F),.B(Dd),.D(G));
  S_4bitAdd S5(.X(G),.Y(H),.Z(I));
  S_Multi_Constant_lambda S6(.A(E),.B(H));
  S_Multiplicative_Inv S7(.A(I),.B(J));
  S_4bitmulitiplication S8(.A(J),.B(C),.D(M));
  S_4bitmulitiplication S9(.A(J),.B(F),.D(N));   
  S_Inv_Isomorphic_Map S10(.Y(O),.X(outa));  

    
endmodule


module S_InvAffine(q,i);
  
  input [7:0]q;
  
  output [7:0]i;
  
  assign i[7]=(q[6]^q[4]^q[1]);
  assign i[6]=(q[5]^q[3]^q[0]);
  assign i[5]=(q[7]^q[4]^q[2]);
  assign i[4]=(q[6]^q[3]^q[1]);
  assign i[3]=(q[5]^q[2]^q[0]);
  assign i[2]=~(q[7]^q[4]^q[1]);
  assign i[1]=(q[6]^q[3]^q[0]);
  assign i[0]=~(q[7]^q[5]^q[2]);
  
endmodule
