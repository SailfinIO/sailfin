# Target Support Tiers

Target tiers state how strongly Sailfin's build and validation pipeline backs a
host platform. They describe **base support**: the compiler builds, its relevant
tests pass, and a matching installer asset is published. They do not describe
**sealed support**. Owned code generation, owned syscalls, and the absence of an
ungated syscall path are tracked separately in `docs/status.md` and SFEP-0016.

## Tier definitions

- **Tier 1 — primary.** The target is the primary development and release host.
  Its complete required validation is merge-blocking, and platform-specific
  safety controls used by the project are load-bearing there.
- **Tier 2 — supported.** Source changes build, self-host where applicable, and
  run the complete relevant suite in merge-blocking CI. A published installer
  asset exists. Documented platform gaps may remain, but failures in the target's
  required aggregate block pull requests and merge queues.
- **Tier 3 — best effort.** The target may be cross-built, smoke-tested, or run
  in advisory CI, but it is not part of the complete merge-blocking support
  contract. Published assets do not by themselves promote a target.

Promotion requires written evidence for the next tier's build, test,
self-hosting, release, and merge-readiness criteria. A target is demoted when it
can no longer meet its tier contract; the status matrix and public support copy
must change in the same pull request.

## Current targets

| Target | Tier | Evidence and limits |
|---|---|---|
| Linux x86_64 | **Tier 1** | Primary compiler, test, merge-queue, release, and self-host host. The compiler memory cap and complete effect enforcement are load-bearing here. |
| macOS arm64 (Apple Silicon) | **Tier 2** | Native compiler builds, tests, fixed-point validation, and a release asset are required. Effect enforcement remains partial ([#613](https://github.com/SailfinIO/sailfin/issues/613)); the compiler memory cap is not load-bearing on macOS. |
| Linux aarch64 | **Tier 2** | Source PRs and merge queues require the `aarch64-linux-result` aggregate: cross-emit, native pass-1/pass-2 fixed point, smoke probe, shard-cover, and all eight test shards. The daily scheduled workflow adds a cache-independent full suite, and v0.9.3 publishes both native and installer ARM64 assets. This is base support only; Linux aarch64 is not a capability-seal target. |
| Windows x86_64 | **Tier 3** | Natively self-hosts (SFEP-0021 M7-M9/SFN-55): a path-filtered `windows-2025` build + ABI gate (`build-compiler-windows`) blocks merges on PRs matching the Windows filter, and an unconditional nightly self-host fixed point (`windows-native-selfhost.yml`) backstops the filter. Not Tier 2: the gate is path-filtered rather than running on every PR, and `sfn test` has never run on a native Windows host — no suite coverage yet ([successor tracked, SFN-55 design note §10](../proposals/design-notes/sfn-55-windows-ci.md)). A published installer exists. |

## Linux aarch64 promotion record

Linux aarch64 earned Tier 2 through the following evidence:

- [SFN-581's post-pin validation](https://github.com/SailfinIO/sailfin/actions/runs/31032970984)
  proved the native fixed point, smoke probe, and complete suite; the
  [installer run](https://github.com/SailfinIO/sailfin/actions/runs/31033083728)
  proved native installation, architecture/version checks, hello-world, seed
  fetch, and on-device self-hosting.
- [v0.9.3](https://github.com/SailfinIO/sailfin/releases/tag/v0.9.3) publishes
  `sailfin-native-linux-arm64-0.9.3.tar.gz` and
  `sailfin_0.9.3_linux_arm64.tar.gz`. SFN-799 / PR #2882 made that pair required
  for release publication and seed pinning.
- [SFN-826 / PR #2875](https://github.com/SailfinIO/sailfin/pull/2875)
  sharded and cached the PR suite. Its live proof showed the ARM aggregate
  finishing about 54 minutes before the established required matrix.
- [Scheduled run 31384694467](https://github.com/SailfinIO/sailfin/actions/runs/31384694467)
  passed cross-emission, the native fixed point and smoke probe, and the cold
  unsharded `--no-test-cache` suite after the schedule/source split landed.
- SFN-476 made the ARM aggregate a checked dependency of `required-ci`, so a
  failed cross-emit, native compiler/probe, shard-cover check, or ARM shard makes
  the merge gate fail.

The executable topology is documented in `docs/conventions/ci-test-topology.md`;
the current base-versus-sealed support matrix lives in `docs/status.md`.
