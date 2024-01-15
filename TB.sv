`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "packet.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"


module top;
  
  logic clock;
  
  xor_interface intf(.clock(clock));
  
  xor_gate dut(
    .A(intf.A),
    .B(intf.B),
    .C(intf.C)
  );

  initial begin
    uvm_config_db #(virtual xor_interface)::set(null, "*", "vif", intf );
  end
  
  initial begin
    run_test("test");
  end
  
 
  initial begin
    clock = 0;
    forever begin
      #2;
      clock = ~clock;
    end
  end
  
  initial begin
    #5000;
    $display("Sorry! Ran out of clock cycles!");
    $finish();
  end
 
  initial begin
    $dumpfile("d.vcd");
    $dumpvars();
  end
  
  
endmodule