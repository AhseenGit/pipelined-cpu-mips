0# Pipelined MIPS CPU in VHDL

This project implements a fully functional 5-stage pipelined MIPS processor in VHDL, complete with hazard detection, forwarding logic, and control flow support. The core was developed and verified in ModelSim using real MIPS assembly test programs and is currently being synthesized and validated on the DE10-Standard FPGA with Quartus Prime and SignalTap.

It reflects the full RTL-to-FPGA workflow expected in real-world SoC and ASIC design.

## Project Status

| Component                  | Status                               |
|---------------------------|--------------------------------------|
| RTL Design (VHDL)         | Completed                            |
| ModelSim Simulation       | Verified with assembly programs      |
| Instruction Coverage      | All supported types tested           |
| Quartus Synthesis         | In Progress (target: DE10-Standard)  |
| SignalTap Debugging       | Pending                              |

## Pipeline Architecture

Implements the classic 5-stage MIPS architecture:

1. IF – Instruction Fetch  
2. ID – Instruction Decode & Register Read  
3. EX – Execute (ALU + forwarding)  
4. MEM – Memory access  
5. WB – Write Back

Includes:

- Data forwarding logic (EX/MEM/WB bypassing)  
- Hazard detection & pipeline stalls  
- Control hazard flush for branches/jumps  
- Separate instruction/data memories (Harvard-style)

## Folder Structure

```
mips_pipeline_rtl/
├── VHDL/              # RTL: IF/ID/EX/MEM/WB, ALU, Control, etc.
├── tb/                # Testbenches (unit + top-level)
├── test/              # MIPS assembly test programs
├── docs/              # Instruction reference, screenshots, SignalTap
├── quartus/           # Project files, .mif, and pin configs
└── README.md
```

## Supported Instructions

Your CPU supports the following MIPS instructions:

- Arithmetic: add, sub, addi, mul (16×16 → 32)
- Logic & Shift: and, or, xor, andi, ori, xori, sll, srl
- Memory: lw, sw, lui
- Branching: beq, bne
- Comparison: slt, slti
- Jump & Link: j, jr, jal

Full list available in: docs/instruction_set_reference.pdf

## Note on Pseudo-Instructions

Instructions like mov, li, la, bge, and blt are pseudo-instructions — not supported directly in hardware. For example:

- mov → add rd, rs, $zero  
- li → lui + ori  
- bge → slt + beq

Assembly programs must be rewritten using supported core instructions.

## Simulation & Testbench (ModelSim)

Verified using hand-written MIPS assembly programs:

- Data forwarding tests (RAW hazards)
- Load-use stalls
- Jump and branch correctness
- Memory read/write verification

All waveforms checked in ModelSim. No test failed.

Assembly programs included in /test folder.

## Quartus + FPGA (In Progress)

Target board: DE10-Standard (Intel Cyclone V)  
Quartus Prime is used for:

- RTL synthesis & fitting  
- .mif memory initialization  
- Pin constraints & I/O mapping  
- SignalTap waveform debugging

Goals:

- SignalTap visibility for PC, ALU, and register file  
- LED/GPIO display of results  
- UART interface for program loading (planned)

## Project Highlights

- Real MIPS assembly execution, not test vectors  
- Full ModelSim verification  
- Modular and extensible architecture  
- FPGA-ready RTL with SignalTap debugging plan  
- Clean folder structure and documentation

## Why This Project Matters

This project demonstrates:
- Real-world understanding of pipelined architecture and data/control hazards
- Proficiency in RTL design and simulation (VHDL, ModelSim)
- Toolchain familiarity with Quartus Prime and FPGA debugging via SignalTap
- Ability to execute full hardware development cycle from spec to tested FPGA system
# Pipelined MIPS CPU in VHDL

This project implements a fully functional 5-stage pipelined MIPS processor in VHDL, complete with hazard detection, forwarding logic (including forwarding to ID stage for branch comparisons), and control flow support. The core was developed and verified in ModelSim using real MIPS assembly test programs and is currently being synthesized and validated on the DE10-Standard FPGA with Quartus Prime and SignalTap.

It reflects the full RTL-to-FPGA workflow expected in real-world SoC and ASIC design.

## Project Status

| Component                  | Status                               |
|---------------------------|--------------------------------------|
| RTL Design (VHDL)         | Completed                            |
| ModelSim Simulation       | Verified with assembly programs      |
| Instruction Coverage      | All supported types tested           |
| Quartus Synthesis         | In Progress (target: DE10-Standard)  |
| SignalTap Debugging       | Pending                              |

## Pipeline Architecture

Implements the classic 5-stage MIPS architecture:

1. IF – Instruction Fetch  
2. ID – Instruction Decode & Register Read  
3. EX – Execute (ALU + forwarding)  
4. MEM – Memory access  
5. WB – Write Back

Includes:

- Data forwarding logic:
  - EX stage receives operands from MEM and WB stages
  - ID stage (used for branch comparison) receives operands from EX, MEM, and WB stages
- Hazard detection and pipeline stall logic for load-use hazards
- PC flush on control hazards (branches, jumps)
- Separate instruction and data memories (Harvard-style)

## Folder Structure

```
mips_pipeline_rtl/
├── VHDL/              # RTL: IF/ID/EX/MEM/WB, ALU, Control, etc.
├── tb/                # Testbenches (unit + top-level)
├── test/              # MIPS assembly test programs
├── docs/              # Instruction reference, screenshots, SignalTap
├── quartus/           # Project files, .mif, and pin configs
└── README.md
```

## Supported Instructions

Your CPU supports the following MIPS instructions:

- Arithmetic: add, sub, addi, mul (16×16 → 32)
- Logic & Shift: and, or, xor, andi, ori, xori, sll, srl
- Memory: lw, sw, lui
- Branching: beq, bne
- Comparison: slt, slti
- Jump & Link: j, jr, jal

Full list available in: docs/instruction_set_reference.pdf

## Note on Pseudo-Instructions

Instructions like mov, li, la, bge, and blt are pseudo-instructions — not supported directly in hardware. For example:

- mov → add rd, rs, $zero  
- li → lui + ori  
- bge → slt + beq

Assembly programs must be rewritten using supported core instructions.

## Simulation & Testbench (ModelSim)

Verified using hand-written MIPS assembly programs:

- Forwarding from MEM/WB to EX stage for ALU operations
- Forwarding from EX/MEM/WB to ID stage for branches (`beq`, `bne`)
- Load-use stall detection and control hazard flush
- Correct memory access and control flow operation

All waveforms were reviewed in ModelSim and confirmed correct.

Assembly programs included in /test folder.

Instruction and data memories (`ITCM.hex`, `DTCM.hex`) contain real MIPS programs loaded into memory and executed through the full pipeline, simulating actual embedded system behavior.

## Quartus + FPGA (In Progress)

Target board: DE10-Standard (Intel Cyclone V)  
Quartus Prime is used for:

- RTL synthesis & fitting  
- .mif memory initialization  
- Pin constraints & I/O mapping  
- SignalTap waveform debugging

Goals:

- SignalTap visibility for PC, ALU, and register file  
- LED/GPIO display of results  
- UART interface for program loading (planned)

## Project Highlights

- Executes real MIPS assembly programs, not synthetic vectors  
- Verified with ModelSim using real-world hazard scenarios  
- Modular, extensible VHDL architecture  
- Forwarding logic covers ALU and branch comparisons  
- FPGA-ready RTL with documented debug flow  
- Clean, industry-style folder structure

## Contact

Created by: [Your Name]  
GitHub: [YourGitHubHandle]  
Email: your@email.com

## Contact
later
