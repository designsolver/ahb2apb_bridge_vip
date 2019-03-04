class apb_sequencer extends uvm_sequencer #(apb_transaction);

apb_slave slave0;
apb_slave slave1;
apb_slave slave2;
apb_slave slave3;

`uvm_component_utils_begin(apb_sequencer)
	`uvm_field_object(slave0,UVM_ALL_ON)
	`uvm_field_object(slave1,UVM_ALL_ON)
	`uvm_field_object(slave2,UVM_ALL_ON)
	`uvm_field_object(slave3,UVM_ALL_ON)
`uvm_component_utils_end


extern function new(string name="apb_sequencer",uvm_component parent=null);
extern function void connect_phase(uvm_phase phase);

endclass : apb_sequencer

function apb_sequencer::new(string name="apb_sequencer",uvm_component parent=null);
  super.new(name,parent);
endfunction : new

function void apb_sequencer::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if(!uvm_config_db #(apb_slave)::get(this,"","apb_slave0",slave0))
	`uvm_fatal("APB_SEQUENCER/NO_SLAVE_0",{get_full_name()," unable to access slave0"});
   if(!uvm_config_db #(apb_slave)::get(this,"","apb_slave1",slave1))
	`uvm_fatal("APB_SEQUENCER/NO_SLAVE_1",{get_full_name()," unable to access slave1"});
   if(!uvm_config_db #(apb_slave)::get(this,"","apb_slave2",slave2))
	`uvm_fatal("APB_SEQUENCER/NO_SLAVE_2",{get_full_name()," unable to access slave2"});
   if(!uvm_config_db #(apb_slave)::get(this,"","apb_slave3",slave3))
	`uvm_fatal("APB_SEQUENCER/NO_SLAVE_3",{get_full_name()," unable to access slave3"});
endfunction : connect_phase