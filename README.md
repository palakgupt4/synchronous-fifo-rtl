# Synchronous FIFO RTL Design

## Overview

This project implements and verifies an **8-bit × 16-depth synchronous FIFO (First-In-First-Out)** using **Verilog HDL**.

The FIFO stores data in sequential order and ensures that the first data written is the first data read. The design includes read/write control logic, read and write pointers, and `full` and `empty` status flags.

The design was developed, simulated, debugged, and synthesized using **Xilinx Vivado**.

---

## Objectives

The main objectives of this project are:

- Design a synchronous FIFO using Verilog HDL
- Implement read and write pointer management
- Generate `full` and `empty` status flags
- Prevent FIFO overflow and underflow
- Verify FIFO functionality using a self-checking testbench
- Analyze RTL simulation waveforms
- Perform RTL synthesis and examine resource utilization

---

## Specifications

| Parameter | Description |
|---|---|
| FIFO Type | Synchronous FIFO |
| Data Width | 8 bits |
| FIFO Depth | 16 entries |
| Clock | Single clock |
| Reset | Synchronous reset |
| Write Control | `write_en` |
| Read Control | `read_en` |
| Data Input | 8-bit |
| Data Output | 8-bit |
| Status Flags | `full`, `empty` |

---

## FIFO Architecture

The FIFO consists of the following main components:

### 1. Memory Array

The memory array stores the data written into the FIFO.

For this implementation:

```text
16 locations × 8 bits
