class ahb_main_sequence extends ahb_base_sequence;
`uvm_object_utils(ahb_main_sequence);
 
extern function new(string name="ahb_main_sequence");
extern task body();

endclass : ahb_main_sequence

function ahb_main_sequence::new(string name="ahb_main_sequence");
 super.new(name);
endfunction : new

task ahb_main_sequence::body();

	repeat(`COUNT)
	begin

	if(!i[0])
	begin
	`uvm_info("AHB_MAIN_SEQUENCE","Write sequence",UVM_MEDIUM);
	req = ahb_transaction::type_id::create("req");
	req.HRESETn = 1;
	req.slave_select0.constraint_mode(0);
	req.slave_select1.constraint_mode(0);
	req.slave_select2.constraint_mode(0);
	req.slave_select3.constraint_mode(0);
	start_item(req);
	assert(req.randomize());
	q = req.HADDR;
	finish_item(req);
	i++;
	end
	else
	begin
	`uvm_info("AHB_MAIN_SEQUENCE","Read sequence",UVM_MEDIUM);
	req = ahb_transaction::type_id::create("req");
	start_item(req);
	req.slave_select0.constraint_mode(0);
	req.slave_select1.constraint_mode(0);
	req.slave_select2.constraint_mode(0);
	req.slave_select3.constraint_mode(0);
	req.write_only.constraint_mode(0);
	req.HRESETn = 1;
	assert(req.randomize() with {req.HWRITE == 0;req.HADDR == q;});
	finish_item(req);
	i++;
	end
	end

endtask : body