`include "interface.sv"
`include "random_test.sv"
`include "spram.v"
module tb_top;
//clock and reset signal declaration
bit clk;
bit reset;
//clock generation always #5 clk=-clk;
//reset generation
initial begin
reset=1;
#10 reset=0;
end
//create instance of interface, to connect DUT and testcase mem_intf intf(clk, reset);
//Testcase instance, interface hamdle is passed to test as an argument test tl(intf);
//DUT instance, interface signals are connected to the DUT ports spram dut ( .clk(intf.clk), .reset(intf.reset), .addr(intf.addr), wen(intf.wen), .me(intf.me), .wdata(intf.wdata), .rdata(intf.rdata)
);
endmodule
