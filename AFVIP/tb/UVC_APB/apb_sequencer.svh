// -----------------------------------------------------------------------------
// Module name: apb_sequencer
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Generates data transactions and sends them to the driver
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
class apb_sequencer extends uvm_sequencer #(apb_item);
    `uvm_component_utils (apb_sequencer)
    function new (string name = "apb_sequencer", uvm_component parent);
        super.new (name, parent);
    endfunction
endclass