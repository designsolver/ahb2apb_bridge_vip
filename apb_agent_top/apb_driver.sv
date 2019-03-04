class apb_driver extends uvm_driver #(apb_transaction);
`uvm_component_utils(apb_driver);

apb_agent_config cfg_h;

apb_transaction req;
apb_transaction resp;

//uvm_analysis_port #(apb_transaction) ap;

virtual apb_if vif;

extern function new(string name="apb_driver",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task request_slave();
extern task recieve();
//extern task transfer();

endclass : apb_driver

function apb_driver::new(string name="apb_driver",uvm_component parent=null);
  super.new(name,parent);
 // ap = new("ap",this);
endfunction : new

function void apb_driver::build_phase(uvm_phase phase);
 if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",cfg_h))
	`uvm_fatal("APB_DRIVER",{"Unable to access configuration object : ",get_full_name(),".cfg"});
endfunction : build_phase

function void apb_driver::connect_phase(uvm_phase phase);
  vif = cfg_h.vif;
endfunction : connect_phase

function void apb_driver::end_of_elaboration_phase(uvm_phase phase);
 `uvm_info("APB_DRIVER",{get_full_name()," Created..."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

task apb_driver::run_phase(uvm_phase phase);
 // phase.raise_objection(this);
  forever
  begin
  do
  @(vif.master_cb);
  while(vif.master_cb.PSELx == 0);
  @(vif.master_cb)
  request_slave();

  end
 // phase.drop_objection(this);
endtask : run_phase

task apb_driver::request_slave();
  seq_item_port.get_next_item(req);
  req.PWRITE = vif.master_cb.PWRITE;
  req.PWDATA = vif.master_cb.PWDATA;
  req.PSELx = vif.master_cb.PSELx;
  req.PADDR = vif.master_cb.PADDR;
  seq_item_port.item_done();
  recieve();	
endtask : request_slave

task apb_driver::recieve();
  seq_item_port.get_next_item(resp);
//  resp.PWRITE = vif.master_cb.PWRITE;
  @(vif.master_cb);
  vif.master_cb.PRDATA <= resp.PRDATA;
  vif.master_cb.PSLVERR <= resp.PSLVERR;
  seq_item_port.item_done();
//  transfer();
endtask : recieve

//task apb_driver::transfer();
//  ap.write(resp);
//endtask : transfer