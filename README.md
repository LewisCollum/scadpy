# Scadpy Monorepo

This is a monorepo for parametric 3D printed parts and utilities. It contains:
*   **Pure OpenSCAD Projects**: Hand-written SCAD files.
*   **Python-Generated SCAD**: Parametric models built with `solidpython2`.
*   **Utilities**: Python tools for generating labels, visualizing mockups, etc.

It uses **OpenSCAD** for CAD/Compilation and **Python** (via `uv`) for generation and scripting.

## 🚀 Quick Start (Minimimal Setup)

### 1. Install `proto`
We use `proto` to manage our toolchain (moon, python, etc).

**Windows (Powershell):**
```powershell
irm https://proto.sh | iex
```

**Linux/macOS:**
```bash
curl -fsSL https://proto.sh | bash
```

### 2. Setup Tools
Run this in the project root to install `moon`, `uv`, and `python`.
```bash
proto use
```

### 3. Install Dependencies
This installs Python deps (`uv sync`) and SCAD libraries (like BOSL2).
```bash
moon run :install-deps
uv sync
```

### 4. Build Everything
Generate all STLs and run all python generators.
```bash
moon run :build :generate
```

## 🛠 Directory Structure
*   `packages/scad/*`: OpenSCAD projects.
    *   `src`: Source `.scad` files.
    *   `build`: Generated `.stl` artifacts.
*   `packages/python/*`: Python tools managed by `uv`.

## 🤖 Task Runner (Moon)
*   `moon run emt:build` -> Builds the EMT conduit project.
*   `moon run slide-labels:generate` -> Generates label STLs using Python.
