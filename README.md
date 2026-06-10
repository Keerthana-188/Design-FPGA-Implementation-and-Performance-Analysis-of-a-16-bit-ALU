# Design, FPGA Implementation and Performance Analysis of a 16-bit ALU

## Overview

This project presents the design, FPGA implementation, and performance analysis of a **16-bit Arithmetic Logic Unit (ALU)** on the **Zybo Z7-10 (Zynq-7010 FPGA)** platform.

This work was carried out as part of **Zenith**, an intra-college technical innovation and project competition, where the objective was to design, implement, and evaluate a hardware system using FPGA-based digital design techniques.

Three architectural variants were implemented and analyzed:

- Non-Pipelined ALU
- 2-Stage Pipelined ALU
- 3-Stage Pipelined ALU

The project evaluates the impact of pipelining on:

- Critical Path Delay
- Maximum Operating Frequency (Fmax)
- Throughput
- Latency
- FPGA Resource Utilization

The design was developed using **Verilog HDL** and implemented using **Xilinx Vivado Design Suite**.

---

## Project Objectives

Design and implement a 16-bit ALU supporting:

- Addition (ADD)
- Subtraction (SUB)
- Logical AND
- Logical OR
- Multiplication (MUL)

Compare:

- Non-Pipelined Architecture
- 2-Stage Pipelined Architecture
- 3-Stage Pipelined Architecture

Analyze:

- Gate-Level Mapping
- Resource Utilization
- Critical Path
- Maximum Frequency (Fmax)
- Latency vs Throughput Trade-Off

---

## FPGA Platform

| Parameter | Value |
|------------|--------|
| Board | Zybo Z7-10 |
| FPGA | XC7Z010CLG400-1 |
| Processor | Dual-Core ARM Cortex-A9 |
| External Clock | 125 MHz |
| Development Tool | Vivado Design Suite |
| Language | Verilog HDL |

---

## Supported Operations

| Opcode | Operation |
|---------|-----------|
| 000 | ADD |
| 001 | SUB |
| 010 | AND |
| 011 | OR |
| 100 | MUL |

---

## Design Evolution

Based on review feedback, the architecture was improved by creating separate modules for:

- Arithmetic Unit
- Logical Unit
- Multiplication Unit

Benefits:

- Better modularity
- Improved scalability
- Easier verification
- Better hardware organization

An additional UART-based input interface was explored for supplying larger operands. However, stable UART communication could not be established during the project timeline and was therefore excluded from the final hardware demonstration.

---

## Functional Verification

The following verification stages were completed:

- Behavioral Simulation
- Post-Synthesis Functional Simulation
- Post-Implementation Simulation

Verified Features:

- Arithmetic Operations
- Logical Operations
- Multiplier Functionality
- Zero Flag Generation
- Pipeline Latency Behavior

Pipeline latency was successfully observed in both 2-stage and 3-stage architectures.

---

# FPGA Mapping Analysis

## DSP48E1 Mapping

The multiplication operation:

```verilog
A * B
```

was automatically mapped to a dedicated DSP48E1 primitive.

Advantages:

- Dedicated hardware multiplier
- High-speed multiplication
- Reduced LUT usage

DSP Usage:

| Design | DSP Blocks |
|----------|------------|
| Non-Pipelined | 1 |
| 2-Stage Pipeline | 1 |
| 3-Stage Pipeline | 1 |

---

## Carry Chain Mapping

Addition and subtraction operations were synthesized using:

```text
CARRY4 primitives
```

Advantages:

- Fast carry propagation
- Reduced arithmetic delay
- Efficient FPGA implementation

Logical operations and opcode selection were implemented using LUT6 primitives and LUT-based multiplexers.

---

# Resource Utilization Comparison

| Design | LUTs | Registers | DSP |
|---------|------|------------|------|
| Non-Pipelined | 75 | 0 | 1 |
| 2-Stage Pipeline | 75 | 51 | 1 |
| 3-Stage Pipeline | 66 | 70 | 1 |

