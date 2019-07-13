`include "defines.v"

module hazard_detection( is_imm, ST_or_BNE, src1_ID, src2_ID, dest_EXE, WB_EN_EXE, dest_MEM, WB_EN_MEM, MEM_R_EN_EXE, branch_comm, hazard_detected,clk);
  input [`REG_FILE_ADDR_LEN-1:0] src1_ID, src2_ID;
  input [`REG_FILE_ADDR_LEN-1:0] dest_EXE, dest_MEM;
  input [1:0] branch_comm;
  input WB_EN_EXE, WB_EN_MEM, is_imm, ST_or_BNE, MEM_R_EN_EXE,clk;
  output reg hazard_detected;
  reg[1:0] count;
  initial count = 2'b00;
  initial hazard_detected = 0;
  wire src2_is_valid, exe_has_hazard, mem_has_hazard, hazard, instr_is_branch;
  always @(posedge clk)
  begin
    if(count == 0 && branch_comm == 2'b01)
      begin
        count = 2'b11;
        hazard_detected <= 1;
      end
    else if(count != 2'b01 && branch_comm == 2'b01)
    begin
      count = count -1;
      hazard_detected <= 1;
    end
    else if(count == 2'b01 && branch_comm == 2'b01)
    begin
      count = 0;
      hazard_detected <= 0;
    end
    else
      hazard_detected <= MEM_R_EN_EXE && WB_EN_EXE && (src1_ID == dest_EXE || (~is_imm && src2_ID == dest_EXE));

  end
  // assign src2_is_valid =  (~is_imm);// || ST_or_BNE;

  // assign hazard_detected = MEM_R_EN_EXE && WB_EN_EXE && (src1_ID == dest_EXE || (~is_imm && src2_ID == dest_EXE));
  // assign mem_has_hazard = WB_EN_MEM && (src1_ID == dest_MEM || (~is_imm && src2_ID == dest_MEM));

  // assign hazard = (exe_has_hazard || mem_has_hazard);
  // assign instr_is_branch = (branch_comm == `COND_BNE);

  // assign hazard_detected = ~forward_EN ? hazard : (instr_is_branch && hazard) || (MEM_R_EN_EXE && mem_has_hazard);
endmodule