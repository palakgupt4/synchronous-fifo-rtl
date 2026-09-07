# Synchronous FIFO (8-bit × 16-deep) — RTL Design, Verification & Synthesis

A single-clock synchronous FIFO (First-In, First-Out) buffer designed in Verilog, functionally verified with a self-checking testbench, and synthesized/implemented in Xilinx Vivado targeting a Kintex-7 FPGA (xc7k70tfbv676-1).

---

## 1. Overview

This project implements a classic synchronous FIFO used to buffer data between two points operating on the **same clock domain**. It supports independent read and write operations, tracks occupancy, and protects against overflow/underflow through full and empty flags.

| Parameter | Value |
|---|---|
| Data width | 8 bits |
| Depth | 16 words |
| Clock domain | Single (synchronous) |
| Pointer width | 4 bits (address) |
| Occupancy counter width | 5 bits (counts 0–16) |

---

## 2. Architecture

The design consists of the following blocks, all operating on a shared clock:

- **Memory array** — 8-bit × 16-deep storage, synthesized as distributed RAM (LUTRAM)
- **Write pointer** — 4-bit address counter, increments on each valid write, wraps at depth
- **Read pointer** — 4-bit address counter, increments on each valid read, wraps at depth
- **Occupancy counter** — 5-bit counter tracking the number of valid entries currently stored
- **Full flag** — asserted when occupancy counter reaches 16
- **Empty flag** — asserted when occupancy counter is 0
- **Read/write enable control** — gates pointer increments and memory access based on `read_en`/`write_en` and current full/empty state, preventing overflow and underflow

## 3. Verification

Verified using a self-checking Verilog testbench (`tb/tb_fifo.v`) with the following test plan:

| # | Test | Purpose |
|---|---|---|
| 1 | Reset | Confirms known, clean initial state |
| 2 | Sequential writes | Core write path functionality |
| 3 | FIFO-order reads | Confirms first-in-first-out ordering is preserved |
| 4 | Empty detection | Empty flag asserts correctly when no data remains |
| 5 | Read-while-empty protection | Confirms no erroneous read/pointer movement when empty |
| 6 | Full detection | Full flag asserts correctly when FIFO is at capacity |
| 7 | Write-while-full protection | Confirms no overflow / data corruption when full |
| 8 | Pointer wrap-around | Confirms correct address wrap at the depth boundary (15 → 0) |
| 9 | Simultaneous read + write | Confirms correct occupancy/data behavior when both operations occur in the same cycle |

**Result:** All tests passed. Simultaneous read/write test example — `write_data = 50 (0x32)` in, `read_data = 0x06` correctly matched `expected_data = 0x06`, with `full = 0` and `empty = 0` throughout, confirming correct concurrent operation.

See `docs/` for waveform screenshots of key test cases.

---

## 4. Synthesis & Implementation Results (Vivado 2025.2, xc7k70tfbv676-1)

### Utilization Summary

| Resource | Used | Available | Utilization |
|---|---|---|---|
| Slice LUTs | 25 | 41,000 | <1% |
| — LUT as Memory | 8 | — | (part of above) |
| — LUT as Logic | 17 | — | (part of above) |
| Slice Registers | 21 | 82,000 | <1% |
| F7 Muxes | 1 | 20,500 | <1% |
| Bonded IOB | 22 | 300 | 7% |
| BUFGCTRL | 1 | 32 | 3% |
| Block RAM Tiles | 0 | — | — |

**Design insight:** The 16-deep memory array was synthesized entirely as **distributed RAM (LUTRAM)** rather than Block RAM — confirmed both by the synthesis log (`RAM32M`, `RAM32X1D` primitives) and by the utilization report showing 0 Block RAM tiles used, with 8 LUTs specifically flagged as memory. This is the efficient, expected outcome for a memory this small; BRAM is typically reserved for much deeper memories (hundreds of words or more).

The remaining 17 LUTs and 21 flip-flops implement the write/read pointers (4 bits each), the occupancy counter (5 bits), and full/empty comparison logic.


## 6. Tools Used

- **Xilinx Vivado 2025.2** — synthesis, implementation, RTL/schematic analysis
- **Verilog** — RTL and testbench
- **Target device:** xc7k70tfbv676-1 (Kintex-7)

---

## Author

Palak Gupta
