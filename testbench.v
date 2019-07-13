`timescale 1s/1s

module testbench ();
  reg clk,rst, forwarding_EN;
  MIPS_Processor top_module (clk, rst, forwarding_EN);

  initial begin
    clk=1;
    repeat(510) #50 clk=~clk ;
  end

  initial begin
    rst = 1;
    forwarding_EN = 0;
    #1000
    rst = 0;
  end
endmodule // test
