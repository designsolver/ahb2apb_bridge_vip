class ahb_agent_active extends uvm_agent;

`uvm_component_utils(ahb_agent_active);

  ahb_sequencer ahb_sequencer_h;  
  ahb_driver ahb_driver_h;
  ahb_monitor ahb_monitor_h;

  uvm_analysis_port #(ahb_transaction) ap;
  
  extern function new(string name="ahb_agent_active",uvm_component parent=null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : ahb_agent_active

function ahb_agent_active::new(string name="ahb_agent_active",uvm_component parent=null);
  super.new(name,parent);
  ap = new("ap",this);
endfunction : new

function void ahb_agent_active::build_phase(uvm_phase phase);
  super.build_phase(phase);
  ahb_sequencer_h = ahb_sequencer::type_id::create("ahb_sequencer_h",this);
  ahb_driver_h = ahb_driver::type_id::create("ahb_driver_h",this);
  ahb_monitor_h = ahb_monitor::type_id::create("ahb_monitor_h",this);
endfunction : build_phase

function void ahb_agent_active::connect_phase(uvm_phase phase);
  ahb_driver_h.seq_item_port.connect(ahb_sequencer_h.seq_item_export);
  ahb_monitor_h.monitor_ap.connect(ap);
endfunction : connect_phase

function void ahb_agent_active::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info("AHB_AGENT/ACTIVE}",{get_full_name()," Created..."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase