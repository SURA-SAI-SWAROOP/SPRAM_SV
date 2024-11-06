interface mem_intf(input logic clk, reset);
//declaring all the signals
logic [15:0laddr;
logic wen;
logic me;
logic [63:0]wdata;
logic [63:0]rdata;
//driver clocking block
clocking driver_cb@(posedge clk); default input #1 output #1;
output addr;
output wen;
output me;
output wdata;
input rdata;
endclocking
//monitor clocking block
clocking monitor_cb@(posedge clk);
default input #1 output #1;
input addr;
input wen;
input me;
input wdata;
input rdata;
endclocking
//driver modport
modport DRIVER (clocking driver_cb, input clk, reset);
//monitor modport
modport MONITOR (clocking monitor_cb, input clk, reset);
endinterface
