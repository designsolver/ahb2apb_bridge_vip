class apb_agent extends uvm_agent;
`uvm_component_utils(apb_agent);

apb_sequencer apb_sequencer_h;
apb_driver apb_driver_h;
apb_monitor apb_monitor_h;
apb_slave apb_slave0_h;
apb_slave apb_slave1_h;
apb_slave apb_slave2_h;
apb_slave apb_slave3_h;

//uvm_analysis_port #(apb_transaction) ap;

extern function new(string name="apb_agent",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : apb_agent

function apb_agent::new(string name="apb_agent",uvm_component parent=null);
  super.new(name,parent);
 // ap = new("ap",this);
endfunction : new

function void apb_agent::build_phase(uvm_phase phase);
 apb_sequencer_h = apb_sequencer::type_id::create("apb_sequencer_h",this);
 apb_driver_h = apb_driver::type_id::create("apb_driver_h",this);
 apb_monitor_h = apb_monitor::type_id::create("apb_monitor_h",this);
 apb_slave0_h = apb_slave::type_id::create("apb_slave0_h",this);
 apb_slave1_h = apb_slave::type_id::create("apb_slave1_h",this);
 apb_slave2_h = apb_slave::type_id::create("apb_slave2_h",this);
 apb_slave3_h = apb_slave::type_id::create("apb_slave3_h",this);
 uvm_config_db #(apb_slave)::set(this,"*","apb_slave0",apb_slave0_h);
 uvm_config_db #(apb_slave)::set(this,"*","apb_slave1",apb_slave1_h);
 uvm_config_db #(apb_slave)::set(this,"*","apb_slave2",apb_slave2_h);
 uvm_config_db #(apb_slave)::set(this,"*","apb_slave3",apb_slave3_h);
endfunction : build_phase

function void apb_agent::connect_phase(uvm_phase phase);
 apb_driver_h.seq_item_port.connect(apb_sequencer_h.seq_item_export);
 //apb_driver_h.ap.connect(ap);
endfunction : connect_phase

function void apb_agent::end_of_elaboration_phase(uvm_phase phase);
 `uvm_info("APB_AGENT",{get_full_name()," Created..."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase
