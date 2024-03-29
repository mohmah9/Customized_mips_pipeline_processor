`include "defines.v"

module mux #(parameter integer LENGTH=15) (in1, in2, sel, out);
  input sel;
  input [LENGTH-1:0] in1, in2;
  output [LENGTH-1:0] out;

  assign out = (sel == 1) ? in2 : in1;
endmodule // mxu

module mux_3input #(parameter integer LENGTH=15) (in1, in2, in3, sel, out);
  input [LENGTH-1:0] in1, in2, in3;
  input [1:0] sel;
  output [LENGTH-1:0] out;

  assign out = (sel == 2'd0) ? in1 :
               (sel == 2'd1) ? in2 : in3;
endmodule // mux