class env extends uvm_env;
`uvm_component_utils(env);

env_config env_cfg_h;
ahb_agent_config ahb_cfg_h;
apb_agent_config apb_cfg_h;

bit has_scoreboard;
bit has_coverage;

ahb_agent_active ahb_agent_active_h;
ahb_agent_passive ahb_agent_passive_h;
apb_agent apb_agent_h;
scoreboard scoreboard_h;
coverage coverage_h;

extern function new(string name="env",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : env

function env::new(string name="env",uvm_component parent=null);
  super.new(name,parent);
endfunction 

function void env::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg_h))
	`uvm_fatal("ENV","Unable to access env configuration object from database");

  has_scoreboard = env_cfg_h.has_scoreboard;
  has_coverage = env_cfg_h.has_coverage;

  ahb_cfg_h = ahb_agent_config::type_id::create("ahb_cfg_h");
  apb_cfg_h = apb_agent_config::type_id::create("apb_cfg_h");

  ahb_cfg_h.vif = env_cfg_h.ahb_vif;
  apb_cfg_h.vif = env_cfg_h.apb_vif;

  uvm_config_db #(ahb_agent_config)::set(this,"*ahb_agent*","ahb_agent_config",ahb_cfg_h);
  uvm_config_db #(apb_agent_config)::set(this,"*apb_agent*","apb_agent_config",apb_cfg_h);

  ahb_agent_active_h = ahb_agent_active::type_id::create("ahb_agent_acitve_h",this);
  ahb_agent_passive_h = ahb_agent_passive::type_id::create("ahb_agent_passive_h",this);

  apb_agent_h = apb_agent::type_id::create("apb_agent",this);
  
  if(has_scoreboard)
	scoreboard_h = scoreboard::type_id::create("scoreboard_h",this);
  
  if(has_coverage)
	coverage_h = coverage::type_id::create("coverage_h",this);

endfunction : build_phase

function void env::connect_phase(uvm_phase phase);
  if(has_scoreboard)
	begin
	ahb_agent_active_h.ahb_monitor_h.monitor_ap.connect(scoreboard_h.ahb_write_export);
	ahb_agent_passive_h.ahb_monitor_h.monitor_ap.connect(scoreboard_h.ahb_read_export);
	end

  if(has_coverage)
	begin
	ahb_agent_active_h.ahb_monitor_h.monitor_ap.connect(coverage_h.analysis_export);
	ahb_agent_passive_h.ahb_monitor_h.monitor_ap.connect(coverage_h.analysis_export);
	end
	
endfunction : connect_phase

function void env::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("ENV",{get_full_name()," Created... "},UVM_MEDIUM);
endfunction : end_of_elaboration_phase


	