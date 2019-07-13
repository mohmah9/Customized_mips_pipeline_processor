`include "defines.v"
// `include "./mux.v"

module EXEStage (clk, EXE_CMD, val1_sel, val2_sel, ST_val_sel, val1, val2, ALU_res_MEM, result_WB, ST_value_in, ALUResult, ST_value_out,BA_Reg,MEM_W_EN2EXE,MEM_R_EN2EXE,high_OUT);
  input clk,MEM_W_EN2EXE,MEM_R_EN2EXE;
  input [`FORW_SEL_LEN-1:0] val1_sel, val2_sel, ST_val_sel;
  input [`EXE_CMD_LEN-1:0] EXE_CMD;
  input [`WORD_LEN-1:0] val1, val2, ALU_res_MEM, result_WB, ST_value_in,BA_Reg;
  output [`WORD_LEN-1:0] ALUResult, ST_value_out,high_OUT;

  wire [`WORD_LEN-1:0] ALU_val1, ALU_val2 , mux_val1src1;
  wire temp;

  mux #(.LENGTH(`WORD_LEN)) BaMux(
    .in1(val1),
    .in2(BA_Reg),
    .sel(temp),
    .out(mux_val1src1)
  );
  mux_3input #(.LENGTH(`WORD_LEN)) mux_val1 (
    .in1(mux_val1src1),
    .in2(ALU_res_MEM),
    .in3(result_WB),
    .sel(val1_sel),
    .out(ALU_val1)
  );

  mux_3input #(.LENGTH(`WORD_LEN)) mux_val2 (
    .in1(val2),
    .in2(ALU_res_MEM),
    .in3(result_WB),
    .sel(val2_sel),
    .out(ALU_val2)
  );

  // mux_3input #(.LENGTH(`WORD_LEN)) mux_ST_value (
  //   .in1(ST_value_in),
  //   .in2(ALU_res_MEM),
  //   .in3(result_WB),
  //   .sel(ST_val_sel),
  //   .out(ST_value_out)
  // );

  ALU ALU(
    .val1(ALU_val1),
    .val2(ALU_val2),
    .EXE_CMD(EXE_CMD),
    .aluOut(ALUResult),
    .high(high_OUT)
  );
  // always@(negedge clk)begin
  //   $display("EXE: ALUResult is : %b",ALUResult);  
  //   end
  assign ST_value_out = val1;
  assign temp = MEM_W_EN2EXE | MEM_R_EN2EXE;
endmodule // EXEStage
