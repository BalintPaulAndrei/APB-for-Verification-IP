// -----------------------------------------------------------------------------
// Module name: afvip_test
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Test library
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
class afvip_test extends uvm_test;
    `uvm_component_utils (afvip_test)

    function new (string name = "afvip_test", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    afvip_environment m_environment;
    
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        m_environment = afvip_environment::type_id:: create ("m_environment",  this);
    endfunction
    
    virtual task run_phase (uvm_phase phase);
        
   endtask

endclass : afvip_test

class write_only extends afvip_test;
    `uvm_component_utils (write_only)

    function new (string name = "write_only", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence write_seq;
        rst_check rst_seq;

        write_seq = apb_write_sequence:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        write_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class read_only extends afvip_test;
    `uvm_component_utils (read_only)

    function new (string name = "read_only", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_read_sequence read_seq;
        rst_check rst_seq;

        read_seq = apb_read_sequence:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        read_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class write_read_series_reg extends afvip_test;
    `uvm_component_utils (write_read_series_reg)

    function new (string name = "write_read_series_reg", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence write_seq;
        apb_read_sequence read_seq;
        rst_check rst_seq;
        
        write_seq = apb_write_sequence:: type_id:: create ("item");
        read_seq = apb_read_sequence:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        write_seq.start(m_environment.m_agent.m_sequencer);
        read_seq.start(m_environment.m_agent.m_sequencer);


        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class write_read_parallel_reg extends afvip_test;
    `uvm_component_utils (write_read_parallel_reg)

    function new (string name = "write_read_parallel_reg", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_read_parallel_sequence parallel_seq;
        rst_check rst_seq;

        parallel_seq = apb_write_read_parallel_sequence:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        parallel_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class opcode_0_check extends afvip_test;
    `uvm_component_utils (opcode_0_check)

    function new (string name = "opcode_0_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence_opcode apb_write_sequence_opcode_seq;
        opcode_0 opcode_0_seq;
        reg_84 reg_84_seq;
        reg_88 reg_88_seq;
        reg_8c reg_8c_seq;
        apb_read_dst apb_read_dst_seq;
        rst_check rst_seq;

        apb_write_sequence_opcode_seq = apb_write_sequence_opcode:: type_id:: create ("item");
        opcode_0_seq = opcode_0:: type_id:: create ("item");
        reg_84_seq = reg_84:: type_id:: create ("item");
        reg_88_seq = reg_88:: type_id:: create ("item");
        reg_8c_seq = reg_8c:: type_id:: create ("item");
        apb_read_dst_seq = apb_read_dst:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_sequence_opcode_seq.start(m_environment.m_agent.m_sequencer);
        opcode_0_seq.start(m_environment.m_agent.m_sequencer);
        reg_8c_seq.start(m_environment.m_agent.m_sequencer);
        reg_84_seq.start(m_environment.m_agent.m_sequencer);
        reg_88_seq.start(m_environment.m_agent.m_sequencer);
        
        apb_read_dst_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class opcode_1_check extends afvip_test;
    `uvm_component_utils (opcode_1_check)

    function new (string name = "opcode_1_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence_opcode apb_write_sequence_opcode_seq;
        opcode_1 opcode_1_seq;
        reg_84 reg_84_seq;
        reg_88 reg_88_seq;
        reg_8c reg_8c_seq;
        apb_read_dst apb_read_dst_seq;
        rst_check rst_seq;

        apb_write_sequence_opcode_seq = apb_write_sequence_opcode:: type_id:: create ("item");
        opcode_1_seq = opcode_1:: type_id:: create ("item");
        reg_84_seq = reg_84:: type_id:: create ("item");
        reg_88_seq = reg_88:: type_id:: create ("item");
        reg_8c_seq = reg_8c:: type_id:: create ("item");
        apb_read_dst_seq = apb_read_dst:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_sequence_opcode_seq.start(m_environment.m_agent.m_sequencer);
        opcode_1_seq.start(m_environment.m_agent.m_sequencer);
        reg_8c_seq.start(m_environment.m_agent.m_sequencer);
        reg_84_seq.start(m_environment.m_agent.m_sequencer);
        reg_88_seq.start(m_environment.m_agent.m_sequencer);
        
        apb_read_dst_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class opcode_2_check extends afvip_test;
    `uvm_component_utils (opcode_2_check)

    function new (string name = "opcode_2_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence_opcode apb_write_sequence_opcode_seq;
        opcode_2 opcode_2_seq;
        reg_84 reg_84_seq;
        reg_88 reg_88_seq;
        reg_8c reg_8c_seq;
        apb_read_dst apb_read_dst_seq;
        rst_check rst_seq;

        apb_write_sequence_opcode_seq = apb_write_sequence_opcode:: type_id:: create ("item");
        opcode_2_seq = opcode_2:: type_id:: create ("item");
        reg_84_seq = reg_84:: type_id:: create ("item");
        reg_88_seq = reg_88:: type_id:: create ("item");
        reg_8c_seq = reg_8c:: type_id:: create ("item");
        apb_read_dst_seq = apb_read_dst:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_sequence_opcode_seq.start(m_environment.m_agent.m_sequencer);
        opcode_2_seq.start(m_environment.m_agent.m_sequencer);
        reg_8c_seq.start(m_environment.m_agent.m_sequencer);
        reg_84_seq.start(m_environment.m_agent.m_sequencer);
        reg_88_seq.start(m_environment.m_agent.m_sequencer);
        
        apb_read_dst_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class opcode_3_check extends afvip_test;
    `uvm_component_utils (opcode_3_check)

    function new (string name = "opcode_3_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence_opcode apb_write_sequence_opcode_seq;
        opcode_3 opcode_3_seq;
        reg_84 reg_84_seq;
        reg_88 reg_88_seq;
        reg_8c reg_8c_seq;
        apb_read_dst apb_read_dst_seq;
        rst_check rst_seq;

        apb_write_sequence_opcode_seq = apb_write_sequence_opcode:: type_id:: create ("item");
        opcode_3_seq = opcode_3:: type_id:: create ("item");
        reg_84_seq = reg_84:: type_id:: create ("item");
        reg_88_seq = reg_88:: type_id:: create ("item");
        reg_8c_seq = reg_8c:: type_id:: create ("item");
        apb_read_dst_seq = apb_read_dst:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_sequence_opcode_seq.start(m_environment.m_agent.m_sequencer);
        opcode_3_seq.start(m_environment.m_agent.m_sequencer);
        reg_8c_seq.start(m_environment.m_agent.m_sequencer);
        reg_84_seq.start(m_environment.m_agent.m_sequencer);
        reg_88_seq.start(m_environment.m_agent.m_sequencer);
        
        apb_read_dst_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class opcode_4_check extends afvip_test;
    `uvm_component_utils (opcode_4_check)

    function new (string name = "opcode_4_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence_opcode apb_write_sequence_opcode_seq;
        opcode_4 opcode_4_seq;
        reg_84 reg_84_seq;
        reg_88 reg_88_seq;
        reg_8c reg_8c_seq;
        apb_read_dst apb_read_dst_seq;
        rst_check rst_seq;

        apb_write_sequence_opcode_seq = apb_write_sequence_opcode:: type_id:: create ("item");
        opcode_4_seq = opcode_4:: type_id:: create ("item");
        reg_84_seq = reg_84:: type_id:: create ("item");
        reg_88_seq = reg_88:: type_id:: create ("item");
        reg_8c_seq = reg_8c:: type_id:: create ("item");
        apb_read_dst_seq = apb_read_dst:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_sequence_opcode_seq.start(m_environment.m_agent.m_sequencer);
        opcode_4_seq.start(m_environment.m_agent.m_sequencer);
        reg_8c_seq.start(m_environment.m_agent.m_sequencer);
        reg_84_seq.start(m_environment.m_agent.m_sequencer);
        reg_88_seq.start(m_environment.m_agent.m_sequencer);
        
        apb_read_dst_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class opcode_5_check extends afvip_test;
    `uvm_component_utils (opcode_5_check)

    function new (string name = "opcode_5_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence_opcode apb_write_sequence_opcode_seq;
        opcode_5 opcode_5_seq;
        reg_84 reg_84_seq;
        reg_88 reg_88_seq;
        reg_8c reg_8c_seq;
        apb_read_dst apb_read_dst_seq;
        rst_check rst_seq;

        apb_write_sequence_opcode_seq = apb_write_sequence_opcode:: type_id:: create ("item");
        opcode_5_seq = opcode_5:: type_id:: create ("item");
        reg_84_seq = reg_84:: type_id:: create ("item");
        reg_88_seq = reg_88:: type_id:: create ("item");
        reg_8c_seq = reg_8c:: type_id:: create ("item");
        apb_read_dst_seq = apb_read_dst:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_sequence_opcode_seq.start(m_environment.m_agent.m_sequencer);
        opcode_5_seq.start(m_environment.m_agent.m_sequencer);
        reg_8c_seq.start(m_environment.m_agent.m_sequencer);
        reg_84_seq.start(m_environment.m_agent.m_sequencer);
        reg_88_seq.start(m_environment.m_agent.m_sequencer);
        
        apb_read_dst_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class opcode_6_check extends afvip_test;
    `uvm_component_utils (opcode_6_check)

    function new (string name = "opcode_6_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence_opcode apb_write_sequence_opcode_seq;
        opcode_6 opcode_6_seq;
        reg_84 reg_84_seq;
        reg_88 reg_88_seq;
        reg_8c reg_8c_seq;
        apb_read_dst apb_read_dst_seq;
        rst_check rst_seq;

        apb_write_sequence_opcode_seq = apb_write_sequence_opcode:: type_id:: create ("item");
        opcode_6_seq = opcode_6:: type_id:: create ("item");
        reg_84_seq = reg_84:: type_id:: create ("item");
        reg_88_seq = reg_88:: type_id:: create ("item");
        reg_8c_seq = reg_8c:: type_id:: create ("item");
        apb_read_dst_seq = apb_read_dst:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_sequence_opcode_seq.start(m_environment.m_agent.m_sequencer);
        opcode_6_seq.start(m_environment.m_agent.m_sequencer);
        reg_8c_seq.start(m_environment.m_agent.m_sequencer);
        reg_84_seq.start(m_environment.m_agent.m_sequencer);
        reg_88_seq.start(m_environment.m_agent.m_sequencer);
        
        apb_read_dst_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class opcode_7_check extends afvip_test;
    `uvm_component_utils (opcode_7_check)

    function new (string name = "opcode_7_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence_opcode apb_write_sequence_opcode_seq;
        opcode_7 opcode_7_seq;
        reg_84 reg_84_seq;
        reg_88 reg_88_seq;
        reg_8c reg_8c_seq;
        apb_read_dst apb_read_dst_seq;
        rst_check rst_seq;

        apb_write_sequence_opcode_seq = apb_write_sequence_opcode:: type_id:: create ("item");
        opcode_7_seq = opcode_7:: type_id:: create ("item");
        reg_84_seq = reg_84:: type_id:: create ("item");
        reg_88_seq = reg_88:: type_id:: create ("item");
        reg_8c_seq = reg_8c:: type_id:: create ("item");
        apb_read_dst_seq = apb_read_dst:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_sequence_opcode_seq.start(m_environment.m_agent.m_sequencer);
        opcode_7_seq.start(m_environment.m_agent.m_sequencer);
        reg_8c_seq.start(m_environment.m_agent.m_sequencer);
        reg_84_seq.start(m_environment.m_agent.m_sequencer);
        reg_88_seq.start(m_environment.m_agent.m_sequencer);
        
        apb_read_dst_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class write_only_max extends afvip_test;
    `uvm_component_utils (write_only_max)

    function new (string name = "write_only_max", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_max write_max_seq;
        rst_check rst_seq;

        write_max_seq = apb_write_max:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        write_max_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class read_only_max extends afvip_test;
    `uvm_component_utils (read_only_max)

    function new (string name = "read_only_max", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_read_max read_max_seq;
        rst_check rst_seq;

        read_max_seq = apb_read_max:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        read_max_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class write_only_min extends afvip_test;
    `uvm_component_utils (write_only_min)

    function new (string name = "write_only_min", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_min write_min_seq;
        rst_check rst_seq;

        write_min_seq = apb_write_min:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        write_min_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class read_only_min extends afvip_test;
    `uvm_component_utils (read_only_min)

    function new (string name = "read_only_min", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_read_min read_min_seq;
        rst_check rst_seq;

        read_min_seq = apb_read_min:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        read_min_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass
// Reset after write
class reset_check extends afvip_test;
    `uvm_component_utils (reset_check)

    function new (string name = "reset_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence apb_write_seq;
        apb_read_sequence apb_read_seq;
        rst_check rst_seq;

        apb_write_seq = apb_write_sequence::type_id::create("item");
        apb_read_seq = apb_read_sequence::type_id::create("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_seq.start(m_environment.m_agent.m_sequencer);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_read_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class read_after_reg extends afvip_test;
    `uvm_component_utils (read_after_reg)

    function new (string name = "read_after_reg", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        read_delay read_delay_seq;
        rst_check rst_seq;

        read_delay_seq = read_delay:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        read_delay_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class read_before_reg extends afvip_test;
    `uvm_component_utils (read_before_reg)

    function new (string name = "read_before_reg", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        read_block read_block_seq;
        rst_check rst_seq;

        read_block_seq = read_block:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        read_block_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class read_interval_reg extends afvip_test;
    `uvm_component_utils (read_interval_reg)

    function new (string name = "read_interval_reg", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        read_interval read_interval_seq;
        rst_check rst_seq;

        read_interval_seq = read_interval:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        read_interval_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class read_outer_interval_reg extends afvip_test;
    `uvm_component_utils (read_outer_interval_reg)

    function new (string name = "read_outer_interval_reg", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        read_outer_interval read_outer_interval_seq;
        rst_check rst_seq;

        read_outer_interval_seq = read_outer_interval:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        read_outer_interval_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class addr_multiple_4_check extends afvip_test;
    `uvm_component_utils (addr_multiple_4_check)

    function new (string name = "addr_multiple_4_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        addr_multiple_4 addr_multiple_4_seq;
        rst_check rst_seq;

        addr_multiple_4_seq = addr_multiple_4:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        addr_multiple_4_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class write_read_parallel_succ extends afvip_test;
    `uvm_component_utils (write_read_parallel_succ)

    function new (string name = "write_read_parallel_succ", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_read_parallel apb_parallel_seq;
        rst_check rst_seq;

        apb_parallel_seq = apb_write_read_parallel:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_parallel_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class write_read_parallel_write_read_cov_check extends afvip_test;
    `uvm_component_utils (write_read_parallel_write_read_cov_check)

    function new (string name = "write_read_parallel_write_read_cov_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_read_parallel_write_read_cov apb_write_read_parallel_write_read_cov_seq;
        rst_check rst_seq;

        apb_write_read_parallel_write_read_cov_seq = apb_write_read_parallel_write_read_cov:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_read_parallel_write_read_cov_seq.start(m_environment.m_agent.m_sequencer);

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass

class reg_80_coverage_check extends afvip_test;
    `uvm_component_utils (reg_80_coverage_check)

    function new (string name = "reg_80_coverage_check", uvm_component parent = null);
        super.new (name, parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        apb_write_sequence_opcode apb_write_sequence_opcode_seq;
        reg_80_coverage reg_80_coverage_seq;
        reg_84 reg_84_seq;
        reg_88 reg_88_seq;
        reg_8c reg_8c_seq;
        apb_read_dst apb_read_dst_seq;
        rst_check rst_seq;

        apb_write_sequence_opcode_seq = apb_write_sequence_opcode:: type_id:: create ("item");
        reg_80_coverage_seq = reg_80_coverage:: type_id:: create ("item");
        reg_84_seq = reg_84:: type_id:: create ("item");
        reg_88_seq = reg_88:: type_id:: create ("item");
        reg_8c_seq = reg_8c:: type_id:: create ("item");
        apb_read_dst_seq = apb_read_dst:: type_id:: create ("item");
        rst_seq = rst_check::type_id::create("reset_item");
        
        phase.raise_objection (this);
        
        rst_seq.start(m_environment.reset_agent.reset_sequencer);
        apb_write_sequence_opcode_seq.start(m_environment.m_agent.m_sequencer);
        repeat(500) begin
        reg_80_coverage_seq.start(m_environment.m_agent.m_sequencer);
        reg_8c_seq.start(m_environment.m_agent.m_sequencer);
        reg_84_seq.start(m_environment.m_agent.m_sequencer);
        reg_88_seq.start(m_environment.m_agent.m_sequencer);
        //apb_read_dst_seq.start(m_environment.m_agent.m_sequencer);
        end
        

        //#10ns;
        phase.drop_objection (this);
   endtask
endclass