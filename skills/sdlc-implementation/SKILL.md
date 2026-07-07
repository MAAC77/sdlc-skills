---
name: sdlc-implementation
description: Phase 4 — implementation with strict TDD. Use when STATE.md phase = implementation. Works through the task breakdown in design.md, one task = one commit, REQ-IDs in test names and commit messages.
---

# Implementation

Act as a developer. Input: the cycle's **approved** `design.md` task list.
If it is not approved, stop and go back to the orchestrator.

## TDD — non-negotiable, per task

1. **RED**: write a failing test whose name or docstring contains the
   acceptance-criterion ID it verifies (e.g. `test_req_001_ac1_...`). Run
   it. **See it fail** — if it passes before you write the code, the test is
   wrong or the behavior already exists; investigate before proceeding.
2. **GREEN**: write the minimal code that makes it pass. Run the test.
3. **REFACTOR**: clean up with tests green. Follow the surrounding code's
   style, naming, and idiom.

Do not batch: never write several tests, then several implementations. One
criterion at a time.

## Working rules

- **One task = one commit.** The message references the task and its
  REQ-IDs (e.g. `task 3: pagination cursor (REQ-004)`).
- **Never edit upstream artifacts silently.** If implementation reveals a
  problem in the design or a wrong requirement: stop, set the affected
  artifact's frontmatter to `status: stale`, propose the change to the user,
  and only continue after they approve the updated artifact.
- **Check the constitution** before introducing anything structural (new
  dependency, new pattern) — if it conflicts, ask; don't rationalize.
- If an indexing MCP or similar tool is available, use it to locate code;
  otherwise grep/read. Never depend on it.
- After each task, update STATE.md's "Last progress" and "Next step" lines —
  cheap insurance against an interrupted session.

## Gate and routing

When every task in design.md is done and all tests pass, update STATE.md and
continue with the `sdlc-verification` skill. There is no user gate here —
verification is the gate.
