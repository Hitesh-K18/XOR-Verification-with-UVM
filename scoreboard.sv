class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp #(result_packet, scoreboard) scoreboard_port;
  
  result_packet Queue[$];
  
  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SCB_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCB_CLASS", "Build Phase!", UVM_HIGH)
   
    scoreboard_port = new("scoreboard_port", this);
    
  endfunction: build_phase
 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCB_CLASS", "Connect Phase!", UVM_HIGH)
    
   
  endfunction: connect_phase
  
  function void write(result_packet pkt);
    Queue.push_back(pkt);
  endfunction: write 
  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SCB_CLASS", "Run Phase!", UVM_HIGH)
   
    forever begin
     result_packet pkt1;
      wait((Queue.size() != 0));
      pkt1 = Queue.pop_front();
      compare(pkt1);
      
    end
    
  endtask: run_phase
  
  task compare(result_packet pkt1);
    logic expected;
    logic  actual;
    
    case({pkt1.A,pkt1.B})
       2'b00: expected=0;
       2'b01: expected=1;
       2'b10: expected=1; 
       2'b11: expected=0; 
    endcase
    actual = pkt1.C;
    if(actual != expected) begin
      `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d",actual, expected))
    end
    else begin
      `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", actual, expected), UVM_LOW)
    end
    
  endtask: compare
  
  
endclass