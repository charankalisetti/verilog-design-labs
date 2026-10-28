# Verilog Design Labs

A portfolio of Verilog HDL exercises covering combinational logic and sequential digital circuits. The repository keeps synthesizable RTL separate from testbenches so each design is easy to find and simulate.

## Project overview

This repository contains **66 Verilog source files**: **41 RTL designs** and **25 testbenches**.

### Combinational logic

- **Arithmetic:** half adder, full adder, 4-bit ripple-carry adder, adder/subtractor, and 8-bit ALU.
- **Multiplexer and routing:** 2:1 and 4:1 multiplexers in alternate structural/dataflow implementations, 1:4 demultiplexer, and bidirectional buffer.
- **Encoding and decoding:** 8:3 encoder; 2:4 and 3:8 decoders; 4:2 and 8:3 priority encoders, including a composed encoder.
- **Other logic:** XOR gate and priority circuit.

### Sequential logic

- **Storage elements:** D flip-flop, gated D latch built from NAND gates, JK flip-flop, and gated SR latch.
- **Counters:** synchronous up counter, synchronous up/down counter, loadable 4-bit synchronous up/down counter, modulo-9 binary up/down counter, modulo-12 up counter, two-digit BCD counter, modulo-14 counter that cycles from 3 to 16 with an active-low asynchronous reset, modulo-10 down counter, and dual-mode 6-bit ring/Johnson counter.
- **Shift registers:** 4-bit bidirectional register, parameterized N-bit serial-in/parallel-out register, and 4-bit serial-in/serial-out register.
- **Memories and FIFO:** asynchronous single-port RAM, synchronous dual-port RAM, and synchronous FIFO.
- **State machines:** Moore FSM that checks whether an MSB-first binary stream is divisible by 3.

## Repository layout

```text
combinational/
  arithmetic/
    rtl/   Arithmetic designs
    tb/    Arithmetic testbenches
  multiplexer/
    rtl/   Multiplexers, demultiplexer, and bidirectional buffer
    tb/    Multiplexer and routing testbenches
  encoders-decoders/
    rtl/   Encoders, priority encoders, and decoders
    tb/    Encoder and decoder testbenches
  other-logic/
    rtl/   XOR gate and priority circuit
sequential/
  counters/
    rtl/   Counter modules
    tb/    Counter simulation testbenches
  flip-flops/
    rtl/   Flip-flop modules
    tb/    Flip-flop simulation testbenches
  latches/
    rtl/   Latch modules
    tb/    Latch simulation testbenches
  memories-fifos/
    rtl/   RAM and FIFO modules
  shift-registers/
    rtl/   Shift-register modules
    tb/    Shift-register simulation testbenches
  state-machines/
    rtl/   State-machine modules
```

## Simulating an example

Install [Icarus Verilog](https://steveicarus.github.io/iverilog/) and run commands from the repository root. This compiles and runs the full-adder testbench:

```sh
iverilog -g2012 -o full_adder_tb.vvp combinational/arithmetic/rtl/full_adder_df.v combinational/arithmetic/tb/full_adder_df_tb.v
vvp full_adder_tb.vvp
```

Use the matching RTL and testbench files for other examples. Testbenches are individual; there is no unified test runner.
