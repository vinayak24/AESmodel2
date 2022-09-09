module aes_sbox(Clk,a,d); 
  input Clk;
  input [7:0]a;  
  output reg [7:0]d;
  wire  [7:0]outa;

  wire [3:0]C,Dd,E,F,G,I,J,H,M,N;  
  wire [7:0]B,O,P;  
  assign C=B[7:4];  
  assign Dd=B[3:0];  
  assign O[7:4]=M;  
  assign O[3:0]=N;

  always @ (Clk)
    d= outa;

    
   S_Isomorphic_Map S1(.X(a),.Y(B));
   S_Square_Block S2(.X(C),.Y(E));
   S_4bitAdd S3(.X(Dd),.Y(C),.Z(F));
   S_4bitmulitiplication S4(.A(F),.B(Dd),.D(G));
   S_4bitAdd S5(.X(G),.Y(H),.Z(I));
   S_Multi_Constant_lambda S6(.A(E),.B(H));
   S_Multiplicative_Inv S7(.A(I),.B(J));
   S_4bitmulitiplication S8(.A(J),.B(C),.D(M));
   S_4bitmulitiplication S9(.A(J),.B(F),.D(N));   
   S_Inv_Isomorphic_Map S10(.Y(O),.X(P));  
   S_affine S11(.i(P),.q(outa));   
    
  endmodule

    



module S_4bitAdd(X,Y,Z);
  
  input[3:0]X,Y;
  
  output [3:0]Z;
  
  xor x1(Z[0],X[0],Y[0]);
  
  xor x2(Z[1],X[1],Y[1]);
  
  xor x3(Z[2],X[2],Y[2]);
  
  xor x4(Z[3],X[3],Y[3]);
  
endmodule   

module S_4bitmulitiplication(A,B,D);
  
  input [3:0]A,B;
  
  output [3:0]D;
  
  wire [1:0]x,y,p,q,r,s;
  


S_2bitAdd V2 (
             .X(A[3:2]), 
             .Y(A[1:0]), 
             .Z(x)
             );
    
S_2bitAdd V3 (
             .X(B[3:2]), 
             .Y(B[1:0]), 
             .Z(y)
             );
    
S_2bitAdd  V4 (
               .X(q), 
               .Y(r), 
               .Z(D[3:2])
               );
    
S_2bitAdd V5 (
              .X(r), 
              .Y(s), 
              .Z(D[1:0])
              );

S_2BitMulitiplication V6 (
    .X(A[3:2]), 
    .Y(B[3:2]), 
    .Z(p)
    );
    
 S_Multi_Constant V1 (
                     .X(p), 
                     .Y(s)
                     );
       

S_2BitMulitiplication V7 (
    .X(x), 
    .Y(y), 
    .Z(q)
    );
    
S_2BitMulitiplication V8 (
    .X(A[1:0]), 
    .Y(B[1:0]), 
    .Z(r)
    );
    
endmodule


module S_affine(i,q);

  input [7:0]i;

  output [7:0]q;

  assign q[7]=(i[7]^i[6]^i[5]^i[4]^i[3]);
  assign q[6]=~(i[6]^i[5]^i[4]^i[3]^i[2]);
  assign q[5]=~(i[5]^i[4]^i[3]^i[2]^i[1]);
  assign q[4]=(i[4]^i[3]^i[2]^i[1]^i[0]);
  assign q[3]=(i[7]^i[3]^i[2]^i[1]^i[0]);
  assign q[2]=(i[7]^i[6]^i[2]^i[1]^i[0]);
  assign q[1]=~(i[7]^i[6]^i[5]^i[1]^i[0]);
  assign q[0]=~(i[7]^i[6]^i[5]^i[4]^i[0]);

endmodule


module S_Isomorphic_Map(X,Y);
  
  input [7:0]X;
  
  output [7:0]Y;
  
  assign Y[7]=X[7]^X[5];
  
  assign Y[6]=X[7]^X[6]^X[4]^X[3]^X[2]^X[1];
  
  assign Y[5]=X[7]^X[5]^X[3]^X[2];
  
  assign Y[4]=X[7]^X[5]^X[3]^X[2]^X[1];
  
  assign Y[3]=X[7]^X[6]^X[2]^X[1];
  
  assign Y[2]=X[7]^X[4]^X[3]^X[2]^X[1];
  
  assign Y[1]=X[6]^X[4]^X[1];
  
  assign Y[0]=X[6]^X[1]^X[0];
  
endmodule


module S_2bitAdd(X,Y,Z);
  
  input[1:0]X,Y;
  
  output [1:0]Z;
  
  xor x1(Z[0],X[0],Y[0]);
  
  xor x2(Z[1],X[1],Y[1]);
  
endmodule

module S_2BitMulitiplication(X,Y,Z);
  
  input [1:0]X,Y;
  
  output [1:0]Z;
  
  wire c,d,e,f,g;
  
  and a1(e,X[1],Y[1]);
  and a2(f,c,d);
  and a3(g,X[0],Y[0]);
  xor x1(c,X[1],X[0]);
  xor x2(d,Y[0],Y[1]);
  xor x3(Z[1],f,g);
  xor x4(Z[0],e,g);
endmodule

module S_Square_Block(X,Y);
  input [3:0]X;
  output [3:0]Y;
wire c;  
xor x1(c,X[0],X[1]);
xor x2(Y[1],X[1],X[2]);
xor x3(Y[2],X[2],X[3]);
xor x4(Y[0],X[3],c);
assign Y[3]=X[3];
endmodule



module S_Multiplicative_Inv(A,B);
  input [3:0]A;
  output [3:0]B;
  wire [3:0]a,b,c,d;
  
S_Square_Block VA1 (
    .X(A), 
    .Y(a)
    );

S_Square_Block VA2 (
    .X(a), 
    .Y(b)
    );

S_Square_Block VA3 (
    .X(b), 
    .Y(c)
    );

S_4bitmulitiplication VA4 (
    .A(a), 
    .B(b), 
    .D(d)
    );

S_4bitmulitiplication VA5 (
    .A(d), 
    .B(c), 
    .D(B)
    );

endmodule 

module S_Multi_Constant(X,Y);
  input [1:0]X;
  output[1:0]Y;
  xor x1(Y[1],X[0],X[1]);
  assign Y[0]=X[1];
endmodule

module S_Multi_Constant_lambda(A,B);
  
  input [3:0]A;
  output [3:0]B;
  
  xor x1(c,A[1],A[3]);
  xor x2(d,A[0],A[2]);
  xor x3(e,d,c);
  assign B[0]=A[2];
  assign B[1]=A[3];
  assign B[2]=e;
  assign B[3]=d;
  
endmodule

module S_Inv_Isomorphic_Map(Y,X);
  
  input [7:0]Y;
  
  output [7:0]X;
  
  assign X[7]=Y[7]^Y[6]^Y[5]^Y[1];
  
  assign X[6]=Y[6]^Y[2];
  
  assign X[5]=Y[6]^Y[5]^Y[1];
  
  assign X[4]=Y[6]^Y[5]^Y[4]^Y[2]^Y[1];
  
  assign X[3]=Y[5]^Y[4]^Y[3]^Y[2]^Y[1];
  
  assign X[2]=Y[7]^Y[4]^Y[3]^Y[2]^Y[1];
  
  assign X[1]=Y[5]^Y[4];
  
  assign X[0]=Y[6]^Y[5]^Y[4]^Y[2]^Y[0];
  
endmodule






