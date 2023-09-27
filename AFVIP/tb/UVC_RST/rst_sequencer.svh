// -----------------------------------------------------------------------------
// Module name: rst_sequencer
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Generates data transactions and sends them to the driver
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
class rst_sequencer extends uvm_sequencer #(rst_item);
    `uvm_component_utils (rst_sequencer)
    function new (string name = "rst_sequencer", uvm_component parent);
        super.new (name, parent);
    endfunction
endclass