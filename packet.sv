class packet extends uvm_sequence_item;
  `uvm_object_utils(packet)
  rand bit A,B;
 // rand bit C;
  function new(string name = "packet");
    super.new(name);
  endfunction: new
endclass

class result_packet extends packet;
  `uvm_object_utils(result_packet)
  rand bit C;
  function new(string name="result_packet");
               super.new(name);
  endfunction:new
endclass