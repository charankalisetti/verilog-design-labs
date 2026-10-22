# Verilog Design Labs

A portfolio of Verilog HDL exercises covering combinational logic and sequential digital circuits. The repository keeps synthesizable RTL separate from testbenches so each design is easy to find and simulate.

## Project overview

This repository contains **54 Verilog source files**: **31 RTL designs** and **23 testbenches**.

### Combinational logic

- **Arithmetic:** half adder, full adder, 4-bit ripple-carry adder, adder/subtractor, and 8-bit ALU.
- **Selection and routing:** 2:1 and 4:1 multiplexers in alternate structural/dataflow implementations, 1:4 demultiplexer, and bidirectional buffer.
- **Encoding and decoding:** 8:3 encoder; 2:4 and 3:8 decoders; 4:2 and 8:3 priority encoders, including a composed encoder.
- **Other logic:** XOR gate and priority circuit.

### Sequential logic

- **Storage elements:** D flip-flop, gated D latch built from NAND gates, JK flip-flop, and gated SR latch.
- **Counters:** synchronous up counter, synchronous up/down counter, loadable 4-bit synchronous up/down counter, modulo-9 binary up/down counter, modulo-12 up counter, two-digit BCD counter, and modulo-14 counter that cycles from 3 to 16 with an active-low asynchronous reset.

## Repository layout

```text
combinational/
  rtl/   Combinational design modules
  tb/    Combinational simulation testbenches
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
```

## Simulating an example

Install [Icarus Verilog](https://steveicarus.github.io/iverilog/) and run commands from the repository root. This compiles and runs the full-adder testbench:

```sh
iverilog -g2012 -o full_adder_tb.vvp combinational/rtl/full_adder_df.v combinational/tb/full_adder_df_tb.v
vvp full_adder_tb.vvp
```

Use the matching RTL and testbench files for other examples. Testbenches are individual; there is no unified test runner.
