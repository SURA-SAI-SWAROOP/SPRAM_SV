class transaction;
  //declaring all the DUT inputs and outputs
  rand bit [63:0]wdata;
  rand bit [15:0]addr;
  rand bit wen;
  rand bit me;
  bit [63:0]rdata;
  int count=0;
  int a=0;
  
  //post randomize function to display randomized items
  function void post_randomize();
    $display("-------------post_randomize---------");
    $display("\t addr=%0h", addr);
    if (me)
      $display("\t wen=%0h\t wdata=%0h/t me=%0h", wen, wdata, me);
    count++;
    if (a<4) begin
      a++;
    end
    else
    a=0;
    $display("-----------------")
  endfunction
    
  constraint me_const{me==1;}
  constraint wdata_range (wdata inside ([10:50]};}
  constraint wen_const{
    if(count<5) {wen==1};
    else (wen==0);
  }
  constraint addr_range (addr==a;}
                         
  //function string convert2string();
  //return $sformat("addr=%0h, wdata=%0h, wen=%0h,me=%oh", addr, wdata, wen, me);
  //endfunction
                         
  //deep copy method
  function transaction do_copy();
    transaction trans;
    trans=new();
    trans.addr=this.addr;
    trans.wen=this.wen;
    trans.me=this.me;
    trans.wdata=this.wdata;
    return trans;
  endfunction
endclass
