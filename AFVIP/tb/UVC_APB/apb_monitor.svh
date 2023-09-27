// -----------------------------------------------------------------------------
// Module name: apb_monitor
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Collect signal activity and translate it
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
class apb_monitor extends uvm_monitor;
    `uvm_component_utils (apb_monitor)

    // Declare virtual interface and analysis port
    virtual apb_if vif;
    uvm_analysis_port #(apb_item) mon_analysis_port;
    
    // Constructor for the apb_monitor class
    function new (string name = "apb_monitor", uvm_component parent = null);
        super.new (name, parent);
    endfunction
//----------------------------------------------------------- build phase ------------------------------------------------
    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        // Create the analysis port for this monitor
        mon_analysis_port = new ("mon_analysis_port", this);

        // Attempt to retrieve the virtual interface from the configuration database
        if (!uvm_config_db #(virtual apb_if) :: get(this, "", "vif", vif)) begin
            `uvm_error (get_type_name (), "DUT interface not found")
        end
    endfunction
//----------------------------------------------------------- run phase --------------------------------------------------
    virtual task run_phase (uvm_phase phase);

        // Create an instance of apb_item for monitoring
        apb_item data_monitor = apb_item::type_id::create ("data_monitor", this);
        forever begin
            // Wait for a positive edge of the clock if specific conditions are met
            @(posedge vif.clk iff (vif.monitor_cl.psel & vif.monitor_cl.penable & vif.monitor_cl.pready));
            
            data_monitor.pwrite= vif.monitor_cl.pwrite ;
            if (vif.monitor_cl.pwrite == 1)begin
                data_monitor.paddr      = vif.monitor_cl.paddr;
                data_monitor.pwdata     = vif.monitor_cl.pwdata;
            end else if(vif.monitor_cl.pwrite == 0)begin
                data_monitor.paddr      = vif.monitor_cl.paddr;
                data_monitor.prdata     = vif.monitor_cl.prdata;
            end
            if(vif.monitor_cl.pwrite == 1 && vif.monitor_cl.paddr == 16'h80) begin
                data_monitor.opcode     = vif.monitor_cl.pwdata[2:0];
                data_monitor.rs0        = vif.monitor_cl.pwdata[7:3];
                data_monitor.rs1        = vif.monitor_cl.pwdata[12:8];
                data_monitor.dst        = vif.monitor_cl.pwdata[20:16];
                data_monitor.imm        = vif.monitor_cl.pwdata[31:24];
            end
        
            $display ("%s", data_monitor.sprint());
            mon_analysis_port.write (data_monitor);  // Send the data_monitor object to the analysis port for further processing
            `uvm_info("Monitor", $sformatf ("APB Monitor: %s", data_monitor.sprint()), UVM_NONE)
        end
    endtask
endclass : apb_monitor