# Verilog Design Labs

A collection of Verilog HDL exercises in combinational logic and sequential digital circuits. The repository groups synthesizable examples and simulation testbenches so each topic is easy to browse.

## What is included

### Combinational logic

Examples include adders and subtractors, an 8-bit ALU, encoders and priority encoders, decoders, multiplexers, a demultiplexer, XOR logic, a priority circuit, and a bidirectional buffer. The buffer implementation was moved into `combinational/rtl/` to keep design modules separate from testbenches.

### Sequential circuits

Examples include a D flip-flop, JK flip-flop, gated SR latch, modulo-12 counter, synchronous up counter, and synchronous up/down counter.

## Repository layout

```text
combinational/
  rtl/   Combinational design modules
  tb/    Combinational simulation testbenches
sequential/
  rtl/   Sequential design modules
  tb/    Sequential simulation testbenches
```

There are 41 Verilog files: 24 design modules and 17 testbenches. Quartus and ModelSim build products, simulator databases, and backup files are excluded.

## Simulating an example

Install [Icarus Verilog](https://steveicarus.github.io/iverilog/) and run commands from the repository root. For example:

```sh
iverilog -g2012 -o full_adder_tb.vvp combinational/rtl/full_adder_df.v combinational/tb/full_adder_df_tb.v
vvp full_adder_tb.vvp
```

Use the matching RTL and testbench files for other examples. Testbenches are provided individually; no unified test runner is included.
