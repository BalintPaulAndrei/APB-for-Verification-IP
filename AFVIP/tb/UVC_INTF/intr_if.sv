// -----------------------------------------------------------------------------
// Module name: intr_if
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Encapsulate signals into a block
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
interface intr_if (
    input clk,        // clk
);

    logic afvip_intr;

    import uvm_pkg::*;
    import intr_pkg::*;


    clocking monitor_cl @(posedge clk);

        input afvip_intr;  // afvip_intr

    endclocking

endinterface : intr_if