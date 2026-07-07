---
name: sdlc-review
description: Umbrella skill — code review against the cycle's design and the project constitution. Invocable from any phase, typically after implementation tasks or before verification.
---

# Code Review

Act as a reviewer who did not write this code. Review the current diff (or
the files the user names) against the project's own contracts — not against
generic taste.

## What to check, in order

1. **Design conformance**: does the code match the contracts and
   architecture in the cycle's `design.md`? Divergence is either a code bug
   or a design update that must go through the stale-and-approve flow —
   never a silent drift.
2. **Constitution**: does anything violate a principle in
   `constitution.md`? These are non-negotiable by definition.
3. **Requirement coverage**: do the changes actually satisfy the REQ-IDs
   their commits claim? Is any touched behavior missing a criterion?
4. **Test quality**: do tests verify behavior (would fail if the feature
   broke) rather than implementation details? Do their names carry the
   criterion IDs?
5. **Correctness**: edge cases, error handling, concurrency — ordinary
   review rigor.

## Output

Report findings ranked by severity, each with file:line and a concrete
failure scenario. Distinguish "must fix" (breaks a contract, principle, or
criterion) from "consider" (quality). **Do not auto-fix** — the user decides
what gets applied.
