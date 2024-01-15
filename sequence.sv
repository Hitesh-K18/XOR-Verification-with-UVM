class base_sequence extends uvm_sequence;
  `uvm_object_utils(base_sequence)
  
  packet pkt;
  
  function new(string name= "base_sequence");
    super.new(name);
    `uvm_info("BASE_SEQ", "Inside Constructor!", UVM_HIGH)
  endfunction
  
  task body();
    `uvm_info("BASE_SEQ", "Inside body task!", UVM_HIGH)
    
    pkt = packet::type_id::create("pkt");
    start_item(pkt);
    pkt.randomize() ;
    finish_item(pkt);
        
  endtask: body
  
  
endclass: base_sequence

