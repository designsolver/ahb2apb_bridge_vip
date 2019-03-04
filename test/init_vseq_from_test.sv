class init_vseq_from_test extends base_test;
`uvm_component_utils(init_vseq_from_test);

extern function new(string name="init_vseq_from_test",uvm_component parent=null);
extern task run_phase(uvm_phase phase);

endclass : init_vseq_from_test


function init_vseq_from_test::new(string name="init_vseq_from_test",uvm_component parent=null);
  super.new(name,parent);
endfunction : new

task init_vseq_from_test::run_phase(uvm_phase phase);
 ahb_apb_vseq vseq = ahb_apb_vseq::type_id::create("vseq");
 phase.raise_objection(this);
  init_vseq(vseq);
  vseq.start(null);

#300;

 phase.drop_objection(this);
`uvm_info("VSEQ","Ending test..",UVM_MEDIUM);
endtask : run_phase