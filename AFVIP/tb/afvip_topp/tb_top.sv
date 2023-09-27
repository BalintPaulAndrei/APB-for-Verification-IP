module tb_top;
    `include "uvm_macros.svh"

    import uvm_pkg::*;
    import apb_pkg::*;
    import intr_pkg::*;
    import rst_pkg::*;
    import afvip_tb_pkg::*;
    import afvip_test_pkg::*;
    

bit clk;
bit rst_n;
bit pready;
bit psel;
bit penable;
bit pwrite;
bit [15:0] paddr;
bit [31:0] prdata;
bit [31:0] pwdata;
bit pslverr;
bit afvip_intr;


apb_if interf(
    .clk(clk),
    .rst_n(rst_n)
);

intr_if intr_interf(
    .clk(clk),
    .rst_n(rst_n)
);

rst_if rst_interf();

afvip_top #(.TP(0)) DUT (
    .clk(clk),
    .rst_n(rst_n),
    .psel(psel),
    .penable(penable),
    .pready(pready),
    .paddr(paddr),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .prdata(prdata),
    .pslverr(pslverr),
    .afvip_intr(afvip_intr)
);

initial begin

    forever begin
        #10;
        clk = !clk;
    end
end

// initial begin
//     rst_n = 1;
//     #15;
//     rst_n = 0;
//     #25;
//     rst_n = 1;
// end



initial begin
    uvm_config_db #(virtual apb_if) :: set (uvm_root :: get(), "*", "vif", interf);
    uvm_config_db #(virtual intr_if) :: set (uvm_root :: get(), "*", "vif", intr_interf);
    uvm_config_db #(virtual rst_if) :: set (uvm_root :: get(), "*", "vif", rst_interf);
    run_test("reg_80_coverage_check");
end

assign psel = interf.psel;
assign penable = interf.penable;
assign interf.pready = pready;
assign paddr = interf.paddr;
assign interf.prdata = prdata;
assign pwrite = interf.pwrite;
assign pwdata = interf.pwdata;
assign interf.pslverr = pslverr;
assign intr_interf.afvip_intr = afvip_intr;
assign rst_n = rst_interf.reset;

`include "afvip_coverage.svh"
`include "afvip_assertions.svh"


endmodule : tb_top