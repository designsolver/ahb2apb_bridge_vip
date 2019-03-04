interface ahb_if(input HCLK);
  logic HRESETn;
  logic HWRITE;
  logic [31:0] HWDATA;
  logic [15:0] HADDR;
  logic HRESP;
  logic HREADY;
  logic [31:0] HRDATA;

clocking master_cb @(posedge HCLK);
 // default input #1 output #1;
  output HRESETn,HWRITE,HWDATA,HADDR;
endclocking

clocking monitor_cb @(posedge HCLK);
 // default input #1 output #1;
  input HRESETn,HWRITE,HWDATA,HADDR,HRESP,HREADY,HRDATA;
endclocking

modport master(clocking master_cb);
modport monitor(clocking monitor_cb);

endinterface


