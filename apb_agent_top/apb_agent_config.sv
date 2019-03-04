class apb_agent_config extends uvm_object;

`uvm_object_utils(apb_agent_config);

virtual apb_if vif;

extern function new(string name="apb_agent_config");

endclass : apb_agent_config

function apb_agent_config::new(string name="apb_agent_config");
  super.new(name);
endfunction
