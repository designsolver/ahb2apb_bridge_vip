`uvm_analysis_imp_decl(_WRITE);
`uvm_analysis_imp_decl(_READ);
class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard);

env_config cfg;
bit [7:0] pass,fail;

 uvm_analysis_imp_WRITE #(ahb_transaction,scoreboard) ahb_write_export;
 uvm_analysis_imp_READ #(ahb_transaction,scoreboard) ahb_read_export;

 bit [15:0] addr_write[$];
 bit [15:0] addr_read[$];
 bit [31:0] data_write[$];
 bit [31:0] data_read[$];

extern function new(string name="scoreboard",uvm_component parent=null);
extern function void build_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern function void write_WRITE(ahb_transaction tx);
extern function void write_READ(ahb_transaction tx);
extern function void extract_phase(uvm_phase phase);

endclass : scoreboard

function scoreboard::new(string name="scoreboard",uvm_component parent=null);
  super.new(name,parent);
  ahb_write_export = new("ahb_write_export",this);
  ahb_read_export = new("ahb_read_export",this);
endfunction : new

function void scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
	`uvm_fatal("SCOREBOARD","Unable to access Configuration Object from env");
endfunction : build_phase

function void scoreboard::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info("SCOREBOARD",{get_full_name()," Created..."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

function void scoreboard::write_WRITE(ahb_transaction tx);
 if(tx.HWRITE)
 begin
	addr_write.push_back(tx.HADDR);
	data_write.push_back(tx.HWDATA);
 end
endfunction : write_WRITE

function void scoreboard::write_READ(ahb_transaction tx);
 if(!tx.HWRITE)
 begin
	addr_read.push_back(tx.HADDR);
	data_read.push_back(tx.HRDATA);
 end
endfunction : write_READ

function void scoreboard::extract_phase(uvm_phase phase);
phase.raise_objection(this);
  repeat(addr_write.size())
  begin
   int ar,aw,dr,dw;
	ar = addr_read.pop_front();
	aw = addr_write.pop_front();
	dr = data_read.pop_front();
	dw = data_write.pop_front();

     if({ar,dr} == {aw,dw})
	begin
	`uvm_info("SCOREBOARD",{get_type_name()," Transaction matches"},UVM_MEDIUM);
	pass++;
	end
     else 
	begin
	`uvm_info("SCOREBOARD",{get_type_name(),$sformatf(" Transaction failed { read_addr = %0d, read_data = %0d, write_addr = %0d, write_data = %0d",ar,dr,aw,dw)},UVM_MEDIUM);
	fail++;
  	end
  end
 `uvm_info("SCOREBOARD",$sformatf("Results { PASS : %0d  FAIL : %0d }",pass,fail),UVM_HIGH);
phase.drop_objection(this);
endfunction : extract_phase


	 
  