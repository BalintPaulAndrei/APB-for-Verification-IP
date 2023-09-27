// ---------------------------------------------------------------------------------------------------------------------
// Module name: apb_item
// HDL        : System Verilog
// Author     : Balint Paul
// Date       : 28 June, 2023
// ---------------------------------------------------------------------------------------------------------------------
class apb_item extends uvm_sequence_item;
//--------------Ports List -------------
    rand int        delay;
    rand bit [15:0] paddr;     // paddr
    rand bit [31:0] pwdata;    // pwdata
    rand bit [31:0] prdata;    // prdata
    rand bit psel;             // psel
    rand bit penable;          // penable
    rand bit pwrite;           // pwrite
    rand bit pslverr;          // pslverr
    rand bit check;            // check
    rand bit [2:0]  opcode;    // opcode
    rand bit [4:0]  rs0;       // rs0
    rand bit [4:0]  rs1;       // rs1
    rand bit [4:0]  dst;       // dst
    rand bit [7:0]  imm;       // imm

// instantiate the signals so they can be used by uvm
    `uvm_object_utils_begin     (apb_item)
    `uvm_field_int              (delay, UVM_DEFAULT)
    `uvm_field_int              (psel , UVM_DEFAULT)
    `uvm_field_int              (penable , UVM_DEFAULT)
    `uvm_field_int              (paddr , UVM_DEFAULT)
    `uvm_field_int              (pwdata , UVM_DEFAULT)
    `uvm_field_int              (prdata , UVM_DEFAULT)
    `uvm_field_int              (pwrite , UVM_DEFAULT)
    `uvm_field_int              (check , UVM_DEFAULT)
    `uvm_field_int              (opcode , UVM_DEFAULT)
    `uvm_field_int              (rs0 , UVM_DEFAULT)
    `uvm_field_int              (rs1 , UVM_DEFAULT)
    `uvm_field_int              (dst , UVM_DEFAULT)
    `uvm_field_int              (imm , UVM_DEFAULT)
    `uvm_object_utils_end


    function new (string name = "apb_item");
        super.new(name);
    endfunction : new

endclass : apb_item