interface apb_if(input bit PCLK);
 wire PRESETn;
 wire [3:0]PSELx;
 wire PENABLE;
 wire PWRITE;
 wire [15:0] PADDR;
 wire [31:0] PWDATA;
 logic [31:0] PRDATA;
 wire PSLVERR;

clocking master_cb@(posedge PCLK);
input PSELx,PENABLE,PWRITE,PADDR,PWDATA;
output PSLVERR,PRDATA;
endclocking

clocking monitor_cb@(PCLK);
input PSELx,PENABLE,PWRITE,PADDR,PWDATA,PSLVERR,PRDATA;
endclocking

modport master(clocking master_cb);
modport monitor(clocking monitor_cb);

endinterface 