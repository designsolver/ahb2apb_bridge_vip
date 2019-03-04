class ahb_reset_sequence extends ahb_base_sequence;
`uvm_object_utils(ahb_reset_sequence);

  extern function new(string name="ahb_reset_sequence");
  extern task body();

endclass : ahb_reset_sequence


function ahb_reset_sequence::new(string name="ahb_reset_sequence");
  super.new(name);
endfunction : new


task ahb_reset_sequence::body();
	fork
	begin
	`uvm_info("AHB_RESET_SEQUENCE","Reset sequence",UVM_MEDIUM);
	req = ahb_transaction::type_id::create("req");
	start_item(req);
	assert(req.randomize());
	req.HRESETn = 0;
	finish_item(req);
	end
	join
	disable fork;

endtask : body