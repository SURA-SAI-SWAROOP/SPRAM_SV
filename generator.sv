//Generator will randomize the transaction and sends the transaction to driver
class generator;
  
  //takes instance of transaction class
  transaction trans,tr;
  
  //specify number of items to generate
  int drv_count;
  
  //mailbox to generate and send the packet to driver
  mailbox gen2driv;
  
  //event to mention main task in generator is done
  event gen_ended;
  
  //constructor
  function new(mailbox gen2driv, event gen_ended);
    //get the mailbox handle from env, to share the transaction packet between the generator and driver
    this.gen2driv=gen2driv;
    this.gen_ended=gen_ended;
    trans=new();
  endfunction
  
  //main task, generates (create and randomizes) the repeat_count number of transactions packets and puts into mailbox
  task main();
    repeat(drv_count) begin
      if(!trans.randomize())
        $fatal ("generator: trans randomization failed");
      tr=trans.do_copy();
      gen2driv.put(tr);
    end
    ->gen_ended;
  endtask
endclass
