//gets the packet from generator and drive the transaction packet items into interface
//interface is connected to DUT, so the items driven into interface signal will get driven into DUT
//hierarical reference to driver clocking block to drive signals inside clocking block

`define DRIV_IF mem_vif.DRIVER.driver_cb
class driver;
  //used to count the no. of transactions received
  int no_trans;
  
  //creating virtual interface handle
  virtual mem_intf mem_vif;
  
  //creating mailbox handle to receive transaction from generator
  mailbox gen2driv;
  transaction trans;
  
  //constructor
  function new(virtual mem_intf mem_vif,mailbox gen2driv);
    //getting the interface
    this.mem_vif=mem_vif;
    //getting mailbox handles from environment
    this.gen2driv=gen2driv;
  endfunction
  
  //drives the transaction items to interface signal
  task drive;
    `DRIV_IF.wen<=0
    `DRIV_IF.me<=0;
    gen2driv.get(trans);
    $display ("------DRIVER-TRANSFER:%0d------",no_trans);
    @(posedge mem_vif.DRIVER.clk);
    `DRIV_IF.addr<=trans.addr;
    `DRIV_IF.me<=trans.me;
    if(trans.me) begin
      if(trans.wen) begin
        `DRIV_IF.wen<=trans.wen;
        `DRIV_IF.wdata<=trans.wdata;
        $display("[DRIVER]%0t\tADDR=S0h \tWDATA=%0h \t we=%0h", $time,trans.addr, trans.wdata, trans.wen);
        @(posedge mem_vif.DRIVER.clk);
      end
      else begin
        @(posedge mem_vif.DRIVER.clk);
        `DRIV_IF.me<=1;
        @(posedge mem_vif.DRIVER.clk);
        trans.rdata= DRIV_IF.rdata;
        $display("[driver] %0t\tADDR=0h \tRDATA=%0h", $time, trans.addr, DRIV_IF.rdata);
      end
    end
    $display("-------------");
    no_trans++;
endtask
  
  //main task to call drive task
  task main;
    forever begin
      drive();
    end
  endtask
endclass
