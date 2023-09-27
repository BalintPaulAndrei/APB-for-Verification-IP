// -----------------------------------------------------------------------------
// Module name: apb_sequence
// HDL        : System Verilog
// Author     : Balint Paul
// Description: Tests creating
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
class base_sequence extends uvm_sequence;
    `uvm_object_utils (base_sequence)

    apb_item item;
    function new (string name = "apb_sequence");
        super.new (name);
        item = apb_item::type_id::create("item");
    endfunction
    
    virtual task body();
    endtask
endclass : base_sequence
// Random write only test
class apb_write_sequence extends base_sequence;
    `uvm_object_utils (apb_write_sequence)

    function new (string name = "apb_write_sequence");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        pwdata == i;
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);
        end
    endtask
endclass : apb_write_sequence
// Random read only test
class apb_read_sequence extends base_sequence;
    `uvm_object_utils (apb_read_sequence)

    function new (string name = "apb_read_sequence");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
                start_item(item);
                if(!(item.randomize() with {paddr == i*4; 
                                      pwrite == 0;
                                      delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);
            end
    endtask
endclass : apb_read_sequence
// Write and read random in parallel test
class apb_write_read_parallel_sequence extends base_sequence;
    `uvm_object_utils (apb_write_read_parallel_sequence)

    function new (string name = "apb_write_read_parallel_sequence");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);

            start_item(item);
            item.pwrite = 0;
            finish_item(item);
        end
    endtask
endclass : apb_write_read_parallel_sequence
// Write and read succession in parallel test
class apb_write_read_parallel extends base_sequence;
    `uvm_object_utils (apb_write_read_parallel)

    function new (string name = "apb_write_read_parallel");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        pwdata == i;
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);

            start_item(item);
            item.prdata = i;
            item.pwrite = 0;
            finish_item(item);
        end
    endtask
endclass : apb_write_read_parallel
// Write and read parallel to test coverage and assertions
class apb_write_read_parallel_write_read_cov extends base_sequence;
    `uvm_object_utils (apb_write_read_parallel_write_read_cov)

    function new (string name = "apb_write_read_parallel_write_read_cov");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            item.paddr = i*4;
            item.pwrite = 1;
            if(i< 30) begin
            item.pwdata = 98000000 * i;
            end else begin
            item.pwdata = 1;
            end
            finish_item(item);

            start_item(item);
            item.pwrite = 0;
            finish_item(item);
        end
    endtask
endclass : apb_write_read_parallel_write_read_cov
// Write to test the opcode
class apb_write_sequence_opcode extends base_sequence;
    `uvm_object_utils (apb_write_sequence_opcode)

    function new (string name = "apb_write_sequence_opcode");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4;
                                        pwdata == i;
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);
        end
    endtask
endclass : apb_write_sequence_opcode
// Read for the opcode coverage
class apb_read_dst extends base_sequence;
    `uvm_object_utils (apb_read_dst)

    function new (string name = "apb_read_dst");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            item.paddr = i*4;
            //item.paddr = 16'h30;
            item.pwrite = 0;
            finish_item(item);
        end
    endtask
endclass : apb_read_dst
// Testing when opcede is 0
class opcode_0 extends base_sequence; 
    `uvm_object_utils (opcode_0)

    function new (string name = "opcode_0");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        start_item(item);
            item.paddr = 16'h80;
            item.pwdata [2:0] = 0;      //opcode
            item.pwdata [7:3] = 1;      //RS0
            item.pwdata [12:8] = 2;     //RS1
            item.pwdata [20:16] = 6;   //DST
            item.pwdata [31:24] = 5;    //imm
            item.pwrite = 1;    
            item.delay =1;
        finish_item(item);
    endtask
endclass : opcode_0
// Testing when opcede is 1
class opcode_1 extends base_sequence; 
    `uvm_object_utils (opcode_1)

    function new (string name = "opcode_1");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        start_item(item);
            item.paddr = 16'h80;
            item.pwdata [2:0] = 1;      //opcode
            item.pwdata [7:3] = 2;      //RS0
            item.pwdata [12:8] = 2;     //RS1
            item.pwdata [20:16] = 8;   //DST
            item.pwdata [31:24] = 4;    //imm
            item.pwrite = 1;    
            item.delay =1;
        finish_item(item);
    endtask
