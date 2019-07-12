`include "defines.v"

module regFile (clk, rst, src1, src2, dest, writeVal, writeEn, reg1, reg2,isComp,isMove,Immediate,BAreg,is_mul,High);
  input clk, rst, writeEn,isComp,isMove,is_mul;
  input [`REG_FILE_ADDR_LEN-1:0] src1, src2, dest;
  input [`WORD_LEN-1:0] writeVal,High;
  input [11:0] Immediate;
  output [`WORD_LEN-1:0] reg1, reg2 , BAreg;

  reg [`WORD_LEN-1:0] regMem [0:`REG_FILE_SIZE-1];
  integer i;

  always @ (negedge clk) begin
    if (rst) begin
      for (i = 0; i < `WORD_LEN; i = i + 1)
        regMem[i] <= 0;
	    end
    else if (is_mul) begin
      regMem[13]<=writeVal;
      regMem[12]<=High;
    end
    else if (writeEn) regMem[dest] <= writeVal;
    regMem[0] <= 0;
    if (isMove) regMem[src1] <= Immediate;
    if (isComp) begin
      if (writeVal == 0) begin
        regMem[9][0]<=1;
        regMem[9][1]<=0;
      end
      else if (writeVal < 0) begin
        regMem[9][0]<=0;
        regMem[9][1]<=1;
      end
      else begin
        regMem[9][0]<=0;
        regMem[9][1]<=0;
      end
    end
  end

  assign reg1 = (regMem[src1]);
  assign reg2 = (regMem[src2]);
  assign BAreg = (regMem[10]);
endmodule // regFile
