# Booth Signed n-Bit Multiplier (Verilog)

## Overview
This project implements a signed n-bit Booth multiplier in Verilog.  
The multiplier uses the Booth algorithm to perform efficient signed multiplication.  
It has been tested using ModelSim with 10,000 random test cases.

## Features
- Signed multiplication using Booth algorithm
- Parameterizable operand width (`n` bits)
- Sequential design with `start` and `ready` signals
- Fully synthesizable RTL
- Self-checking testbench with extensive random testing

## Project Files
- `multiplier7.v` : Booth signed n-bit multiplier (design under test)
- `multiplier7_tb.v` : Testbench with 10,000 random test cases
- `README.md` : This documentation

## Multiplier Interface

**Inputs:**
- `clk` : Clock signal
- `start` : Starts multiplication
- `A` : Signed multiplicand (`n` bits)
- `B` : Signed multiplier (`n` bits)

**Outputs:**
- `Product` : Signed multiplication result (`2n` bits)
- `ready` : Multiplication complete indicator

## Testbench
The testbench:
- Generates a 100 MHz clock
- Applies random signed inputs
- Uses a start/ready handshake
- Computes expected results and compares automatically
- Reports any mismatch

Random numbers are generated using concatenated `$random()` calls to support wide operands.

## Simulation Instructions
1. Compile the design and testbench in ModelSim:
vlog multiplier7.v multiplier7_tb.v
2. Run the simulation:
vsim multiplier7_tb
run -all
3. Check the console output for pass/fail results.

## Parameters
- `nb` : operand width  
Example for 32-bit multiplication:
parameter nb = 31;

## Verification
- 10,000 random test cases passed in ModelSim
- Correct handling of signed values
- Tested for positive, negative, and mixed-sign inputs
- It can be used for any arbitrary nb less than or equal to 63 (even if it is odd).
## Author
Parnia Rezaei
