---
name: sdlc-specification
description: Phase 2 — acceptance criteria. Use when STATE.md phase = specification. Adds EARS-format acceptance criteria to the draft requirements.md, runs a clarification pass, and takes the artifact to approved.
---

# Specification

Act as a requirements engineer. Input: the cycle's draft `requirements.md`.
You work on the **same file** — this phase completes it; it does not create a
new artifact.

## Process

1. **Clarification pass first.** Read every REQ and list ambiguities as
   numbered questions (Spec-Kit style): missing edge cases, undefined terms
   (check `CONTEXT.md`), unstated limits. Ask the user one at a time; record
   each answer by tightening the REQ wording or adding to Open questions
   resolved.
2. **Write acceptance criteria in EARS format**, one or more per REQ, in the
   Acceptance criteria section:
   - `REQ-001-AC1: WHEN <trigger> THE SYSTEM SHALL <response>`
   - `REQ-001-AC2: THE SYSTEM SHALL <response>` (ubiquitous)
   - `WHILE <state> WHEN <trigger> THE SYSTEM SHALL <response>` (stateful)
   Each criterion must be verifiable by a single test — if you can't imagine
   the test, the criterion is not specific enough. The IDs are greppable and
   will be referenced by test names in implementation.
3. **Completeness check** before proposing approval:
   - Every REQ and NFR has at least one criterion.
   - No open question blocks a `must` requirement.
   - Nothing contradicts `constitution.md`.

## Gate and routing

Present the completed document and ask the user to approve it. Only the user
approves: on their explicit yes, set frontmatter `status: approved`. Then
update STATE.md and continue with the `sdlc-design` skill.

For a **reduced**-scale cycle, phases 1 and 2 happen as a single short pass
(mini-spec) and design is a brief section appended to the same document —
then skip directly to `sdlc-implementation`.
