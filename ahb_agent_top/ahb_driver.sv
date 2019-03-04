class ahb_driver extends uvm_driver #(ahb_transaction);

`uvm_component_utils(ahb_driver);

ahb_agent_config cfg;
ahb_transaction tx;
virtual ahb_if vif;

extern function new(string name="ahb_driver",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task drive();
extern task drive_read();
extern task drive_write(input [31:0] HWDATA);

endclass : ahb_driver

function ahb_driver::new(string name="ahb_driver",uvm_component parent=null);
  super.new(name,parent);
endfunction : new

function void ahb_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",cfg))
	`uvm_fatal("AHB driver/NOCONFIG",{"configuration must be set for : ",get_full_name(),".cfg"});
endfunction : build_phase

function void ahb_driver::connect_phase(uvm_phase phase);
  vif = cfg.vif;
endfunction : connect_phase

function void ahb_driver::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info("AHB_DRIVER",{get_full_name()," created.."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

task ahb_driver::run_phase(uvm_phase phase);
//phase.raise_objection(this);
  forever
  begin
//	`uvm_info("AHB_DRIVER","Driving sequence",UVM_MEDIUM);
	seq_item_port.get_next_item(req);
	drive();
	seq_item_port.item_done();
  end
//phase.drop_objection(this);
endtask : run_phase

task ahb_driver::drive();
  @(vif.master_cb);
	vif.master_cb.HRESETn <= req.HRESETn;
	vif.master_cb.HADDR <= req.HADDR;
	case(req.HWRITE)
	  1'b0 : drive_read();
	  1'b1 : drive_write(req.HWDATA);
	endcase
endtask : drive

task ahb_driver::drive_read();
  vif.master_cb.HWRITE <= 1'b0;
  `uvm_info("AHB_DRIVER",$sformatf("addr = %0d  reading",req.HADDR),UVM_MEDIUM);
  repeat(6)
    @(vif.master_cb);
endtask

task ahb_driver::drive_write(input [31:0] HWDATA);
 vif.master_cb.HWRITE <= 1'b1;
 vif.master_cb.HWDATA <= HWDATA;
 `uvm_info("AHB_DRIVER",$sformatf("addr = %0d  write data = %0d",req.HADDR,HWDATA),UVM_MEDIUM);
 repeat(4)
  @(vif.master_cb);
endtask : drive_write
