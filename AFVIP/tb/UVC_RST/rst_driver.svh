// -----------------------------------------------------------------------------
// Module name: rst_driver
// HDL        : System Verilog
// Author     : Balint Paul
// Date       : 28 June 2023
// -----------------------------------------------------------------------------

class rst_driver extends uvm_driver #(rst_item);
    `uvm_component_utils (rst_driver)

    virtual rst_if vif;
    rst_item data_item;

    function new (string name = "rst_driver", uvm_component parent = null);
        super.new (name, parent);
    endfunction
//----------------------------------------------------------- build phase ------------------------------------------------
    function void build_phase(uvm_phase phase);

        super.build_phase(phase); // Calling the build phase of the base class
        if(!uvm_config_db #(virtual rst_if) :: get ( this, "", "vif", vif)) begin
            `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface")
    
        end
    endfunction
//----------------------------------------------------------- run phase --------------------------------------------------
    virtual task run_phase (uvm_phase phase);

        forever begin 
            `uvm_info (get_type_name (), $sformatf ("Waiting for data from driver"), UVM_MEDIUM)  // Log information about driver activity
            seq_item_port.get_next_item (req);
            $cast(data_item, req.clone()); // Clone the transaction item for processing
            
            vif.reset <= data_item.reset;
            seq_item_port.item_done();
        end
    endtask
endclass