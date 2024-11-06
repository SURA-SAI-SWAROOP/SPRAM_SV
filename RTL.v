module spram(
  input clk,reset,
  input [63:0]wdata,
  input [15:0]addr,
  input me,wen,
  output reg [63:0]rdata
);
reg[63:0]mem [(2**16):0];
integer i;
  
always@(posedge clk) begin
  if(reset)begin
    for(i=0;i<2**16;i=i+1)begin
      mem[i]<=64'd0;
      end
    end
    else begin
      if(me)begin
        if(wen)begin
          mem [addr]<=wdata;
        end
        else begin
          rdata<=mem [addr];
        end
          end
        else begin
          rdata<=64'dz;
        end
      end
    end
  endmodule