## Observations

- DSP utilization remains constant.
- Register count increases due to pipelining.
- LUT count remains nearly unchanged.
- No additional DSP resources are required for performance improvement.

---

# Timing Performance Comparison

| Design | Critical Path | Fmax | Latency |
|---------|--------------|--------|----------|
| Non-Pipelined | 7.646 ns | 131 MHz | 1 Cycle |
| 2-Stage Pipeline | 5.994 ns | 167 MHz | 2 Cycles |
| 3-Stage Pipeline | 5.741 ns | 174 MHz | 3 Cycles |

## Frequency Improvement

```text
131 MHz → 174 MHz
```

Performance Improvement:

```text
≈ 33%
```

## Critical Path Reduction

```text
7.646 ns → 5.741 ns
```

Reduction:

```text
1.905 ns
```

---

# Latency vs Throughput Analysis

| Design | Latency | Throughput | Operations Per Second |
|---------|----------|------------|----------------------|
| Non-Pipelined | 1 Cycle | 1 Result/Clock | 131 Million |
| 2-Stage Pipeline | 2 Cycles | 1 Result/Clock | 167 Million |
| 3-Stage Pipeline | 3 Cycles | 1 Result/Clock | 174 Million |

## Key Observation

As pipeline depth increases:

- Latency increases.
- Throughput remains constant at one result per clock.
- Operations per second increase due to higher clock frequency.

This demonstrates the classic latency vs throughput trade-off in pipelined FPGA architectures.

---

# Architectural Insights

## Why 2-Stage Pipelining Improved Performance

- Multiplier critical path isolated
- Reduced combinational depth
- DSP input/output stages separated

## Why 3-Stage Improvement Was Smaller

- DSP48E1 blocks are internally optimized
- Additional pipelining provides diminishing returns

---

# Hardware Demonstration

Hardware validation was performed on:

**Zybo Z7-10 (XC7Z010CLG400-1)**

Demonstration Interface:

- Slide Switches
- Push Buttons
- LEDs

## Limitations Encountered

The target design was a complete 16-bit ALU.

However:

- The board provides only four slide switches.
- Sequential multi-bit entry resulted in unreliable bit recognition.
- UART-based input using PuTTY was explored but stable communication could not be established during demonstration.

Therefore, a scaled hardware demonstration was implemented while preserving the complete 16-bit architecture in simulation, synthesis, and timing analysis.


---

# Results Summary

| Metric | Non-Pipelined | 2-Stage Pipeline | 3-Stage Pipeline |
|----------|--------------|------------------|------------------|
| LUTs | 75 | 75 | 66 |
| Registers | 0 | 51 | 70 |
| DSP Blocks | 1 | 1 | 1 |
| Critical Path | 7.646 ns | 5.994 ns | 5.741 ns |
| Fmax | 131 MHz | 167 MHz | 174 MHz |
| Latency | 1 Cycle | 2 Cycles | 3 Cycles |
| Throughput | 1 Result/Clock | 1 Result/Clock | 1 Result/Clock |
| Operations/sec | 131 M | 167 M | 174 M |

---

# Conclusion

A 16-bit ALU with arithmetic, logical, and multiplication functionality was successfully implemented on the Zynq-7010 FPGA.

Major achievements include:

- FPGA implementation of three ALU architectures
- Gate-level mapping analysis
- DSP48E1 multiplier utilization
- CARRY4 arithmetic implementation
- Critical path reduction from 7.646 ns to 5.741 ns
- 33% improvement in maximum operating frequency
- Detailed latency vs throughput analysis

The study demonstrates how pipelining can significantly improve FPGA timing performance while maintaining throughput, making it a valuable technique for high-performance digital system design.

---

## Authors

**Virtual Warriors**

- Keerthana A
- Madhu Visagan H T
- Jayatri Neha V S
