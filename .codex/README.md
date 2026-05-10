# Codex setup for Sailfin

This directory mirrors the high-value parts of the Claude Code setup using Codex-native repository artifacts where available and prompt templates where Codex does not yet provide Claude-style custom slash commands.

## What is configured

- `config.toml` enables repo-local hooks, hierarchical `AGENTS.md` handling, long-running goals, and the two Sailfin skills.
- `hooks.json` wires lifecycle events to small shell scripts under `hooks/`.
- `skills/` contains reusable Sailfin workflows for safe verification and issue pickup.
- `prompts/` contains copy/paste prompts for Codex web or CLI sessions.

## Local setup

From the repository root, start Codex normally:

```bash
codex
```

Then confirm the session sees the repo configuration:

```text
/status
```

If your Codex build does not auto-load repo-local skills or hooks, paste the relevant prompt from `prompts/` and explicitly mention the `SKILL.md` file named in that prompt.

## Web setup

Codex web should be given the same repository context plus one of the prompts in `prompts/`. For the closest equivalent to Claude's `/pickup`, paste `prompts/pickup.md` and optionally append an issue number.

## Safety behavior

The hooks are intentionally conservative:

- `SessionStart` adds a compact compiler/seed/branch snapshot.
- `UserPromptSubmit` adds branch, dirty-file count, and unpushed commit count.
- `PreToolUse` blocks `make`, `build/native/sailfin`, and `build/native/sailfin-seedcheck` commands unless the command includes `ulimit -v 8388608`.

The memory cap duplicates the project rule in `AGENTS.md` because uncapped Sailfin compiler runs can exhaust local WSL or IDE hosts.

## Issue pickup workflow

Use `prompts/pickup.md` for autonomous issue work. It instructs Codex to:

1. Query `claude-ready` issues and rank them with the same priority order as Claude's `/pickup` command.
2. Verify pinned-seed freshness before claiming compiler/runtime work.
3. Claim the issue, sync the project board with the existing repository helper, and branch as `codex/<issue>-<slug>`.
4. Implement, verify, commit, and open a PR with `Closes #<issue>`.

The GitHub/project scripts remain in `.claude/scripts/` for now because they are repository automation rather than Claude-only logic.
