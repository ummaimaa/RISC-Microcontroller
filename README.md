# RISC-Microcontroller

## Overview

This project implements a simple microcontroller in Verilog HDL, modeled with a modular design approach. It simulates key features of a basic processor, including:

- **ALU (Arithmetic Logic Unit)**
- **Control Unit**
- **Execution Unit**
- **Instruction Decoder**
- **Register File**
- **Flags Logic**
- **Memory (via RAM inside `microcontroller.v`)**
- **Testbench for Simulation**

Each module is designed and tested independently and then integrated into the top-level `microcontroller` module.

---

## Project Structure

-├── README.md ← This file
-├── aLu.v ← ALU operation definitions
-├── alu_module.v ← Wrapper or variant of the ALU
-├── control_unit.v ← Main control logic unit
-├── controlunit.v ← Alternate version of control logic (decoder etc.)
-├── execution.v ← Execution stage wiring logic
-├── execution_unit.v ← Execution stage module
-├── flag.v ← Zero/Carry/Sign flag computation
-├── instruction_decoder.v ← Instruction decoding logic
-├── microcontroller.v ← Top-level integrated microcontroller
-├── register.v ← Register file (read/write logic)
-└── testbench.v ← Testbench for simulating full microcontroller


---

## Key Modules Description

### `microcontroller.v`
- Top-level module integrating all subsystems: ALU, control unit, register file, execution stage, etc.
- Coordinates operation cycles using input instructions and control logic.

### `aLu.v`
- Basic ALU that performs arithmetic and bitwise operations.
- Typically supports operations like ADD, SUB, AND, OR.

### `alu_module.v`
- A higher-level wrapper or variant of the ALU with additional features (e.g., flags, multiplexers).

### `control_unit.v` / `controlunit.v`
- Manages control signals for the datapath components.
- Decodes instruction opcodes and issues the correct control signals.

### `instruction_decoder.v`
- Parses binary instructions and generates control signals or fields (like register addresses, immediate values, etc.).

### `execution.v` / `execution_unit.v`
- Contains logic for the execution stage of instructions.
- Connects ALU, registers, and memory in the data path.

### `flag.v`
- Handles status flags: Zero, Carry, Sign, Overflow.
- Used to support conditional branching and flag-aware operations.

### `register.v`
- Implements the register file.
- Supports read/write operations on general-purpose registers.

### `testbench.v`
- Provides stimulus to the `microcontroller` module.
- Simulates instruction sequences and checks output correctness.

---

### Tools

This design is compatible with most Verilog simulation tools:
- **ModelSim / QuestaSim**
- **Xilinx Vivado (for simulation only)**
- **Icarus Verilog + GTKWave**