endclass : opcode_1
// Testing when opcede is 2
class opcode_2 extends base_sequence; 
    `uvm_object_utils (opcode_2)

    function new (string name = "opcode_2");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        start_item(item);
            item.paddr = 16'h80;
            item.pwdata [2:0] = 2;      //opcode
            item.pwdata [7:3] = 4;      //RS0
            item.pwdata [12:8] = 3;     //RS1
            item.pwdata [20:16] = 7;   //DST
            item.pwdata [31:24] = 2;    //imm
            item.pwrite = 1;    
            item.delay =1;
        finish_item(item);
    endtask
endclass : opcode_2
// Testing when opcede is 3
class opcode_3 extends base_sequence; 
    `uvm_object_utils (opcode_3)

    function new (string name = "opcode_3");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        start_item(item);
            item.paddr = 16'h80;
            item.pwdata [2:0] = 3;      //opcode
            item.pwdata [7:3] = 3;      //RS0
            item.pwdata [12:8] = 3;     //RS1
            item.pwdata [20:16] = 9;   //DST
            item.pwdata [31:24] = 2;    //imm
            item.pwrite = 1;    
            item.delay =1;
        finish_item(item);
    endtask
endclass : opcode_3
// Testing when opcede is 4
class opcode_4 extends base_sequence; 
    `uvm_object_utils (opcode_4)

    function new (string name = "opcode_4");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        start_item(item);
            item.paddr = 16'h80;
            item.pwdata [2:0] = 4;      //opcode
            item.pwdata [7:3] = 2;      //RS0
            item.pwdata [12:8] = 4;     //RS1
            item.pwdata [20:16] = 12;   //DST
            item.pwdata [31:24] = 4;    //imm
            item.pwrite = 1;    
            item.delay =1;
        finish_item(item);
    endtask
endclass : opcode_4
// Testing when opcede is 5
class opcode_5 extends base_sequence; 
    `uvm_object_utils (opcode_5)

    function new (string name = "opcode_5");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        start_item(item);
            item.paddr = 16'h80;
            item.pwdata [2:0] = 5;      //opcode
            item.pwdata [7:3] = 2;      //RS0
            item.pwdata [12:8] = 2;     //RS1
            item.pwdata [20:16] = 12;   //DST
            item.pwdata [31:24] = 2;    //imm
            item.pwrite = 1;    
            item.delay =1;
        finish_item(item);
    endtask
endclass : opcode_5
// Testing when opcede is 6
class opcode_6 extends base_sequence; 
    `uvm_object_utils (opcode_6)

    function new (string name = "opcode_6");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        start_item(item);
            item.paddr = 16'h80;
            item.pwdata [2:0] = 6;      //opcode
            item.pwdata [7:3] = 2;      //RS0
            item.pwdata [12:8] = 2;     //RS1
            item.pwdata [20:16] = 12;   //DST
            item.pwdata [31:24] = 2;    //imm
            item.pwrite = 1;    
            item.delay =1;
        finish_item(item);
    endtask
endclass : opcode_6
// Testing when opcede is 7
class opcode_7 extends base_sequence; 
    `uvm_object_utils (opcode_7)

    function new (string name = "opcode_7");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        start_item(item);
            item.paddr = 16'h80;
            item.pwdata [2:0] = 7;      //opcode
            item.pwdata [7:3] = 2;      //RS0
            item.pwdata [12:8] = 2;     //RS1
            item.pwdata [20:16] = 12;   //DST
            item.pwdata [31:24] = 2;    //imm
            item.pwrite = 1;    
            item.delay =1;
        finish_item(item);
    endtask
endclass : opcode_7
// Testing the 84 register
class reg_84 extends base_sequence; 
    `uvm_object_utils (reg_84)

    function new (string name = "reg_84");
        super.new (name);
    endfunction

    virtual task body();
        start_item(item);
        item.paddr = 16'h84;
        item.pwrite = 0;
        item.delay =1;
        finish_item(item);
    endtask
endclass : reg_84
// Testing the 88 register
class reg_88 extends base_sequence; 
    `uvm_object_utils (reg_88)

    function new (string name = "reg_88");
        super.new (name);
    endfunction

    virtual task body();
        start_item(item);
        item.paddr = 16'h88;
        item.pwrite = 1;
        item.pwdata = 2;
        item.delay =1;
        finish_item(item);
    endtask
