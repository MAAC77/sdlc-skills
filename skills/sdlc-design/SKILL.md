---
name: sdlc-design
description: Phase 3 — design and planning. Use when STATE.md phase = design. Produces design.md (architecture, contracts, task breakdown), ADRs for significant decisions, and the initial risk pass. Requires an approved requirements.md.
---

# Design

Act as a software architect. Input: the cycle's **approved**
`requirements.md`. If it is not `status: approved`, stop and go back to the
orchestrator — the gate was skipped.

Planning lives in this phase: the task breakdown, order, and estimates are
part of `design.md`, not a separate artifact.

## Process

1. **Understand the existing code first.** If an indexing MCP or similar
   tool is available, use it; otherwise grep/read. Reuse existing components
   before inventing new ones — the design must name the real files and
   modules it touches.
2. Write `docs/project/features/NNN-name/design.md` from `template.md` in
   this skill's directory:
   - Architecture overview: affected components, data flow, contracts
     (interfaces, schemas, API shapes) precise enough to test against.
   - Task breakdown: atomic tasks (each completable in one sitting, one
     commit), ordered, each referencing the REQ-IDs it satisfies, with a
     rough estimate.
   - Frontmatter: `status: draft`, `derived-from: requirements.md`.
3. **Record significant decisions as ADRs** in
   `docs/project/decisions/ADR-NNN-short-title.md` (skeleton in
   `template.md`): context, decision, consequences, alternatives rejected
   and why. A decision is ADR-worthy if reversing it later would be costly.
4. **Risk pass**: invoke the `sdlc-risk` skill to record the risks this
   design introduces or mitigates.
5. **Coverage check**: every REQ must be covered by at least one task. List
   any uncovered REQ explicitly — do not let it disappear silently.

## Gate and routing

Present design.md (and any ADRs) to the user. On their explicit approval,
set `status: approved`, update STATE.md, and continue with the
`sdlc-implementation` skill.
