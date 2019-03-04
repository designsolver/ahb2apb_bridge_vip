class ahb_monitor_passive extends uvm_monitor;
`uvm_component_utils(ahb_monitor_passive);

 uvm_analysis_port #(ahb_transaction) monitor_ap;

 virtual ahb_if vif;
 ahb_transaction tx;
 ahb_agent_config cfg_h;

extern function new(string name="ahb_monitor_passive",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task monitor_bridge();
extern task get_data();
extern task transfer();

endclass : ahb_monitor_passive 

function ahb_monitor_passive::new(string name="ahb_monitor_passive",uvm_component parent=null);
  super.new(name,parent);
  monitor_ap = new("monitor_ap",this);
endfunction : new

function void ahb_monitor_passive::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",cfg_h))
	`uvm_fatal("AHB_MONITOR_PASSIVE/NOCONFIG",{"Configuration must be set for : ",get_full_name(),".cfg"});
endfunction : build_phase

function void ahb_monitor_passive::connect_phase(uvm_phase phase);
  vif = cfg_h.vif;
endfunction : connect_phase

function void ahb_monitor_passive::end_of_elaboration_phase(uvm_phase phase);
   `uvm_info("AHB_MONITOR_PASSIVE",{get_full_name()," Created.."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

task ahb_monitor_passive::run_phase(uvm_phase phase);
 //phase.raise_objection(this);
 forever 
 begin
	tx = ahb_transaction::type_id::create("tx");
	do
	@(vif.monitor_cb);
	while(!vif.monitor_cb.HRESETn);
	@(vif.monitor_cb);
	monitor_bridge();
 end
 //phase.drop_objection(this); 
endtask : run_phase

task ahb_monitor_passive::monitor_bridge();
	if(!vif.monitor_cb.HWRITE && vif.monitor_cb.HRESETn)
		get_data();
endtask : monitor_bridge

task ahb_monitor_passive::get_data();
	tx.HWRITE = vif.monitor_cb.HWRITE;
	tx.HADDR = vif.monitor_cb.HADDR;
 	repeat(5)
	@(vif.monitor_cb);
	tx.HRDATA = vif.monitor_cb.HRDATA;
	transfer();
endtask : get_data

task ahb_monitor_passive::transfer();
  `uvm_info("AHB_MONITOR_PASSIVE",$sformatf("addr = %0d  read data = %0d",tx.HADDR,tx.HRDATA),UVM_MEDIUM);
  monitor_ap.write(tx);
endtask : transfer