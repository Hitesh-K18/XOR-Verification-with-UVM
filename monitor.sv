class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  virtual xor_interface vif;
  result_packet pkt;
  
  uvm_analysis_port #(result_packet) monitor_port;
 
  function new(string name = "monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MONITOR_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR_CLASS", "Build Phase!", UVM_HIGH)
    
    monitor_port = new("monitor_port", this);
    
    if(!(uvm_config_db #(virtual xor_interface)::get(this, "*", "vif", vif))) begin
      `uvm_error("MONITOR_CLASS", "Failed to get VIF from config DB!")
    end
    
  endfunction: build_phase
 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MONITOR_CLASS", "Connect Phase!", UVM_HIGH)
    
  endfunction: connect_phase
 
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR_CLASS", "Inside Run Phase!", UVM_HIGH)
    
    forever begin
      pkt = result_packet::type_id::create("pkt");
      
      //wait(!vif.reset);
      
      //sample inputs
      @(posedge vif.clock);
      pkt.A = vif.A;
      pkt.B = vif.B;
      //sample output
     // @(posedge vif.clock);
      pkt.C = vif.C;
      
      // send item to scoreboard
      monitor_port.write(pkt);
    end
        
  endtask: run_phase
  
  
endclass