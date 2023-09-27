// -----------------------------------------------------------------------------
// Module name: rst_sequence
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Tests creating
// Date       : 28 June 2023
// -----------------------------------------------------------------------------

class rst_sequence extends uvm_sequence;
    `uvm_object_utils (rst_sequence)

    rst_item reset_item;
    function new (string name = "rst_sequence");
        super.new (name);
        reset_item = rst_item::type_id::create("reset_item");
    endfunction

    virtual task body();
    endtask
endclass
// RESET at the start of the protocol
class rst_check extends rst_sequence;
    `uvm_object_utils (rst_check)

    rst_item reset_item;
    function new (string name = "rst_check");
        super.new (name);  
        reset_item = rst_item::type_id::create("reset_item");
    endfunction

    virtual task body();   

        start_item(reset_item);
        reset_item.reset = 0;
        finish_item(reset_item);
        #25;
        start_item(reset_item);
        reset_item.reset = 1;
        finish_item(reset_item);
    endtask
endclass : rst_check