// -----------------------------------------------------------------------------
// Module name: afvip_assertions
// HDL        : System Verilog
// Author     : Balint Paul
// Date       : 28 June 2023
// -----------------------------------------------------------------------------
//----------------------------------------------------------- Sequences --------------------------------------------------

//phases
    sequence idle_phase ;
        !psel ;
    endsequence
    
    sequence setup_phase ;
        psel && !penable ;
    endsequence
    
    sequence access_phase_wait ;
        psel && penable && !pready ;
    endsequence
    
    sequence access_phase_last ;
        psel && penable && pready ;
    endsequence

 //----------------------------------------------------------- Properties --------------------------------------------------
//  paddr multiple of 4
    property paddr_multiple_of_4;
        @(posedge clk) disable iff(!rst_n)
        (paddr % 4 == 0);
    endproperty

//  pwdata get data if pwrite,penable,pready,psel = 1
    property pwdata_write ;
        @(posedge clk) disable iff(!rst_n)
        $stable(pwdata) |-> (pwrite == 1) and (access_phase_last);
    endproperty
    
//  prdata get data if pwrite = 0 and penable,pready,psel = 1
    property prdata_read ;
        @(posedge clk) disable iff(!rst_n)
        $stable(prdata) |-> (pwrite == 0) and (access_phase_last);
    endproperty

// check if the signals are unknown (red not connected(X), blue without data(Z))

    property pr_generic_not_unknown_psel ;
        @(posedge clk) disable iff(rst_n)
        !$isunknown(psel) ;
    endproperty

    property pr_generic_not_unknown_penable ;
        @(posedge clk) disable iff(rst_n)
        !$isunknown(penable) ;
    endproperty

    property pr_generic_not_unknown_pwrite ;
        @(posedge clk) disable iff(rst_n)
        !$isunknown(pwrite) ;
    endproperty

    property pr_generic_not_unknown_paddr ;
        @(posedge clk) disable iff(rst_n)
        !$isunknown(paddr) ;
    endproperty

    property pr_generic_not_unknown_pready ;
        @(posedge clk) disable iff(rst_n)
        !$isunknown(pready) ;
    endproperty

    property pr_generic_not_unknown_pwdata ;
        @(posedge clk) disable iff(rst_n)
        !$isunknown(pwdata) ;
    endproperty

    property pr_generic_not_unknown_prdata ;
        @(posedge clk) disable iff(rst_n)
        !$isunknown(prdata) ;
    endproperty
  
//-------------------------------------------------------- Assertions --------------------------------------------------------------

//  check all signal for being valid
    PSEL_never_X    : assert property (pr_generic_not_unknown_psel)     else $display("[%0t] Error! PSEL is unknown (=X/Z)", $time);
    PENABLE_never_X : assert property (pr_generic_not_unknown_penable)  else $display("[%0t] Error! PENABLE is unknown (=X/Z)", $time);
    PWRITE_never_X  : assert property (pr_generic_not_unknown_pwrite)   else $display("[%0t] Error! PWRITE is unknown (=X/Z)", $time);
    PADDR_never_X   : assert property (pr_generic_not_unknown_paddr)    else $display("[%0t] Error! PADDR is unknown (=X/Z)", $time);
    PREADY_never_X  : assert property (pr_generic_not_unknown_pready)   else $display("[%0t] Error! PREADY is unknown (=X/Z)", $time);
    PWDATA_never_X  : assert property (pr_generic_not_unknown_pwdata)   else $display("[%0t] Error! PWDATA is unknown (=X/Z)", $time);
    PRDATA_never_X  : assert property (pr_generic_not_unknown_prdata)   else $display("[%0t] Error! PRDATA is unknown (=X/Z)", $time);
  
//  check the protocol
    paddr_multiple         : assert property (paddr_multiple_of_4)      else $display("[%0t] Error! PADDR must be multiple of 4", $time);
    pwdata_write_check     : assert property (pwdata_write)             else $display("[%0t] Error! Write must happen", $time);
    prdata_read_check      : assert property (prdata_read)              else $display("[%0t] Error! Read must happen", $time);
    