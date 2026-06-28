# Codex setup for Sailfin

This directory mirrors the high-value, provider-neutral parts of the Claude Code setup using Codex-native repository artifacts where available and prompt templates where Codex does not yet provide Claude-style slash commands.

## What is configured

- `config.toml` enables repo-local hooks, hierarchical `AGENTS.md` handling, long-running goals, and the Sailfin skills.
- `hooks/` injects fast session and git context without enforcing obsolete caller-side memory wrappers.
- `skills/` contains reusable Sailfin workflows for safe verification, issue pickup, compilation debugging, and seed pinning.
- `prompts/` contains copy/paste prompts for Codex web or CLI sessions, including issue pickup, feature planning, validation, and SFEP management.

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

Codex web should be given the same repository context plus one of the prompts in `prompts/`. For the closest equivalent to Claude's `/pickup`, paste `prompts/pickup.md` and optionally append an issue number. For SFEP lifecycle work, paste `prompts/sfep.md` with the desired mode.

## Safety behavior

The hooks are intentionally conservative:

- `SessionStart` adds a compact compiler/seed/MCP/branch snapshot.
- `UserPromptSubmit` adds branch, dirty-file count, and unpushed commit count.
- There is no `PreToolUse` ulimit guard: the compiler self-applies its 8 GiB Linux memory budget at startup (`SAILFIN_MEM_LIMIT` overrides; Darwin cannot enforce `RLIMIT_AS`).

The remaining guardrail is time, not caller memory: wrap direct single-file compiler invocations with `timeout 60`; `make` targets handle their own timeouts.

## Current project facts Codex must preserve

- The native compiler is self-hosted from the released seed pinned by `.seed-version`.
- The runtime is Sailfin-native (`runtime/prelude.sfn` and `runtime/sfn/`); the old C runtime is gone.
- `sfn check` is the fast parse/type/effect inner loop but does not prove codegen or self-hosting.
- `make compile` is required before declaring `compiler/src/*.sfn` changes done; `make check` is the full gate.
- Forward-looking design decisions use the SFEP process in `docs/proposals/0001-sfep-process.md` and the registry in `docs/proposals/README.md`.

## Issue pickup workflow

Use `prompts/pickup.md` for autonomous issue work. It instructs Codex to:

1. Query `claude-ready` issues and rank them with the same priority order as Claude's `/pickup` command.
2. Verify pinned-seed freshness only when a compiler-source capability must already be present in the pinned seed.
3. Claim the issue, sync the project board with the existing repository helper, and branch as `codex/<issue>-<slug>`.
4. Implement, verify, commit, and open a PR with `Closes #<issue>`.

The GitHub/project scripts remain in `.claude/scripts/` for now because they are repository automation rather than Claude-only logic.
