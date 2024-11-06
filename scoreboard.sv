//gets the packet from monitor, generated the expected result and compares with the actual result received from monitor

class scoreboard;
  //creating mailbox handle
  mailbox mon2scb:
  //used to count the number of transactions
  int no trans;
  
  //array to use as local memory to mimic main memory
  //replace it with associative array using addr as index and try
  bit[63:0]mem[15:0];
  
  //constructor
  function new (mailbox mon2scb);
    //getting the mailbox handles from environment
    this.mon2scb-mon2scb;
  endfunction
  
  //stores wdata and compare rdata with stored data
  task main;
    transaction trans;
    forever begin
      mon2scb.get(trans);
      if(trans.me) begin
        $display("wen=0h",trans.wen);
        if(trans.wen) begin
          mem[trans.addr=trans.wdata;
          $display("[scoreboard]\0t\tADDR=0h \tWDATA=%0h \t we=%oh", $time,trans.addr,mem[trans.addr], trans.wen);
        end
      else begin
        if(mem[trans.addr] != trans.rdata)
          $error("[SCB-FAIL] \t\tAddr=s0h,\n \t Data:: Expected=0h Actual soh", stime, trans.addr,mem[trans.addr),trans.rdata);
        else
          $display("[SCB-PASS] %0t\tAddr=%0h,\n \t Data:: Expected=0h Actual=Oh", stime,trans.addr,mem[trans.addr],trans.rdata);
      end
    end
    no_trans++;
  end
  endtask
endclass
