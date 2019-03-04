class ahb_slave2_sequence extends ahb_base_sequence;
`uvm_object_utils(ahb_slave2_sequence);

 
extern function new(string name="ahb_slave2_sequence");
extern task body();

endclass : ahb_slave2_sequence

function ahb_slave2_sequence::new(string name="ahb_slave2_sequence");
 super.new(name);
endfunction : new

task ahb_slave2_sequence::body();

	repeat(`COUNT)
	begin

	if(!i[0])
	begin
	`uvm_info("ahb_slave2_sequence","Write sequence",UVM_MEDIUM);
	req = ahb_transaction::type_id::create("req");
	req.HRESETn = 1;
	req.slave_select0.constraint_mode(0);
	req.slave_select.constraint_mode(0);
	req.slave_select1.constraint_mode(0);
	req.slave_select3.constraint_mode(0);
	start_item(req);
	assert(req.randomize());
	q = req.HADDR;
	finish_item(req);
	i++;
	end
	else
	begin
	`uvm_info("ahb_slave2_sequence","Read sequence",UVM_MEDIUM);
	req = ahb_transaction::type_id::create("req");
	start_item(req);
	req.slave_select0.constraint_mode(0);
	req.slave_select.constraint_mode(0);
	req.slave_select1.constraint_mode(0);
	req.slave_select3.constraint_mode(0);
	req.write_only.constraint_mode(0);
	req.HRESETn = 1;
	assert(req.randomize() with {req.HWRITE == 0;req.HADDR == q;});
	finish_item(req);
	i++;
	end
	end

endtask : body