class ahb_agent_config extends uvm_object;

`uvm_object_utils(ahb_agent_config);

virtual ahb_if vif;

extern function new(string name="ahb_agent_config");

endclass : ahb_agent_config

function ahb_agent_config::new(string name="ahb_agent_config");
  super.new(name);
endfunction : new