endclass : reg_88
// Testing the 8c register
class reg_8c extends base_sequence; 
    `uvm_object_utils (reg_8c)

    function new (string name = "reg_8c");
        super.new (name);
    endfunction

    virtual task body();
        start_item(item);
        item.paddr = 16'h8c;
        item.pwrite = 1;
        item.pwdata = 1;
        item.delay =1;
        finish_item(item);
    endtask
endclass : reg_8c
// Testing if the pwdata accept max value
class apb_write_max extends base_sequence;
    `uvm_object_utils (apb_write_max)

    function new (string name = "apb_write_max");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        pwdata == 'hFFFFFFFF;
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);
        end
    endtask
endclass : apb_write_max
// Testing if the prdata accept max value
class apb_read_max extends base_sequence;
    `uvm_object_utils (apb_read_max)

    function new (string name = "apb_read_max");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        prdata == 'hFFFFFFFF;
                                        pwrite == 0;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);
        end
    endtask
endclass : apb_read_max
// Testing if the pwdata accept min value
class apb_write_min extends base_sequence;
    `uvm_object_utils (apb_write_min)

    function new (string name = "apb_write_min");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        pwdata == 0;
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);
        end
    endtask
endclass : apb_write_min
// Testing if the prdata accept min value
class apb_read_min extends base_sequence;
    `uvm_object_utils (apb_read_min)

    function new (string name = "apb_read_min");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        prdata == 0;
                                        pwrite == 0;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);
        end
    endtask
endclass : apb_read_min
// Testing the protocol after reset (reset after write)
class reset_reg8 extends base_sequence; 
    `uvm_object_utils (reset_reg8)

    function new (string name = "reset_reg8");
        super.new (name);
    endfunction

    virtual task body();
        start_item(item);
        item.paddr = 16'h8;
        finish_item(item);
    endtask
endclass : reset_reg8
// Read after register 10
class read_delay extends base_sequence;
    `uvm_object_utils (read_delay)

    function new (string name = "read_delay");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);

            if(i > 10) begin
                start_item(item);
                item.paddr = i*4;
                item.pwrite = 0;
                finish_item(item);
            end
        end
    endtask
endclass : read_delay
// Read until register 10
class read_block extends base_sequence;
    `uvm_object_utils (read_block)

    function new (string name = "read_block");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);

            if(i < 10) begin
                start_item(item);
                item.paddr = i*4;
                item.pwrite = 0;
                finish_item(item);
            end
        end
    endtask
endclass : read_block
// Read between register 10 and 21
class read_interval extends base_sequence;
    `uvm_object_utils (read_interval)

    function new (string name = "read_interval");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);

            if(i > 10 && i < 21) begin
                start_item(item);
                item.paddr = i*4;
                item.pwrite = 0;
                finish_item(item);
            end
        end
    endtask
endclass : read_interval
// Read until register 10 and after 21
class read_outer_interval extends base_sequence;
    `uvm_object_utils (read_outer_interval)

    function new (string name = "read_outer_interval");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*4; 
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);

            if(i < 10 && i > 21) begin
                start_item(item);
                item.paddr = i*4;
                item.pwrite = 0;
                finish_item(item);
            end
        end
    endtask
endclass : read_outer_interval
// Check if the addr regs are multiple of 4
class addr_multiple_4 extends base_sequence;
    `uvm_object_utils (addr_multiple_4)

    function new (string name = "addr_multiple_4");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
        for(int i = 0; i < 32; i++) begin
            start_item(item);
            if(!(item.randomize() with {paddr == i*3; 
                                        pwrite == 1;
                                        delay inside {[0:5]};}))
            `uvm_error(get_type_name(), "Rand error!")
            finish_item(item);

            start_item(item);
            item.pwrite = 0;
            finish_item(item);
        end
    endtask
endclass : addr_multiple_4
// Coverage for the opcede
class reg_80_coverage extends base_sequence;
    `uvm_object_utils (reg_80_coverage)

    function new (string name = "reg_80_coverage");
        super.new (name);
    endfunction

    virtual task body();
        apb_item item;
        item = apb_item::type_id:: create("item");
            start_item(item);
            if(!(item.randomize() with {
                                        pwdata [2:0] inside {[0:4]};      //opcode
                                        pwdata [7:3] inside {[0:31]};      //RS0
                                        pwdata [12:8] inside {[0:31]};     //RS1
                                        pwdata [20:16] inside {[0:31]};    //DST
                                        pwdata [31:24] inside {[0:255]};    //imm
                                        pwdata [15:13] == 0;
                                        pwdata [23:21] == 0;
                                        paddr == 'h80;   
                                        delay inside {[0:5]};
                                        pwrite == 1; }));
            finish_item(item);
    endtask
endclass : reg_80_coverage

