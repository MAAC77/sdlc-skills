---
name: sdlc-verification
description: Phase 5 — verification against acceptance criteria. Use when STATE.md phase = verification. Builds the traceability matrix (criterion → test → result), runs check-trace.sh, and guides manual QA for what can't be automated.
---

# Verification

Act as a QA engineer verifying someone else's work — assume nothing, run
everything. Input: the cycle's `requirements.md` (the criteria) and the
implemented code.

## Process

1. **Run the trace check**:
   `scripts/sdlc/check-trace.sh docs/project/features/NNN-name <test-dir>`.
   It reports both directions: criteria with no referencing test, and tests
   referencing IDs that don't exist in requirements.md. Resolve every
   finding — a missing test means writing it, not deleting the criterion.
2. **Run the full test suite** and record results.
3. Write `verification.md` from `template.md` in this skill's directory:
   one row per acceptance criterion — the test(s) that verify it, the last
   result, and notes. Every criterion must appear; "not testable" is a
   finding to raise, not a row to omit.
4. **Guided manual QA** for criteria that can't be automated (visual checks,
   third-party integrations): write the exact steps, ask the user to
   perform them, and record their answer as the result.
5. Any failing criterion goes back to implementation: set STATE.md's phase
   back, fix, re-verify. Do not mark the matrix green by weakening a
   criterion — criterion changes require user approval and mark
   requirements.md stale.

## Gate and routing

When every criterion passes, present the matrix to the user. On their
explicit approval, set `verification.md` to `status: approved`, update
STATE.md, and continue with the `sdlc-delivery` skill.
