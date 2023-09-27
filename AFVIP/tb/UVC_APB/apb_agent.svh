// -----------------------------------------------------------------------------
// Module name: apb_agent
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Encapsulates sequencer, driver and monitor
// Date       : 28 June 2023
// -----------------------------------------------------------------------------

class afvip_agent extends uvm_agent;
    `uvm_component_utils (afvip_agent)

    function new (string name = "afvip_agent", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    apb_driver m_driver;             // Instance of the APB driver
    apb_monitor m_monitor;           // Instance of the APB monitor
    apb_sequencer m_sequencer;       // Instance of the APB sequencer
//----------------------------------------------------------- build phase --------------------------------------------------
    virtual function void build_phase (uvm_phase phase);
        if(get_is_active()) begin    // Check if the agent is active
            // Create instances
            m_sequencer = apb_sequencer :: type_id :: create ("m_sequencer",  this);
            m_driver = apb_driver :: type_id :: create ("m_driver",  this);
        end
        m_monitor = apb_monitor  :: type_id :: create ("m_monitor",  this);
    endfunction
//----------------------------------------------------------- connect phase --------------------------------------------------
    virtual function void connect_phase (uvm_phase phase);
        if(get_is_active()) 
            // Connect the sequencer's sequence item export to the driver's sequence item port
            m_driver.seq_item_port.connect (m_sequencer.seq_item_export);
    endfunction

endclass : afvip_agent