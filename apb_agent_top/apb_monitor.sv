class apb_monitor extends uvm_monitor;
`uvm_component_utils(apb_monitor);

apb_agent_config cfg_h;
virtual apb_if vif;

extern function new(string name="apb_monitor",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task monitor_slave();

endclass : apb_monitor


function apb_monitor::new(string name="apb_monitor",uvm_component parent=null);
  super.new(name,parent);
endfunction : new

function void apb_monitor::build_phase(uvm_phase phase);
  if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",cfg_h))
	`uvm_fatal("APB_MONITOR",{"unable to access configuration object : ",get_full_name(),".cfg"});
endfunction : build_phase

function void apb_monitor::connect_phase(uvm_phase phase);
  vif = cfg_h.vif;
endfunction : connect_phase

function void apb_monitor::end_of_elaboration_phase(uvm_phase phase);
 `uvm_info("APB_MONITOR",{get_full_name()," Created.."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

task apb_monitor::run_phase(uvm_phase phase);

forever
begin
  do
  @(vif.monitor_cb);
  while(vif.monitor_cb.PSELx == 0);
  @(vif.monitor_cb);
  case(vif.monitor_cb.PSELx)
  4'd0 : begin
	`uvm_info("APB_MONITOR","Slave 0 selected",UVM_LOW);
	 end
  4'd1 : begin
	`uvm_info("APB_MONITOR","Slave 1 selected",UVM_LOW);
	 end
  4'd2 : begin
	`uvm_info("APB_MONITOR","Slave 2 selected",UVM_LOW);
	 end
  4'd3 : begin
	`uvm_info("APB_MONITOR","Slave 3 selected",UVM_LOW);
	 end
  endcase
  assert(vif.monitor_cb.PENABLE)   monitor_slave();
  `uvm_error("APB_MONITOR","Protocol error : PENABLE not high after PSEL");

end

endtask : run_phase

task apb_monitor::monitor_slave();
if(vif.monitor_cb.PWRITE)
begin
`uvm_info("APB_MONITOR",$sformatf("Writing data : PWRITE = %0d PWDATA = %0d  PADDR = %0d",vif.monitor_cb.PWRITE,vif.monitor_cb.PWDATA,vif.monitor_cb.PADDR),UVM_MEDIUM);
repeat(3)
@(vif.monitor_cb);
end
else
begin
@(vif.monitor_cb);
`uvm_info("APB_MONITOR",$sformatf("Reading data : PWRITE = %0d PRDATA = %0d  PADDR = %0d",vif.monitor_cb.PWRITE,vif.monitor_cb.PRDATA,vif.monitor_cb.PADDR),UVM_MEDIUM);
end

endtask : monitor_slave