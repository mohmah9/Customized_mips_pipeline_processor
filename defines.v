// Wire widths
`define WORD_LEN 16
`define REG_FILE_ADDR_LEN 4
`define EXE_CMD_LEN 4
`define FORW_SEL_LEN 2
`define OP_CODE_LEN 4

// Memory constants
`define DATA_MEM_SIZE 3072
`define INSTR_MEM_SIZE 1024
`define REG_FILE_SIZE 14 //14
`define MEM_CELL_SIZE 8

// To be used inside controller.v
`define OP_NOP 4'b1000 // 10 available
`define OP_ADD 4'b0000 
`define OP_ADDC 4'b0001
`define OP_SUB 4'b0010 
`define OP_AND 4'b0101 //4'b0101
`define OP_SLL 4'b0110 //4'b0110
`define OP_ADDI 4'b0011 //4'b0011
`define OP_LD 4'b0111 //4'b0111
`define OP_ST 4'b1001 //4'b1001
`define OP_BNE 4'b1110 //4'b1110
`define OP_JMP 4'b1111 
`define OP_MUL 4'b0100
`define OP_CLR 4'b1011
`define OP_MOV 4'b1100
`define OP_COMP 4'b1101

// To be used in side ALU
`define EXE_ADD 4'b0000
`define EXE_SUB 4'b0010
`define EXE_AND 4'b0100
`define EXE_MUL 4'b0101
// `define EXE_NOR 4'b0110
// `define EXE_XOR 4'b0111
// `define EXE_SLA 4'b1000
`define EXE_SLL 4'b1000
// `define EXE_SRA 4'b1001
// `define EXE_SRL 4'b1010
`define EXE_NO_OPERATION 4'b1111 // for NOP, BEZ, BNQ, JMP

// To be used in conditionChecker
`define COND_JUMP 2'b10
`define COND_BEZ 2'b11
`define COND_BNE 2'b01
`define COND_NOTHING 2'b00
