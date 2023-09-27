// -----------------------------------------------------------------------------
// Module name: apb_driver
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Implementing the apb protocol
// Date       : 28 June 2023
// -----------------------------------------------------------------------------

class apb_driver extends uvm_driver #(apb_item);
    `uvm_component_utils (apb_driver)

    virtual apb_if vif;
    apb_item data_item;

    function new (string name = "apb_driver", uvm_component parent = null);
        super.new (name, parent);
    endfunction
//----------------------------------------------------------- build phase ------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);  // Calling the build phase of the base class
        if(!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface")  // Display an error message if the virtual interface isn't configured
        end
    endfunction
//----------------------------------------------------------- run phase --------------------------------------------------
    virtual task run_phase (uvm_phase phase);

        vif.cl.psel         <= 0;
        vif.cl.penable      <= 0;
        vif.cl.pwrite       <= 0;
        vif.cl.paddr        <= 0;
        vif.cl.pwdata       <= 0;

        @(posedge vif.rst_n);  
        @(vif.cl);
        forever begin 
            `uvm_info (get_type_name (), $sformatf ("Driver data show:"), UVM_MEDIUM)  // Log information about driver activity
            seq_item_port.get_next_item (req);
            $cast(data_item, req.clone());  // Clone the transaction item for processing

            vif.cl.psel <= 0;
            repeat(data_item.delay) @(vif.cl);
            vif.cl.psel <= 1;

            if(vif.rst_n == 0)
                reset(data_item);
            else begin
                if (data_item.pwrite)
                    write (data_item);
                else begin
                    read (data_item);
                end
            end
            seq_item_port.item_done();
        end
    endtask
//----------------------------------------------------------- read task --------------------------------------------------
    task  read (apb_item item);

        vif.cl.paddr    <= item.paddr;
        vif.cl.pwrite   <= 0;
        vif.cl.psel     <= 1;
        @(vif.cl); //delay 1 tact
        vif.cl.penable  <= 1;
        @(posedge vif.clk iff vif.cl.pready);  // Wait for a clock edge when the interface is ready
        vif.cl.penable  <= 0;
        vif.cl.psel     <= 0;

    endtask 
//----------------------------------------------------------- write task --------------------------------------------------
    task  write (apb_item item);

        vif.cl.paddr    <= item.paddr;
        vif.cl.pwdata   <= item.pwdata;
        vif.cl.pwrite   <= 1;
        vif.cl.psel     <= 1;
        @(vif.cl); //delay 1 tact
        vif.cl.penable  <= 1;
        @(posedge vif.clk iff vif.cl.pready);                
        vif.cl.penable  <= 0;
        vif.cl.psel     <= 0;

    endtask 
//----------------------------------------------------------- reset task --------------------------------------------------
    task reset (apb_item item);
        vif.cl.psel     <= 0;
        vif.cl.penable  <= 0;
        vif.cl.pwrite   <= 0;
        vif.cl.paddr    <= 0;
        vif.cl.pwdata   <= 0;
    endtask

endclass : apb_driver