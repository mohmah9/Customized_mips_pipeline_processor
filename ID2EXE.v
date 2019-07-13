`include "defines.v"

module ID2EXE (clk, rst, destIn, reg2In, val1In, val2In, PCIn, EXE_CMD_IN, MEM_R_EN_IN, MEM_W_EN_IN, WB_EN_IN, brTaken_in, src1_in, src2_in,
                         dest,   ST_value,   val1,   val2,   PC,  EXE_CMD,    MEM_R_EN,    MEM_W_EN,    WB_EN, brTaken_out, src1_out, src2_out,COMP_EN_IN,COMP_EN,BA_reg,BA_reg_out,IsMul,MUL_EN_OUT);
  input clk, rst;
  input COMP_EN_IN;
  // TO BE REGISTERED FOR ID STAGE
  input MEM_R_EN_IN, MEM_W_EN_IN, WB_EN_IN, brTaken_in,IsMul;
  input [`EXE_CMD_LEN-1:0] EXE_CMD_IN;
  input [`REG_FILE_ADDR_LEN-1:0] destIn, src1_in, src2_in;
  input [`WORD_LEN-1:0] reg2In, val1In, val2In, PCIn, BA_reg;
  // REGISTERED VALUES FOR ID STAGE
  output reg MEM_R_EN, MEM_W_EN, WB_EN, brTaken_out,COMP_EN,MUL_EN_OUT;
  output reg [`EXE_CMD_LEN-1:0] EXE_CMD;
  output reg [`REG_FILE_ADDR_LEN-1:0] dest, src1_out, src2_out;
  output reg [`WORD_LEN-1:0] ST_value, val1, val2, PC ,BA_reg_out;
  reg temp;

  always @ (posedge clk) begin
    if (rst) begin
      {MEM_R_EN, MEM_R_EN, WB_EN, EXE_CMD, dest, ST_value, val1, val2, PC, brTaken_out, src1_out, src2_out,COMP_EN,BA_reg_out} <= 0;
    end
    else begin
      MEM_R_EN <= MEM_R_EN_IN;
      MEM_W_EN <= MEM_W_EN_IN;
      WB_EN <= WB_EN_IN;
      EXE_CMD <= EXE_CMD_IN;
      dest <= destIn;
      ST_value <= reg2In;
      val1 <= val1In;
      val2 <= val2In;
      PC <= PCIn;
      brTaken_out <= brTaken_in;
      src1_out <= src1_in;
      src2_out <= src2_in;
      COMP_EN <= COMP_EN_IN;
      BA_reg_out  <= BA_reg;
      MUL_EN_OUT <= IsMul;
    end
    // $display("ID2EXE dest  is : %b",dest);
    // $display("ID2EXE destIN  is : %b",destIn);

    // $display("ID2EXE value 1 is : %b",val1);

  end
endmodule // ID2EXE
