`include "defines.v"

module EXE2MEM (clk, rst, WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, PCIn, ALUResIn, STValIn, destIn,
                          WB_EN,    MEM_R_EN,    MEM_W_EN,    PC,   ALURes,   STVal,   dest,COMP_EN_IN,HIGH_IN,MUL_EN_IN,MUL_EN_OUT,HIGH_OUT,COMP_EN_OUT);
  input clk, rst;
  // TO BE REGISTERED FOR ID STAGE
  input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,MUL_EN_IN,COMP_EN_IN;
  input [`REG_FILE_ADDR_LEN-1:0] destIn;
  input [`WORD_LEN-1:0] PCIn, ALUResIn, STValIn,HIGH_IN;
  // REGISTERED VALUES FOR ID STAGE
  output reg WB_EN, MEM_R_EN, MEM_W_EN,COMP_EN_OUT,MUL_EN_OUT;
  output reg [`REG_FILE_ADDR_LEN-1:0] dest;
  output reg [`WORD_LEN-1:0] PC, ALURes, STVal,HIGH_OUT;

  always @ (posedge clk) begin
    if (rst) begin
      {WB_EN, MEM_R_EN, MEM_W_EN, PC, ALURes, STVal, dest,HIGH_OUT,COMP_EN_OUT,MUL_EN_OUT} <= 0;
    end
    else begin
      WB_EN <= WB_EN_IN;
      MEM_R_EN <= MEM_R_EN_IN;
      MEM_W_EN <= MEM_W_EN_IN;
      PC <= PCIn;
      ALURes <= ALUResIn;
      STVal <= STValIn;
      dest <= destIn;
      HIGH_OUT <= HIGH_IN;
      COMP_EN_OUT <= COMP_EN_IN;
      MUL_EN_OUT <= MUL_EN_IN;
    end

  end
//   always @(negedge clk)begin
//     $display("EXE2MEM dest  is : %b",dest);   
// end
endmodule // EXE2MEM
