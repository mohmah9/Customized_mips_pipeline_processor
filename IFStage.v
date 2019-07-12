`include "defines.v"
// `include "mux.v"

module IFStage (clk, rst, brTaken,IsJump, brOffset, freeze, PC, instruction);
  input clk, rst, brTaken, freeze,IsJump;
  input [`WORD_LEN-1:0] brOffset;
  output [`WORD_LEN-1:0] PC, instruction;

  wire [`WORD_LEN-1:0] adderIn1, adderOut, brOffsetTimes2,adder2PC1,PCIn;


  adder add2 ( // pc add by 2 for next instruction
    .in1(PC),
    .in2(16'd2),
    .out(adderIn1)
  );


  adder addOffset ( // add branch offset for branch taken
    .in1(adderIn1),
    .in2(brOffsetTimes2),
    .out(adderOut)
  );

  mux #(.LENGTH(`WORD_LEN)) BrTakenMux ( // check branch taken for output
    .in1(adderIn1),
    .in2(adderOut),
    .sel(brTaken),
    .out(adder2PC1)
  );
  
  mux #(.LENGTH(`WORD_LEN)) JPTakenMux ( // check for jump and set PCin
    .in1(adder2PC1),
    .in2(brOffsetTimes2),
    .sel(IsJump),
    .out(PCIn)
  );

  register PCReg (
    .clk(clk),
    .rst(rst),
    .writeEn(~freeze),
    .regIn(PCIn),
    .regOut(PC)
  );

  instructionMem instructions (
    .rst(rst),
    .addr(PC),
    .instruction(instruction)
  );
  always @(instruction)
  begin
    $display("the instruction is: %b",instruction);
  end
  assign brOffsetTimes2 = brOffset << 1;
endmodule // IFStage
