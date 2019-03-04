class base_test extends uvm_test;
`uvm_component_utils(base_test);

env env_h;

bit has_scoreboard;
bit has_vsequencer;
bit has_coverage;

env_config env_cfg_h;

extern function new(string name="base_test",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern function void init_vseq(base_vseq vseq);

endclass : base_test

function base_test::new(string name="base_test",uvm_component parent=null);
  super.new(name,parent);
endfunction : new

function void base_test::build_phase(uvm_phase phase);

  env_cfg_h = env_config::type_id::create("env_cfg_h");

  if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_vif",env_cfg_h.ahb_vif))
	`uvm_fatal("BASE_TEST",{"virtual interface must be set for : ",get_full_name(),".vif"});

  if(!uvm_config_db #(virtual apb_if)::get(this,"","apb_vif",env_cfg_h.apb_vif))
	`uvm_fatal("BASE_TEST",{"virtual interface must be set for : ",get_full_name(),".vif"});

  has_scoreboard = 1;
  has_coverage = 1;

  env_cfg_h.has_scoreboard = has_scoreboard;
  env_cfg_h.has_coverage = has_coverage;

  uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg_h);
  
  env_h = env::type_id::create("env",this);

endfunction : build_phase

function void base_test::end_of_elaboration_phase(uvm_phase phase);
  print();
endfunction : end_of_elaboration_phase

function void base_test::init_vseq(base_vseq vseq);
  vseq.ahb_sequencer_h = env_h.ahb_agent_active_h.ahb_sequencer_h;
  vseq.apb_sequencer_h = env_h.apb_agent_h.apb_sequencer_h;
endfunction : init_vseq