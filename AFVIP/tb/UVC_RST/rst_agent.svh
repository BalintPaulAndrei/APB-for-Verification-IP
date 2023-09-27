// -----------------------------------------------------------------------------
// Module name: rst_agent
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Encapsulates sequencer, driver and monitor
// Date       : 28 June 2023
// -----------------------------------------------------------------------------

class rst_agent extends uvm_agent;
    `uvm_component_utils (rst_agent)

    function new (string name = "rst_agent", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    rst_driver reset_driver;                // Instance of the Reset driver
    rst_monitor reset_monitor;              // Instance of the Reset monitor
    rst_sequencer reset_sequencer;          // Instance of the Reset sequencer
//----------------------------------------------------------- build phase --------------------------------------------------
    virtual function void build_phase (uvm_phase phase);
        if(get_is_active()) begin
            // Create instances
            reset_sequencer = rst_sequencer :: type_id :: create ("reset_sequencer",  this);
            reset_driver = rst_driver :: type_id :: create ("reset_driver",  this);
        end
        reset_monitor = rst_monitor  :: type_id :: create ("reset_monitor",  this);
    endfunction
//----------------------------------------------------------- connect phase --------------------------------------------------
    virtual function void connect_phase (uvm_phase phase);
        if(get_is_active())
            reset_driver.seq_item_port.connect (reset_sequencer.seq_item_export);
    endfunction

endclass : rst_agent