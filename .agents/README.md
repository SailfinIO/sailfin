# Workspace Agent Customizations for Sailfin

This directory contains workspace-level configuration for Gemini / Antigravity agents.

## Structure

- `mcp_config.json`: MCP server configuration used by Gemini / Antigravity.

Sailfin's Codex skills live only under `.codex/skills/`. Do not duplicate those
skill names under `.agents/skills/`; Codex discovers both locations and duplicate
names make skill selection ambiguous.
