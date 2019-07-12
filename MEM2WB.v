`include "defines.v"

module MEM2WB (clk, rst, WB_EN_IN, MEM_R_EN_IN, ALUResIn, memReadValIn, destIn,
                         WB_EN,    MEM_R_EN,    ALURes,   memReadVal,   dest , HIGH_IN,MUL_EN_IN,COMP_EN_IN,HIGH_OUT,MUL_EN_OUT,COMP_EN_OUT);
  input clk, rst;
  // TO BE REGISTERED FOR ID STAGE
  input WB_EN_IN, MEM_R_EN_IN,MUL_EN_IN,COMP_EN_IN;
  input [`REG_FILE_ADDR_LEN-1:0] destIn;
  input [`WORD_LEN-1:0] ALUResIn, memReadValIn,HIGH_IN;
  // REGISTERED VALUES FOR ID STAGE
  output reg WB_EN, MEM_R_EN,MUL_EN_OUT,COMP_EN_OUT;
  output reg [`REG_FILE_ADDR_LEN-1:0] dest;
  output reg [`WORD_LEN-1:0] ALURes, memReadVal,HIGH_OUT;

  always @ (posedge clk) begin
    if (rst) begin
      {WB_EN, MEM_R_EN, dest, ALURes, memReadVal,HIGH_OUT,COMP_EN_OUT,MUL_EN_OUT} <= 0;
    end
    else begin
      WB_EN <= WB_EN_IN;
      MEM_R_EN <= MEM_R_EN_IN;
      dest <= destIn;
      ALURes <= ALUResIn;
      memReadVal <= memReadValIn;
      HIGH_OUT <= HIGH_IN;
      COMP_EN_OUT<= COMP_EN_IN;
      MUL_EN_OUT <= MUL_EN_IN;
    end
  end
endmodule // MEM2WB
