class ahb_transaction extends uvm_sequence_item;

  bit HRESETn;

  rand bit HWRITE;
  //rand bit [1:0] HTRANS;
  //rand bit [2:0] HSIZE;
  //rand bit [2:0] HBURST;
  rand bit [31:0] HWDATA;
  randc bit [15:0] HADDR;

  bit HRESP;
  bit HREADY;
  bit PREADY;
  bit [31:0] HRDATA;


constraint slave_select0 { HADDR[15:12] == 4'd1;}
constraint slave_select1 { HADDR[15:12] == 4'd2;}
constraint slave_select2 { HADDR[15:12] == 4'd4;}
constraint slave_select3 { HADDR[15:12] == 4'd8;}
constraint slave_select { HADDR[15:12] inside {0,1,2,4,8};}

constraint write_only { HWRITE == 1'b1;}

`uvm_object_utils_begin(ahb_transaction)
	`uvm_field_int(HRESETn,UVM_ALL_ON)
	`uvm_field_int(HWRITE, UVM_ALL_ON)
	`uvm_field_int(HWDATA, UVM_ALL_ON)
	`uvm_field_int(HADDR,  UVM_ALL_ON)
	`uvm_field_int(HRESP,  UVM_ALL_ON)
	`uvm_field_int(HREADY, UVM_ALL_ON)
	`uvm_field_int(PREADY, UVM_ALL_ON)
	`uvm_field_int(HRDATA, UVM_ALL_ON)
`uvm_object_utils_end

extern function new(string name="ahb_transaction");

endclass : ahb_transaction

function ahb_transaction::new(string name="ahb_transaction");
  super.new(name);
endfunction : new

