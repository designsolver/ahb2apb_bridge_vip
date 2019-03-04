class apb_slave extends uvm_component;
`uvm_component_utils(apb_slave);

local bit [31:0] mem [int];

extern function new(string name="apb_slave",uvm_component parent=null);
extern function void load_data(input logic [31:0] data,[15:0] addr,output bit PSLVERR);
extern function void read_data(input logic [15:0] addr,output [31:0] data,output bit PSLVERR);
extern function void display_mem();

endclass : apb_slave

function apb_slave::new(string name="apb_slave",uvm_component parent=null);
  super.new(name,parent);
endfunction : new

function void apb_slave::load_data(input logic [31:0] data,[15:0] addr,output bit PSLVERR);
if((^addr == 1'bx) || (^data == 1'bx)) PSLVERR = 1;
else
begin
  mem[addr] = data;
  PSLVERR = 0;
end
endfunction : load_data

function void apb_slave::read_data(input [15:0] addr,output [31:0] data,output bit PSLVERR);
if(^addr == 1'bx)
begin
 data = 'd0;
 PSLVERR = 1;
end
else
begin
  data = mem[addr];
  PSLVERR = 0;
end
endfunction 

function void apb_slave::display_mem();
  `uvm_info("APB_SLAVE_MEMORY",$sformatf("%p",mem),UVM_MEDIUM);
endfunction : display_mem