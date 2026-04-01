# Space Invaders: x86 Assembly Game Engine

## Project Overview
This repository contains a functional clone of the classic arcade game **Space Invaders**, developed entirely in **x86 Assembly** for the **8086/8088 architecture**. The project focuses on direct hardware communication, manual memory management, and optimized rendering routines for legacy BIOS environments.

---

## Technical Specifications
* **Architecture:** x86 16-bit (Real Mode)
* **Environment:** MS-DOS / DOSBox
* **Graphics Mode:** BIOS Video Mode 13h (320x200 pixels, 256 colors)
* **Language:** Intel Assembly (TASM/MASM syntax)

---

## Engineering Highlights

### 1. Graphics Pipeline (Current Version: v1.0)
The engine utilizes a **direct-to-video-memory** approach by accessing the **0A000h** segment. The current rendering logic handles sprite drawing and background clearing within the main game loop.

> **Note:** This version serves as a baseline for measuring performance and identifying synchronization issues like screen flickering.

### 2. Memory Architecture
The software is structured using **modular segments** to ensure strict separation between code, data, and stack:
* **DATASG:** Contains sprite matrices (bitmaps), entity coordinates, and game state variables.
* **CODESG:** Implements the core logic, including procedural macros for sprite rendering and entity updates.

### 3. Hardware Interfacing
* **Input Handling:** Direct monitoring of the keyboard buffer via **BIOS interrupts** to ensure low-latency response for player movement and firing mechanics.
* **Collision Detection:** A coordinate-based matrix scan algorithm that identifies intersections between projectile vectors and entity boundaries.

---

## Development Roadmap

### **Phase 1: Baseline Prototype (Current)**
* Implementation of the core game loop.
* Entity movement and boundary constraints.
* Basic collision detection and score tracking.

### **Phase 2: Graphics Optimization (Upcoming)**
* **Double Buffering:** Implementation of a secondary RAM buffer to eliminate screen tearing and flickering.
* **Vertical Synchronization (VSYNC):** Synchronization with the CRT controller's vertical retrace via **Port 03DAh** for smooth frame delivery.
* **Memory Protection:** Isolation of buffer segments to prevent stack-heap collisions in high-density rendering scenarios.

---

## How to Build
To assemble and link the project, use the **Borland Turbo Assembler (TASM)** suite:

**1. Assemble the source:**
```bash
tasm space.asm
