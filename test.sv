class test extends uvm_test;
  `uvm_component_utils(test)

  xor_env env;
  base_sequence seq;
  //test_sequence test_seq;

  function new(string name = "test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("TEST_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TEST_CLASS", "Build Phase!", UVM_HIGH)

    env = xor_env::type_id::create("env", this);

  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST_CLASS", "Connect Phase!", UVM_HIGH)

  endfunction: connect_phase

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("TEST_CLASS", "Run Phase!", UVM_HIGH)

    phase.raise_objection(this);
    repeat(100) begin
          seq = base_sequence::type_id::create("reset_seq");
    seq.start(env.agnt.seqr);
    #10;
    end
    
    phase.drop_objection(this);

  endtask: run_phase


endclass