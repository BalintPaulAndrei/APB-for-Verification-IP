// ---------------------------------------------------------------------------------------------------------------------
// Module name: intr_item
// HDL        : System Verilog
// Author     : Balint Paul
// Date       : 28 June, 2023
// ---------------------------------------------------------------------------------------------------------------------
class intr_item extends uvm_sequence_item;

    rand bit afvip_intr;

    `uvm_object_utils_begin (intr_item)
    `uvm_field_int          (afvip_intr , UVM_DEFAULT)
    `uvm_object_utils_end


function new (string name = "intr_item");
    super.new(name);
endfunction : new

endclass : intr_item