class driver extends uvm_driver#(packet);
  `uvm_component_utils(driver)
  
  virtual xor_interface vif;
  packet pkt;
  
  function new(string name = "driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("DRIVER_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DRIVER_CLASS", "Build Phase!", UVM_HIGH)
    
    if(!(uvm_config_db #(virtual xor_interface)::get(this, "*", "vif", vif))) begin
      `uvm_error("DRIVER_CLASS", "Failed to get VIF from config DB!")
    end
    
  endfunction: build_phase
  
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DRIVER_CLASS", "Connect Phase!", UVM_HIGH)
    
  endfunction: connect_phase
  
 
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("DRIVER_CLASS", "Inside Run Phase!", UVM_HIGH)
    
    forever begin
      pkt = packet::type_id::create("pkt"); 
      seq_item_port.get_next_item(pkt);
      drive(pkt);
      seq_item_port.item_done();
    end
    
  endtask: run_phase
 
  task drive(packet pkt);
    @(posedge vif.clock);
    vif.A <= pkt.A;
    vif.B <= pkt.B;
  endtask: drive
  
  
endclass