class base_vseq extends uvm_sequence #(uvm_sequence_item);
`uvm_object_utils(base_vseq);


ahb_sequencer ahb_sequencer_h;
apb_sequencer apb_sequencer_h;


extern function new(string name="base_vseq");

endclass : base_vseq

function base_vseq::new(string name="base_vseq");
  super.new(name);
endfunction : new


