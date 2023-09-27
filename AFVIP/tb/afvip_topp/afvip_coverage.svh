// -----------------------------------------------------------------------------
// Module name: afvip_coverage
// HDL        : System Verilog
// Author     : Balint Paul
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
class afvip_coverage extends uvm_subscriber #(apb_item);
    `uvm_component_utils (afvip_coverage)

    function new (string name, uvm_component parent);
        super.new (name, parent);
        cov_pwrite = new();
        cov_addr = new();
        cov_prdata = new();
        cov_pwdata = new();
        cov_opcode = new();
        cov_rs0 = new();
        cov_rs1 = new();
        cov_dst = new();
        cov_imm = new();
    endfunction
    
    real pwrite_cov;
    real addr_cov;
    real prdata_cov;
    real pwdata_cov;
    real opcode_cov;
    real rs0_cov;
    real rs1_cov;
    real dst_cov;
    real imm_cov;
    apb_item cov_item;
//----------------------------------------------------------------------------------------------------------------
    // Coverage for PWRITE
    covergroup cov_pwrite;
        PWRITE: coverpoint cov_item.pwrite {
            bins val_01   = {0};
            bins val_02   = {1};
        }
    endgroup

    // Coverage for PADDR
    covergroup cov_addr;
        PADDR: coverpoint cov_item.paddr{
            bins reg_01      =  {'h00};
            bins reg_02      =  {'h04};
            bins reg_03      =  {'h08};
            bins reg_04      =  {'h0c};
            bins reg_05      =  {'h10};
            bins reg_06      =  {'h14};
            bins reg_07      =  {'h18};
            bins reg_08      =  {'h1c};
            bins reg_09      =  {'h24};
            bins reg_10      =  {'h28};
            bins reg_11      =  {'h2c};
            bins reg_12      =  {'h30};
            bins reg_13      =  {'h34};
            bins reg_14      =  {'h38};
            bins reg_15      =  {'h3c};
            bins reg_16      =  {'h40};
            bins reg_17      =  {'h44};
            bins reg_18      =  {'h48};
            bins reg_19      =  {'h4c};
            bins reg_20      =  {'h50};
            bins reg_21      =  {'h54};
            bins reg_22      =  {'h58};
            bins reg_23      =  {'h5c};
            bins reg_24      =  {'h60};
            bins reg_25      =  {'h64};
            bins reg_26      =  {'h68};
            bins reg_27      =  {'h6c};
            bins reg_28      =  {'h70};
            bins reg_29      =  {'h74};
            bins reg_30      =  {'h78};
            bins reg_31      =  {'h7c};
        }
    endgroup

    // Coverage for PRDATA
    covergroup cov_prdata;
        ADDR: coverpoint cov_item.prdata {
            bins prdata_1   = {['h0:       'h7FFFFFF ]};
            bins prdata_2   = {['h8000000: 'hFFFFFFF ]};
            bins prdata_3   = {['h10000000:'h17FFFFFF]} ;
            bins prdata_4   = {['h18000000:'h1FFFFFFF]} ;
            bins prdata_5   = {['h20000000:'h27FFFFFF]} ;
            bins prdata_6   = {['h28000000:'h2FFFFFFF]} ;
            bins prdata_7   = {['h30000000:'h37FFFFFF]} ;
            bins prdata_8   = {['h38000000:'h3FFFFFFF]} ;
            bins prdata_9   = {['h40000000:'h4FFFFFFF]} ;
            bins prdata_10  = {['h48000000:'h4FFFFFFF]} ;
            bins prdata_11  = {['h50000000:'h57FFFFFF]} ;
            bins prdata_12  = {['h58000000:'h5FFFFFFF]} ;
            bins prdata_13  = {['h60000000:'h67FFFFFF]} ;
            bins prdata_14  = {['h68000000:'h6FFFFFFF]} ;
            bins prdata_15  = {['h70000000:'h77FFFFFF]} ;
            bins prdata_16  = {['h78000000:'h7FFFFFFF]} ;
            bins prdata_17  = {['h80000000:'h87FFFFFF]} ;
            bins prdata_18  = {['h88000000:'h8FFFFFFF]} ;
            bins prdata_19  = {['h90000000:'h97FFFFFF]} ;
            bins prdata_20  = {['h98000000:'hFFFFFFFF]} ;
        }
    endgroup

    // Coverage for PWDATA
    covergroup cov_pwdata;
        PWDATA: coverpoint cov_item.pwdata{
          bins pwdata_1   = {['h0:       'h7FFFFFF ]};
          bins pwdata_2   = {['h8000000: 'hFFFFFFF ]};
          bins pwdata_3   = {['h10000000:'h17FFFFFF]} ;
          bins pwdata_4   = {['h18000000:'h1FFFFFFF]} ;
          bins pwdata_5   = {['h20000000:'h27FFFFFF]} ;
          bins pwdata_6   = {['h28000000:'h2FFFFFFF]} ;
          bins pwdata_7   = {['h30000000:'h37FFFFFF]} ;
          bins pwdata_8   = {['h38000000:'h3FFFFFFF]} ;
          bins pwdata_9   = {['h40000000:'h4FFFFFFF]} ;
          bins pwdata_10  = {['h48000000:'h4FFFFFFF]} ;
          bins pwdata_11  = {['h50000000:'h57FFFFFF]} ;
          bins pwdata_12  = {['h58000000:'h5FFFFFFF]} ;
          bins pwdata_13  = {['h60000000:'h67FFFFFF]} ;
          bins pwdata_14  = {['h68000000:'h6FFFFFFF]} ;
          bins pwdata_15  = {['h70000000:'h77FFFFFF]} ;
          bins pwdata_16  = {['h78000000:'h7FFFFFFF]} ;
          bins pwdata_17  = {['h80000000:'h87FFFFFF]} ;
          bins pwdata_18  = {['h88000000:'h8FFFFFFF]} ;
          bins pwdata_19  = {['h90000000:'h97FFFFFF]} ;
          bins pwdata_20  = {['h98000000:'hFFFFFFFF]} ;
        }
    endgroup
//--------------------------------------------------------OPCODE-----------------------------------------------------
    // Coverage for OPCODE
    covergroup cov_opcode;
        ADDR: coverpoint cov_item.pwdata[2:0]{
            bins interval_1   =  {'d0};
            bins interval_2   =  {'d1};
            bins interval_3   =  {'d2};
            bins interval_4   =  {'d3};
            bins interval_5   =  {'d4};
            illegal_bins wrong_interval = {[3'd5:3'd7]};
        }
    endgroup

    // Coverage for RS0
    covergroup cov_rs0;
        ADDR:coverpoint cov_item.pwdata[7:3] {
          bins min_value            = {0};
          bins max_value            = {31};
          bins rs0_interval [15]    = {[5'd1:5'd15]};
          bins rs0_interval2[14]    = {[5'd16:5'd30]};
        }
    endgroup

    // Coverage for RS1
    covergroup cov_rs1;
        ADDR:coverpoint cov_item.pwdata[12:8] {
          bins min_value            = {0};
          bins max_value            = {31};
          bins rs0_interval [15]    = {[5'd1:5'd15]};
          bins rs0_interval2[14]    = {[5'd16:5'd30]};
        }
        endgroup

    // Coverage for DST
    covergroup cov_dst;
        ADDR:coverpoint cov_item.pwdata[20:16] {
          bins min_value         = {0};
          bins max_value         = {31};
          bins dst_interval [15] = {[5'd1:5'd15]};
          bins dst_interval2[14] = {[5'd16:5'd30]};
        }
    endgroup

    // Coverage for IMM
    covergroup cov_imm;
        ADDR:coverpoint cov_item.pwdata[31:24] {
          bins dst_interval   [16]     = {[8'd0:8'd40]};
          bins dst_interval2  [16]     = {[8'd41:8'd80]};
          bins dst_interval3  [16]     = {[8'd81:8'd120]};
          bins dst_interval4  [16]     = {[8'd121:8'd255]};  
        }
    endgroup
//------------------------------------------------write method-----------------------------------------------------
    function void write(apb_item t);
        cov_item = t;
        cov_pwrite.sample();
        cov_addr.sample();
        cov_prdata.sample();
        cov_pwdata.sample();
        if(t.paddr == 32'h80) begin
            cov_opcode.sample();
            cov_rs0.sample();
            cov_rs1.sample();
            cov_dst.sample();
            cov_imm.sample();
        end
    endfunction
//------------------------------------------------extract phase-----------------------------------------------------
    function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
        pwrite_cov =         cov_pwrite.get_coverage();
        addr_cov =           cov_addr.get_coverage();
        prdata_cov =         cov_prdata.get_coverage();
        pwdata_cov =         cov_pwdata.get_coverage();
        opcode_cov =         cov_opcode.get_coverage();
        rs0_cov =            cov_opcode.get_coverage();
        rs1_cov =            cov_opcode.get_coverage();
        dst_cov =            cov_dst.get_coverage();
        imm_cov =            cov_opcode.get_coverage();
    endfunction
//-------------------------------------------------report phase-----------------------------------------------------
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(),$sformatf("Coverage for pwrite is %f",pwrite_cov),      UVM_MEDIUM)
        `uvm_info(get_type_name(),$sformatf("Coverage for addr is %f",addr_cov),          UVM_MEDIUM)
        `uvm_info(get_type_name(),$sformatf("Coverage for prdata is %f",prdata_cov),      UVM_MEDIUM)
        `uvm_info(get_type_name(),$sformatf("Coverage for pwdata is %f",pwdata_cov),      UVM_MEDIUM)
        `uvm_info(get_type_name(),$sformatf("Coverage for opcode is %f",opcode_cov),      UVM_MEDIUM)
        `uvm_info(get_type_name(),$sformatf("Coverage for rs0 is %f",rs0_cov),            UVM_MEDIUM)
        `uvm_info(get_type_name(),$sformatf("Coverage for rs1 is %f",rs1_cov),            UVM_MEDIUM)
        `uvm_info(get_type_name(),$sformatf("Coverage for dst is %f",dst_cov),            UVM_MEDIUM)
        `uvm_info(get_type_name(),$sformatf("Coverage for imm is %f",imm_cov),            UVM_MEDIUM)
      endfunction
endclass