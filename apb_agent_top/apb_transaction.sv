class apb_transaction extends uvm_sequence_item;

 bit PRESETn;
 bit [3:0]PSELx;
 bit PENABLE;
 bit PWRITE;
 bit [15:0] PADDR;
 bit [31:0] PWDATA;
 bit [31:0] PRDATA;
 bit PSLVERR;

`uvm_object_utils_begin(apb_transaction)
	`uvm_field_int(PRESETn, UVM_ALL_ON)
	`uvm_field_int(PSELx,   UVM_ALL_ON)
	`uvm_field_int(PENABLE, UVM_ALL_ON)
	`uvm_field_int(PWRITE,  UVM_ALL_ON)
	`uvm_field_int(PADDR,   UVM_ALL_ON)
	`uvm_field_int(PWDATA,  UVM_ALL_ON)
	`uvm_field_int(PRDATA,  UVM_ALL_ON)
	`uvm_field_int(PSLVERR, UVM_ALL_ON)
`uvm_object_utils_end

extern function new(string name="apb_transaction");

endclass : apb_transaction

function apb_transaction::new(string name="apb_transaction");
 super.new(name);
endfunction : new
