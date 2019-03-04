class ahb_monitor extends uvm_monitor;

`uvm_component_utils(ahb_monitor);

ahb_agent_config cfg;

uvm_analysis_port #(ahb_transaction) monitor_ap;

virtual ahb_if vif;

ahb_transaction tx;

extern function new(string name="ahb_monitor",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task monitor_bridge();
extern task get_data();
extern task transfer();

endclass : ahb_monitor


function ahb_monitor::new(string name="ahb_monitor",uvm_component parent=null);
  super.new(name,parent);
  monitor_ap = new("monitor_ap",this);
endfunction : new

function void ahb_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",cfg))
	`uvm_fatal("AHB_MONITOR/ACTIVE/NOCONFIG",{"configuration must be set for : ",get_full_name(),".cfg"});
endfunction : build_phase

function void ahb_monitor::connect_phase(uvm_phase phase);
  vif = cfg.vif;
endfunction : connect_phase

function void ahb_monitor::end_of_elaboration_phase(uvm_phase phase);
 `uvm_info("AHB_MONITOR/ACTIVE",{get_full_name(), "created..."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

task ahb_monitor::run_phase(uvm_phase phase);
//phase.raise_objection(this);
  forever 
  begin
	tx = ahb_transaction::type_id::create("tx");
	do
	@(vif.monitor_cb);
	while(vif.monitor_cb.HRESETn != 1);

	@(vif.monitor_cb);
	  monitor_bridge();
	  //tx.print(uvm_default_line_printer);
  end
//phase.drop_objection(this);
endtask : run_phase

task ahb_monitor::monitor_bridge();
   if(vif.monitor_cb.HWRITE && vif.monitor_cb.HRESETn)
	get_data();
endtask : monitor_bridge

task ahb_monitor::get_data();
  tx.HWRITE = vif.monitor_cb.HWRITE;
  tx.HWDATA = vif.monitor_cb.HWDATA;
  tx.HADDR = vif.monitor_cb.HADDR;
  transfer();
endtask : get_data

task ahb_monitor::transfer();
  `uvm_info("AHB_MONITOR_ACTIVE",$sformatf("addr = %0d  write data = %0d",tx.HADDR,tx.HWDATA),UVM_MEDIUM);
  monitor_ap.write(tx);
 repeat(4)
	@(vif.monitor_cb);
endtask : transfer