# Synchronous FIFO RTL Design

A **synchronous First-In-First-Out (FIFO)** memory designed and verified using **Verilog HDL** and **Xilinx Vivado**.

## Project Overview

This project implements an **8-bit wide, 16-depth synchronous FIFO**. Data is written into the FIFO on the active clock edge when `write_en` is asserted and read when `read_en` is asserted.

The design includes control logic to prevent invalid read/write operations and generates `full` and `empty` status flags.

## Specifications

| Parameter | Value |
|---|---|
| Data Width | 8 bits |
| FIFO Depth | 16 |
| Clock | Single synchronous clock |
| Reset | Synchronous |
| Read Enable | `read_en` |
| Write Enable | `write_en` |
| Status Flags | `full`, `empty` |

## Design Features

- 8-bit data storage
- 16 memory locations
- Synchronous read/write operation
- Read and write pointer management
- `full` and `empty` flag generation
- Protection against writing when FIFO is full
- Protection against reading when FIFO is empty
- Pointer wrap-around
- Support for simultaneous read and write operations

## Project Structure

```text
synchronous-fifo-rtl/
│
├── rtl/
│   └── fifo.v
│
├── tb/
│   └── tb_fifo.v
│
├── docs/
│   ├── waveform_fifo.png
│   ├── schematic_fifo.png
│   ├── design_fifo.png
│   └── Utilization_report_fifo.png
│
└── README.md
RTL Design

The FIFO consists of:

Memory array — stores the data
Write pointer — identifies the next location for writing
Read pointer — identifies the next location for reading
Full logic — indicates that the FIFO cannot accept another write
Empty logic — indicates that no data is available for reading
Basic Operation
Write Operation
write_en = 1 && full = 0
        ↓
Write data into memory
        ↓
Increment write pointer
Read Operation
read_en = 1 && empty = 0
        ↓
Read data from memory
        ↓
Increment read pointer
Verification

A dedicated Verilog testbench was developed to verify the FIFO functionality.

The verification includes:

Reset operation
Normal write operations
Normal read operations
Sequential write/read operations
Full FIFO condition
Empty FIFO condition
Prevention of overflow
Prevention of underflow
Pointer wrap-around
Simultaneous read/write operation
Expected-data comparison

The testbench uses self-checking verification by comparing the expected data with the actual FIFO output.

Simulation

The design was simulated using Xilinx Vivado.

Simulation Waveform

The waveform demonstrates correct clocked FIFO operation, including read/write control, data transfer, and full/empty status behavior.

RTL Schematic

The RTL schematic shows the structure of the FIFO design, including the memory, pointer logic, and control logic.

Synthesis

The RTL was synthesized using Xilinx Vivado to examine the generated hardware implementation and resource utilization.

Utilization Report

The utilization report provides information about the hardware resources used by the synthesized FIFO design.

Tools Used
Verilog HDL
Xilinx Vivado
RTL Simulation
RTL Synthesis
Key Learning Outcomes

Through this project, I gained practical experience in:

Sequential RTL design
FIFO architecture
Pointer-based control logic
Full/empty condition generation
Self-checking testbench development
Waveform-based debugging
RTL synthesis and utilization analysis
Functional verification of memory-based designs
Future Improvements
Parameterized FIFO width and depth
Asynchronous FIFO implementation
Almost-full/almost-empty flags
Extended SystemVerilog verification
Formal verification
Author

Palak Gupta

Electronics and Communication Engineering

Interested in RTL Design, FPGA, VLSI and Computer Architecture
