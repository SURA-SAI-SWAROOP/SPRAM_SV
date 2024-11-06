include "transaction.sv"
include "generator.sv"
include "driver.sv"
include "monitor.sv"
include "scoreboard.sv
class environment;
//generator and driver instance
generator gen;
driver driv; monitor mon;
scoreboard scb;
//mailbox handles mailbox gen2driv; mailbox mon2scb;
//event for synchronization between generator and test
event gen_ended;
//virtual interface virtual mem_intf mem_vif;
//constructor
function new(virtual mem_intf mem_vif); //get the interface from test
this.mem_vif=mem_vif;
//creating the mailbox (same handle will be shared across generator and driver)
gen2driv=new();
mon2scb=new();
//creating generator and driver gen=new(gen2driv, gen_ended); driv=new(mem_vif,gen2driv); mon=new(mem_vif,mon2scb); scb=new(mon2scb);
endfunction
task pre_test();
sdisplay("starting tets");
endtask
fork
gen.main();
driv.main();
mon.main();
  scb.main();
join_any
endtask
task post_test(); $display("waiting for stimulus to generate"); wait(gen_ended.triggered);
$display("waiting for stimulus to drive");
wait(gen.drv_count==driv.no_trans); ay("waiting fo for stimulus to check"); $display("waiting
wait(gen.drv_count==scb.no_trans);
endtask
//run task task run(); pre_test(); test(); post_test(); $finish;
endtask
endclass
