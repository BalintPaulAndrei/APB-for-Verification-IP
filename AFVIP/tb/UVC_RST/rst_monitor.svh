// -----------------------------------------------------------------------------
// Module name: rst_monitor
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Collect signal activity and translate it
// Date       : 28 June 2023
// -----------------------------------------------------------------------------

class rst_monitor extends uvm_monitor;
    `uvm_component_utils (rst_monitor)

    // Declare virtual interface and analysis port
    virtual rst_if vif;
    uvm_analysis_port #(rst_item) mon_analysis_port;
    // Constructor
    function new (string name = "rst_monitor", uvm_component parent = null);
        super.new (name, parent);
    endfunction
//----------------------------------------------------------- build phase ------------------------------------------------
    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        // Create the analysis port for this monitor
        mon_analysis_port = new ("mon_analysis_port", this);
        // Attempt to retrieve the virtual interface from the configuration database
        if (!uvm_config_db #(virtual rst_if) :: get(this, "", "vif", vif)) begin
            `uvm_error (get_type_name (), "DUT interface not found")
        end
    endfunction
//----------------------------------------------------------- run phase --------------------------------------------------
    virtual task run_phase (uvm_phase phase);

        rst_item rst_monitor = rst_item::type_id::create ("rst_monitor", this);
        @(negedge vif.reset)
        rst_monitor.reset = vif.reset;
        `uvm_info("Reset signal", $sformatf ("Saw item: %s", rst_monitor.sprint()), UVM_NONE)

    endtask

endclass : rst_monitor