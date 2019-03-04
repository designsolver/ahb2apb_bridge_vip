class ahb_base_sequence extends uvm_sequence #(ahb_transaction);

`uvm_object_utils(ahb_base_sequence);
 bit [7:0] i;
 bit [15:0] q;

  extern function new(string name="ahb_base_sequence");

endclass : ahb_base_sequence

function ahb_base_sequence::new(string name="ahb_base_sequence");
  super.new(name);
endfunction : new
