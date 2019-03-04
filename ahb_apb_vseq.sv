class ahb_apb_vseq extends base_vseq;
`uvm_object_utils(ahb_apb_vseq);

ahb_reset_sequence ahb_reset_seq_h;
ahb_main_sequence ahb_main_seq_h;
ahb_slave0_sequence ahb_slave0_seq_h;
ahb_slave1_sequence ahb_slave1_seq_h;
ahb_slave2_sequence ahb_slave2_seq_h;
ahb_slave3_sequence ahb_slave3_seq_h;
ahb_multi_sequence ahb_multi_seq_h;
apb_sequence apb_sequence_h;


extern function new(string name="ahb_apb_vseq");
extern task body();

endclass : ahb_apb_vseq

function ahb_apb_vseq::new(string name="ahb_apb_vseq");
  super.new(name);
endfunction : new

task ahb_apb_vseq::body();

 ahb_reset_seq_h = ahb_reset_sequence::type_id::create("ahb_reset_seq_h");
 ahb_main_seq_h = ahb_main_sequence::type_id::create("ahb_main_seq_h");
 ahb_slave0_seq_h = ahb_slave0_sequence::type_id::create("ahb_slave0_seq_h");
 ahb_slave1_seq_h = ahb_slave1_sequence::type_id::create("ahb_slave1_seq_h");
 ahb_slave2_seq_h = ahb_slave2_sequence::type_id::create("ahb_slave2_seq_h");
 ahb_slave3_seq_h = ahb_slave3_sequence::type_id::create("ahb_slave3_seq_h");
 ahb_multi_seq_h = ahb_multi_sequence::type_id::create("ahb_multi_sequence");
 apb_sequence_h = apb_sequence::type_id::create("apb_sequence");


  ahb_reset_seq_h.start(ahb_sequencer_h);
  fork
  apb_sequence_h.start(apb_sequencer_h);
  begin
  ahb_slave0_seq_h.start(ahb_sequencer_h);
  ahb_slave1_seq_h.start(ahb_sequencer_h);
  ahb_slave2_seq_h.start(ahb_sequencer_h);
  ahb_slave3_seq_h.start(ahb_sequencer_h);
  ahb_main_seq_h.start(ahb_sequencer_h);
  ahb_multi_seq_h.start(ahb_sequencer_h);
  apb_sequence_h.kill = 1;
  end
  join


endtask : body