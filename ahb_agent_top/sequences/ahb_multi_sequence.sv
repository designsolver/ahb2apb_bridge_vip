class ahb_multi_sequence extends ahb_base_sequence;
`uvm_object_utils(ahb_multi_sequence);

static bit [15:0] q [$];
static bit [15:0] s;
static bit [3:0] r;
extern function new(string name="ahb_multi_sequence");
extern task body();

endclass : ahb_multi_sequence

function ahb_multi_sequence::new(string name="ahb_multi_sequence");
  super.new(name);
endfunction : new

task ahb_multi_sequence::body();

 
 repeat(`COUNT)
 begin
 `uvm_info("APB_MULTI_SEQUENCE","Reseting sequence",UVM_LOW);
 req = ahb_transaction::type_id::create("req");
 req.HRESETn = 0;
 start_item(req);
 finish_item(req);
 r = $urandom_range(10);
 repeat(r)
 begin
 `uvm_info("AHB_MULTI_SEQUENCE","Write sequence",UVM_MEDIUM);
 req = ahb_transaction::type_id::create("req");
 req.HRESETn = 1;
 start_item(req);
 assert(req.randomize());
 q.push_back(req.HADDR);
 finish_item(req);
 end

 repeat(r)
 begin
 `uvm_info("AHB_MULTI_SEQUENCE","Read sequence",UVM_MEDIUM);
 req = ahb_transaction::type_id::create("req");
 req.HRESETn = 1;
 start_item(req);
 req.write_only.constraint_mode(0);
 s = q.pop_front();
 assert(req.randomize() with {req.HWRITE == 0;req.HADDR == s;});
 finish_item(req);
 end

end
endtask : body