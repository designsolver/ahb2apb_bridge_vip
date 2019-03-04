class coverage extends uvm_subscriber #(ahb_transaction);
`uvm_component_utils(coverage);
event cov_e;
ahb_transaction tx;

covergroup ahb_cg @(cov_e);
ahb_addr_cp : coverpoint tx.HADDR;
ahb_write_data_cp : coverpoint tx.HWDATA;
ahb_read_data_cp : coverpoint tx.HRDATA;
endgroup

extern function new(string name="coverage",uvm_component parent=null);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern function void write(ahb_transaction t);

endclass : coverage

function coverage::new(string name="coverage",uvm_component parent=null);
  super.new(name,parent);
  ahb_cg = new();
endfunction : new

function void coverage::end_of_elaboration_phase(uvm_phase phase);
  `uvm_info("COVERAGE",{get_full_name()," Created..."},UVM_MEDIUM);
endfunction : end_of_elaboration_phase

function void coverage::write(ahb_transaction t);
  tx = t;
  ahb_cg.sample();
endfunction : write

