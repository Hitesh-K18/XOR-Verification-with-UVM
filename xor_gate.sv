
module xor_gate(input A,B,output C);
  assign C=A?(~B):B;
endmodule