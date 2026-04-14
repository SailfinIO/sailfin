Run `make check` if it hasn't completed recently in this session.

If tests fail, diagnose one failure — identify the root cause and report it.
Do not attempt fixes autonomously; just report findings.

If tests pass, check for any uncommitted compiler changes and summarize them.

Always respect memory caps: `ulimit -v 8388608` before compiler invocations.
