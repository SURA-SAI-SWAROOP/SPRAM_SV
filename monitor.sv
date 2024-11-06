//samples the interface signals, captures into transaction packet and send the packet to scoreboard
define MON_IF mem_vif.MONITOR.monitor_cb
class monitor;
//creating virtual interface handle virtual mem_intf mem_vif;
//creating mailbox handle mailbox mon2scb;
transaction trans;
//constructor
function new(virtual mem_intf mem_vif, mailbox mon2scb);
//getting the interface this.mem_vif=mem_vif;
//getting the mailbox handles from environment this.mon2scb=mon2scb;
endfunction
task main();
forever begin
trans=new();
@(posedge mem_vif.MONITOR.clk);
@(posedge mem_vif.MONITOR.clk);
trans.me MON_IF.me;
trans.addr MON_IF.addr;
trans.wdata = MON_IF.wdata;
trans.wen = MON_IF.wen;
$display("[monitor] Ot\tADDR=S0h \tWDATA=0h \t we=0h", $time, trans.addr, trans.wdata, trans.wen);
if((MON_IF.wen)) begin
@(posedge mem_vif.MONITOR.clk);
//@(posedge mem_vif.MONITOR.clk);
trans.rdata=MON IF.rdata;
end
$display("putting data into scoreboard");
mon2scb.put(trans);
end
endtask
endclass
