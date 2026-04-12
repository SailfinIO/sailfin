When making changes to the Sailfin codebase:

- Plan before implementing: for any change touching more than one compiler pass, present the plan and get approval before writing code
- Work in small, verified steps: implement one pipeline stage at a time and test after each
- Keep changes minimal and focused: do not refactor surrounding code, add comments to unchanged code, or "improve" adjacent logic
- If a test fails after your change, diagnose the root cause before trying a different approach
