// -----------------------------------------------------------------------------
// Module name: afvip_environment
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Defines the default configuration of the components
// Date       : 28 June 2023
// -----------------------------------------------------------------------------

class afvip_environment extends uvm_env;
    `uvm_component_utils (afvip_environment)

    function new (string name = "afvip_environment", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    afvip_agent m_agent;                    // Instance of the APB agent
    intr_agent interrupt_agent;             // Instance of the intrerupt agent
    rst_agent reset_agent;                  // Instance of the reset agent
    afvip_scoreboard scoreboard_handle;     // Handle for scoreboard
    afvip_coverage coverage_handle;         // Handle for coverage
//----------------------------------------------------------- build phase --------------------------------------------------
    virtual function void build_phase(uvm_phase phase);
        super.build_phase (phase); // invoke the build phase
        // Create instances
        m_agent = afvip_agent  :: type_id :: create ("m_agent",  this);
        interrupt_agent = intr_agent  :: type_id :: create ("interrupt_agent",  this);
        interrupt_agent.is_active = UVM_PASSIVE; // set the interrupt to passive
        reset_agent = rst_agent  :: type_id :: create ("reset_agent",  this);
        scoreboard_handle = afvip_scoreboard  :: type_id :: create ("scoreboard_handle",  this);
        coverage_handle = afvip_coverage :: type_id :: create("coverage_handle",this);
    endfunction
//----------------------------------------------------------- connect phase --------------------------------------------------
    virtual function  void connect_phase (uvm_phase phase);
        super.connect_phase (phase);
        m_agent.m_monitor.mon_analysis_port.connect (coverage_handle.analysis_export);
        m_agent.m_monitor.mon_analysis_port.connect (scoreboard_handle.ap_imp);
        interrupt_agent.a_monitor.mon_analysis_port.connect (scoreboard_handle.ap_imp_intr);
        reset_agent.reset_monitor.mon_analysis_port.connect (scoreboard_handle.ap_imp_rst);
    endfunction

endclass : afvip_environment