// -----------------------------------------------------------------------------
// Module name: intr_monitor
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Collect signal activity and translate it
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
class intr_monitor extends uvm_monitor;
    `uvm_component_utils (intr_monitor)

    // Declare virtual interface and analysis port
    virtual intr_if vif;
    uvm_analysis_port #(intr_item) mon_analysis_port;
    
    // Constructor for the apb_monitor class
    function new (string name = "intr_monitor", uvm_component parent = null);
        super.new (name, parent);
    endfunction
//----------------------------------------------------------- build phase ------------------------------------------------
    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);

        // Create the analysis port for this monitor
        mon_analysis_port = new ("mon_analysis_port", this);

        // Attempt to retrieve the virtual interface from the configuration database
        if (!uvm_config_db #(virtual intr_if) :: get(this, "", "vif", vif)) begin
            `uvm_error (get_type_name (), "DUT interface not found")
        end
    endfunction
//----------------------------------------------------------- run phase --------------------------------------------------
    virtual task run_phase (uvm_phase phase);

        intr_item intr_monitor = intr_item::type_id::create ("intr_monitor", this);

    endtask

endclass : intr_monitor