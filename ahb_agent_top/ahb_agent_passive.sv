class ahb_agent_passive extends uvm_agent;
`uvm_component_utils(ahb_agent_passive);
 
 uvm_analysis_port #(ahb_transaction) ap;

 ahb_monitor_passive ahb_monitor_h;

extern function new(string name="ahb_agent_passive",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : ahb_agent_passive

function ahb_agent_passive::new(string name="ahb_agent_passive",uvm_component parent=null);
  super.new(name,parent);
  ap = new("ap",this);
endfunction : new

function void ahb_agent_passive::build_phase(uvm_phase phase);
 ahb_monitor_h = ahb_monitor_passive::type_id::create("ahb_monitor_h",this);
endfunction : build_phase

function void ahb_agent_passive::connect_phase(uvm_phase phase);
 ahb_monitor_h.monitor_ap.connect(ap);
endfunction : connect_phase

function void ahb_agent_passive::end_of_elaboration_phase(uvm_phase phase);
 `uvm_info("AHB_AGENT_PASSIVE",{get_full_name()," Created.."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

