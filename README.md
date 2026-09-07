# Synchronous FIFO RTL Design

A synchronous First-In-First-Out (FIFO) memory designed and verified using Verilog HDL and Xilinx Vivado.

## Project Overview

This project implements an 8-bit wide, 16-depth synchronous FIFO. Data is written into the FIFO on the active clock edge when `write_en` is asserted and read when `read_en` is asserted.

The design includes read/write pointer management and `full`/`empty` status flags to prevent invalid read and write operations.

## Specifications

| Parameter | Value |
|---|---|
| Data Width | 8 bits |
| FIFO Depth | 16 |
| Clock | Single synchronous clock |
| Reset | Synchronous |
| Write Control | `write_en` |
| Read Control | `read_en` |
| Status Flags | `full`, `empty` |

## Design Features

- 8-bit data storage
- 16 memory locations
- Synchronous read/write operation
- Read and write pointer management
- Full and empty flag generation
- Overflow protection
- Underflow protection
- Pointer wrap-around
- Simultaneous read/write operation

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
