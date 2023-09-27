class afvip_scoreboard extends uvm_scoreboard;
    `uvm_component_utils (afvip_scoreboard)
    // call the ports
    `uvm_analysis_imp_decl(_apb_port)
    `uvm_analysis_imp_decl(_intr_port)
    `uvm_analysis_imp_decl(_rst_port)

    // instantiation
    uvm_analysis_imp_apb_port #(apb_item, afvip_scoreboard) ap_imp;
    uvm_analysis_imp_intr_port #(intr_item, afvip_scoreboard) ap_imp_intr;
    uvm_analysis_imp_rst_port #(rst_item, afvip_scoreboard) ap_imp_rst;


    function new (string name, uvm_component parent);
        super.new (name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        ap_imp = new ("ap_imp", this);
        ap_imp_intr = new ("ap_imp_intr", this);
        ap_imp_rst = new ("ap_imp_rst", this);
    endfunction
    bit [31:0] mem[32];
    bit [2:0] OPCODE;
    bit [4:0] RS0;
    bit [4:0] RS1;
    bit [4:0] DST;
    bit [7:0] IMM;
    bit [31:0] instruction_reg;
    bit [31:0] config_reg_addr;
    bit [31:0] instruction_aux;

    virtual function  void write_apb_port (apb_item item);

//-------------------------------------------adresa multiplu de 4------------------------------------------------------------
        if(item.paddr [1:0] !=0) begin
            `uvm_error(get_type_name(), $sformatf ("adresa nu este multiplu de 4!"))
        //`uvm_info ("\nApb_Scoreboard: ",$sformatf("\nAPB Scoreboard data : %s", item.sprint()), UVM_NONE)
        end
//-------------------------------------------test scriere reg------------------------------------------------------------
        if(item.paddr < 'h80) begin
            if(item.pwrite == 1) begin
                $display("Adresa = %d", item.paddr );
                $display("Pwrite = %d", item.pwrite );
                $display("Pwdata = %d", item.pwdata);
                mem[(item.paddr/4)] = item.pwdata;
                if(item.pwdata !=  mem[item.paddr/4]) begin
                    `uvm_error(get_type_name(), $sformatf ("Adresele scrise nu corespund"));
                    $display("prdata = %d", item.pwdata, "  should be = %d", mem[item.paddr/4]);
                end
                else begin
                $display("Adresele scrise corespund");
                $display("pwdata = %d", item.pwdata, "  is at  mem[%d] = %d",item.paddr/4, mem[item.paddr/4]);
                end
            end
            else 

//-------------------------------------------test citire reg------------------------------------------------------------
            if(item.pwrite == 0) begin
                if(mem[item.paddr/4] != item.prdata  ) begin
                `uvm_error(get_type_name(), $sformatf ("Adresele afisate nu corespund"));
                $display("prdata = %d", item.prdata, "  should be = %d", mem[item.paddr/4]);
                end
                else begin
                $display("Adresele citite corespund");
                $display("prdata = %d", item.prdata, "  is = %d", mem[item.paddr/4]);
                end
            end
        end
        for(int i =0;i<=item.paddr/4;i++)begin
            `uvm_info (get_type_name(), $sformatf("After the virtual memory we have at mem[%d] = %d", i, mem[i]), UVM_LOW)
        end
//------------------------------------------------opcode----------------------------------------------------------------
        if(item.paddr == 16'h80 ) begin
        instruction_reg = item.pwdata;

            OPCODE = instruction_reg [2:0];
            RS0 = instruction_reg [7:3];
            RS1 = instruction_reg [12:8];
            DST = instruction_reg [20:16];
            IMM = instruction_reg [31:24];

            if(OPCODE == 'd0) begin
                mem[DST] = mem[RS0] + IMM;
            end 
            else if(OPCODE == 'd1) begin
                mem[DST] = mem[RS0] * IMM;
            end
            else if(OPCODE == 'd2) begin
                mem[DST] = mem[RS0] + mem[RS1];
            end
            else if(OPCODE == 'd3) begin
                mem[DST] = mem[RS0] * mem[RS1];
            end
            else if(OPCODE == 'd4) begin
                mem[DST] = mem[RS0] * mem[RS1] + IMM;
            end

            `uvm_info("\nFields", $sformatf("\n
                    OPCODE %d | OPCODE dut %d
                    RS0 %d | RS0 dut %d
                    RS1 %d | RS1 dut %d
                    DST %d | DST dut %d
                    IMM %d | IMM dut %d"
                    ,OPCODE, item.opcode, RS0, item.rs0,
                    RS1, item.rs1, mem[DST], item.dst,
                    IMM, item.imm), UVM_LOW)


            if(OPCODE > 'd4) begin
                `uvm_error (get_type_name(), $sformatf("Format not supported"))
            end
        
            if(item.paddr [15:13] != 0) begin
                `uvm_info (get_type_name(), $sformatf("Expected 0 in [15:13] range"), UVM_LOW)
            end
            if(item.paddr [23:21] != 0) begin
                `uvm_info (get_type_name(), $sformatf("Expected 0 in [23:21] range"), UVM_LOW)
            end
        end
        //------------------------------------------addr_size----------------------------------------------------------------
        if(item.paddr > 16'h8c) begin
            `uvm_error(get_type_name(), $sformatf ("Address exceeds 16 bits"));
        end else begin
            $display("paddr is 16 bits wide");
        end
    endfunction




    virtual function  void write_intr_port (intr_item item_intr);
        $display("s%", item_intr.sprint);
    endfunction

    virtual function  void write_rst_port (rst_item item_rst);
        $display("s%", item_rst.sprint);
    endfunction


endclass : afvip_scoreboard