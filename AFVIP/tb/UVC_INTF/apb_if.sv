// -----------------------------------------------------------------------------
// Module name: apb_if
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Encapsulate signals into a block
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
interface apb_if (

    input clk,             // clk
    input rst_n            // rst_n

);

    logic psel;                // psel
    logic penable;             // penable
    logic [15:0] paddr;        // paddr
    logic pwrite;              // pwrite
    logic [31:0] pwdata;       // pwdata
    logic pready;              // pready
    logic [31:0] prdata;       // prdata
    logic pslverr;             // pslverr
    
    import uvm_pkg::*;
    import apb_pkg::*;
    
    clocking cl @(posedge clk);  // clocking block for apb driver
    
        output psel;
        output penable;
        input pready;
        output paddr;
        input prdata;
        output pwrite;
        output pwdata;
        input pslverr;
    
    endclocking
    
    
    clocking monitor_cl @(posedge clk); // clocking block for monitor
    
        input psel;
        input penable;
        input pready;
        input paddr;
        input prdata;
        input pwrite;
        input pwdata;
        input pslverr;
    
    endclocking

endinterface : apb_if