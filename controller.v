`include "defines.v"

module controller (rst,opCode, branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN,is_CLR, MEM_W_EN, hazard_detected,Is_Comp,MOV_EN,Is_Mul,is_jump);
  input hazard_detected,rst;
  input [`OP_CODE_LEN-1:0] opCode;
  output reg branchEn;
  output reg [`EXE_CMD_LEN-1:0] EXE_CMD;
  output reg [1:0] Branch_command;
  output reg Is_Imm, ST_or_BNE, WB_EN , MOV_EN, MEM_R_EN, MEM_W_EN,Is_Comp,Is_Mul,is_jump,is_CLR;

  always @ ( * ) begin
    if (hazard_detected == 0) begin
      {branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN} <= 0;
      case (opCode)
        // R-type operations
        `OP_ADD: begin EXE_CMD <= `EXE_ADD; WB_EN <= 1; end
        `OP_SUB: begin EXE_CMD <= `EXE_SUB; WB_EN <= 1; end
        `OP_AND: begin EXE_CMD <= `EXE_AND; WB_EN <= 1; end
        // `OP_OR:  begin EXE_CMD <= `EXE_OR;  WB_EN <= 1; end
        // `OP_NOR: begin EXE_CMD <= `EXE_NOR; WB_EN <= 1; end
        // `OP_XOR: begin EXE_CMD <= `EXE_XOR; WB_EN <= 1; end
        // `OP_SLA: begin EXE_CMD <= `EXE_SLA; WB_EN <= 1; end
        `OP_SLL: begin EXE_CMD <= `EXE_SLL; WB_EN <= 1; end
        `OP_MUL: begin EXE_CMD <= `EXE_MUL; WB_EN <= 1;Is_Mul<=1; end
        `OP_COMP: begin EXE_CMD <= `EXE_SUB; WB_EN <= 1;Is_Comp<=1; end
        // `OP_SRA: begin EXE_CMD <= `EXE_SRA; WB_EN <= 1; end
        // `OP_SRL: begin EXE_CMD <= `EXE_SRL; WB_EN <= 1; end
        // I-type operations
        `OP_ADDI: begin EXE_CMD <= `EXE_ADD; WB_EN <= 1; Is_Imm <= 1; end
        `OP_MOV: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1;MOV_EN<=1; end
        `OP_CLR: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 0;is_CLR<=1; end
        // `OP_SUBI: begin EXE_CMD <= `EXE_SUB; WB_EN <= 1; Is_Imm <= 1; end
        // memory operations
        `OP_LD: begin EXE_CMD <= `EXE_ADD; WB_EN <= 1; Is_Imm <= 1; ST_or_BNE <= 1; MEM_R_EN <= 1; end
        `OP_ST: begin EXE_CMD <= `EXE_ADD; Is_Imm <= 1; MEM_W_EN <= 1; ST_or_BNE <= 1; end
        // branch operations
        // `OP_BEZ: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_BEZ; branchEn <= 1; end
        `OP_BNE: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_BNE; branchEn <= 1; ST_or_BNE <= 1; end
        `OP_JMP: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_JUMP; branchEn <= 1; is_jump <=1; end
        default: {branchEn, EXE_CMD, Branch_command, Is_Imm,Is_Comp, ST_or_BNE, WB_EN, MOV_EN,MEM_R_EN, MEM_W_EN,Is_Mul, is_jump} <= 0;
      endcase
    end

    else if (hazard_detected ==  1) begin
      {EXE_CMD, WB_EN, MEM_W_EN} <= 0;
    end
    if(rst == 1)
      {branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN} <= 0;

  end
  always @(opCode)
  begin
    // $display("the exe command is: %b",EXE_CMD);
    // $display("the jump situation is: %b",is_jump);
    // $display("the immediate check is: %b",Is_Imm);
    // $display("the wb check is: %b",WB_EN);

  end
endmodule // controller
