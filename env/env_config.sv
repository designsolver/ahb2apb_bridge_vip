class env_config extends uvm_object;

`uvm_object_utils(env_config);

  bit has_scoreboard;
  bit has_coverage;

  ahb_agent_config ahb_cfg_h;
  apb_agent_config apb_cfg_h; 

  virtual ahb_if ahb_vif;
  virtual apb_if apb_vif;

function new(string name="env_config");
  super.new(name);
endfunction : new

endclass : env_config
