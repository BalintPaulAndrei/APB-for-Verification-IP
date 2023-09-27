// ---------------------------------------------------------------------------------------------------------------------
// Module name: rst_item
// HDL        : System Verilog
// Author     : Balint Paul
// Date       : 28 June, 2023
// ---------------------------------------------------------------------------------------------------------------------

class rst_item extends uvm_sequence_item;

    rand bit reset;       // reset

    `uvm_object_utils_begin (rst_item)
    `uvm_field_int          (reset , UVM_DEFAULT)
    `uvm_object_utils_end


function new (string name = "rst_item");
    super.new(name);
endfunction : new

endclass : rst_item