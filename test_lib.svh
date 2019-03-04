import uvm_pkg::*;
`include "uvm_macros.svh"

//constants
`define COUNT 65535

//dut
`include "dut/bridge.sv"

//rtl
`include "rtl/ahb_if.sv"
`include "rtl/apb_if.sv"

//ahb
`include "ahb_agent_top/ahb_agent_config.sv"
`include "ahb_agent_top/ahb_transaction.sv"
`include "ahb_agent_top/sequences/ahb_base_sequence.sv"
`include "ahb_agent_top/sequences/ahb_reset_sequence.sv"
`include "ahb_agent_top/sequences/ahb_slave0_sequence.sv"
`include "ahb_agent_top/sequences/ahb_slave1_sequence.sv"
`include "ahb_agent_top/sequences/ahb_slave2_sequence.sv"
`include "ahb_agent_top/sequences/ahb_slave3_sequence.sv"
`include "ahb_agent_top/sequences/ahb_main_sequence.sv"
`include "ahb_agent_top/sequences/ahb_multi_sequence.sv"
`include "ahb_agent_top/ahb_sequencer.sv"
`include "ahb_agent_top/ahb_driver.sv"
`include "ahb_agent_top/ahb_monitor.sv"
`include "ahb_agent_top/ahb_agent_active.sv"
`include "ahb_agent_top/ahb_monitor_passive.sv"
`include "ahb_agent_top/ahb_agent_passive.sv"

//apb
`include "apb_agent_top/apb_slave.sv"
`include "apb_agent_top/apb_agent_config.sv"
`include "apb_agent_top/apb_transaction.sv"
`include "apb_agent_top/apb_sequencer.sv"
`include "apb_agent_top/apb_sequence.sv"
`include "apb_agent_top/apb_driver.sv"
`include "apb_agent_top/apb_monitor.sv"
`include "apb_agent_top/apb_agent.sv"

//env
`include "env/base_vseq.sv"
`include "env/env_config.sv"
`include "env/coverage.sv"
`include "env/scoreboard.sv"
`include "env/env.sv"

//vseq
`include "ahb_apb_vseq.sv"

//test
`include "test/base_test.sv"
`include "test/init_vseq_from_test.sv"

//top
`include "top.sv"