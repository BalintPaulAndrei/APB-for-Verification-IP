// -----------------------------------------------------------------------------
// Module name: intr_agent
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Encapsulates the monitor
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
class intr_agent extends uvm_agent;
    `uvm_component_utils (intr_agent)

    function new (string name = "intr_agent", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    intr_monitor a_monitor;       // Instance of the Intrerupt monitor
//----------------------------------------------------------- build phase --------------------------------------------------
    virtual function void build_phase (uvm_phase phase);
        if(!get_is_active())begin
            // Create the instance
            a_monitor = intr_monitor  :: type_id :: create ("a_monitor",  this);
            `uvm_info (get_name (), "This is the passive interrupt agent.", UVM_MEDIUM);
        end
    endfunction

endclass : intr_agent