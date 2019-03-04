module top;

bit clk;

initial 
 forever 
  #10 clk =~clk;


ahb_if ahb_intf(clk);
apb_if apb_intf(clk);
bridge b(
	.HCLK(clk),
	.HRESETn(ahb_intf.HRESETn),
	.HWRITE(ahb_intf.HWRITE),
	.PSLVERR(apb_intf.PSLVERR),
	.HWDATA(ahb_intf.HWDATA),
	.PRDATA(apb_intf.PRDATA),
	.HADDR(ahb_intf.HADDR),
	.HREP(ahb_intf.HRESP),
	.HREADY(ahb_intf.HREADY),
	.PENABLE(apb_intf.PENABLE),
	.PWRITE(apb_intf.PWRITE),
	.PWDATA(apb_intf.PWDATA),
	.HRDATA(ahb_intf.HRDATA),
	.PADDR(apb_intf.PADDR),
	.PSELx(apb_intf.PSELx)
);


initial
 begin
  uvm_config_db #(virtual ahb_if)::set(null,"uvm_test_top","ahb_vif",ahb_intf);
  uvm_config_db #(virtual apb_if)::set(null,"uvm_test_top","apb_vif",apb_intf);

  run_test("init_vseq_from_test");
 end


endmodule  