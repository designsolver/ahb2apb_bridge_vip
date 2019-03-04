class apb_sequence extends uvm_sequence #(apb_transaction);
`uvm_object_utils(apb_sequence);

bit kill;
apb_sequencer p_sequencer;
apb_transaction req;
apb_transaction resp;
apb_slave slave0;
apb_slave slave1;
apb_slave slave2;
apb_slave slave3;
apb_slave slave;

extern function new(string name="apb_sequence");
extern function void connect_phase(uvm_phase phase);
extern task pre_body();
extern task body();

endclass : apb_sequence

function apb_sequence::new(string name="apb_sequence");
  super.new(name);
endfunction : new


function void apb_sequence::connect_phase(uvm_phase phase);

endfunction : connect_phase

task apb_sequence::pre_body();
 if(!$cast(p_sequencer,m_sequencer))
	`uvm_fatal("APB_SEQUENCE","Sequencer type mismatch : wrong sequencer");
slave0 = p_sequencer.slave0;
slave1 = p_sequencer.slave1;
slave2 = p_sequencer.slave2;
slave3 = p_sequencer.slave3;
endtask 

task apb_sequence::body();

fork
 forever 
 begin
 req = apb_transaction::type_id::create("req");

 start_item(req);
 finish_item(req);
 case(req.PSELx)
 4'd1 : begin
	`uvm_info("APB_SEQUENCE","Slave 0 Selected",UVM_MEDIUM);
	slave = slave0;
	end
 4'd2 : begin
	`uvm_info("APB_SEQUENCE","Slave 0 Selected",UVM_MEDIUM);
	 slave = slave1;
	end
 4'd4 : begin
	`uvm_info("APB_SEQUENCE","Slave 0 Selected",UVM_MEDIUM);
	 slave = slave2;
	end
 4'd8 : begin
	`uvm_info("APB_SEQUENCE","Slave 0 Selected",UVM_MEDIUM);
	 slave = slave3;
	end
 endcase
 if(req.PWRITE)
begin
slave.load_data(req.PWDATA,req.PADDR,req.PSLVERR);
slave.display_mem();
 end
 $cast(resp,req.clone);
 start_item(resp);
 if(req.PWRITE == 0) 
begin
slave.read_data(resp.PADDR,resp.PRDATA,resp.PSLVERR);
`uvm_info("APB_SEQUENCE",$sformatf("PADDR = %0d   PRDATA = %0d",resp.PADDR,resp.PRDATA),UVM_MEDIUM);
end

 finish_item(resp);
 end

begin
wait(kill);
kill = 0;
end
join_any

disable fork;



endtask : body
