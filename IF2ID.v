`include "defines.v"

module IF2ID (clk, rst, flush, freeze, PCIn, instructionIn, PC, instruction);
  input clk, rst, flush, freeze;
  input [`WORD_LEN-1:0] PCIn, instructionIn;
  output reg [`WORD_LEN-1:0] PC, instruction;

  always @ (posedge clk) begin
    if (rst) begin
      PC <= 0;
      instruction <= 0;
    end
    else begin
      if (~freeze) begin
        if (flush) begin
          instruction <= 0;
          PC <= 0;
        end
        else begin
          instruction <= instructionIn;
          PC <= PCIn;
        end
      end
    end
    // $display("IF2ID PC is : %b",PC);

  end
//   always @ (negedge clk) begin
//     $display("IF2ID instruction is : %b",instruction);
// end
endmodule // IF2ID
