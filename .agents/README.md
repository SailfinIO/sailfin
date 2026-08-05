# Workspace Agent Customizations for Sailfin

This directory contains workspace-level skills and agent configurations for Gemini / Antigravity agents.

## Structure

- `skills/`: Reusable skills automatically discovered by Antigravity / Gemini agents.
  - `sailfin-check/`: Run Sailfin compiler and test verification safely with required self-hosting and formatting gates.
  - `sailfin-debug-compile/`: Systematically diagnose why a Sailfin source file or self-hosting build step fails to compile.
  - `sailfin-pickup/`: Pick up a ready Sailfin Linear or GitHub issue and drive it through branch, implementation, verification, independent review, and PR handoff.
  - `sailfin-pin-seed/`: Update and verify seed pin in `bootstrap.toml` and `compiler/capsule.toml`.
  - `sfn-plan/`: Plan Sailfin work in Linear from Initiatives through Projects to session-sized compiler/runtime issues.
