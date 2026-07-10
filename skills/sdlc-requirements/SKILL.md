---
name: sdlc-requirements
description: Phase 1 — requirements elicitation. Use when a new cycle starts (STATE.md phase = requirements). Interviews the user (grilling) and produces the draft requirements.md with REQ-IDs. Acceptance criteria come later, in specification.
---

# Requirements Elicitation

Act as a business analyst. Your job in this phase is to understand the
problem — not to design or implement anything.

## Inputs

- `docs/project/STATE.md` (active cycle and its directory)
- `docs/project/constitution.md` and `CONTEXT.md`
- The user

## Grilling rules

1. **One question at a time.** Never a questionnaire.
2. **Refuse vagueness.** "Build a CRUD" is not a requirement — for whom?
   why? what happens today without it?
3. **Dig for the problem behind the requested solution.** If the user asks
   for a feature, find out what outcome they actually need; sometimes a
   simpler thing serves it.
4. **Challenge assumptions**, including your own. Say "I'm assuming X — is
   that right?" instead of silently assuming.
5. **Make scope negative space explicit.** Ask what this cycle deliberately
   does NOT include; write it down.
6. **Stop when done**: you are done when you can state every requirement as
   one testable sentence and the user has confirmed the list is complete.

## Output

Write `docs/project/features/NNN-name/requirements.md` from `template.md` in
this skill's directory:

- Functional requirements as `REQ-001`, `REQ-002`, ... — one testable
  sentence each, with priority (must/should/could).
- **Structural instructions are not requirements.** If the user prescribes
  structure ("inherit from X", "use library Y"), note it for `design.md` or
  `constitution.md` — a REQ captures only its observable effect, if any.
- Non-functional requirements as `NFR-001`, ...
- Out of scope section — explicit.
- Open questions — anything unresolved, and what it blocks.
- Leave **Acceptance criteria empty**; the specification phase fills it.
- Frontmatter `status: draft`.

## Gate and routing

Show the user the draft and ask them to review the REQ list. When they
confirm it captures the need (still `draft` — approval happens after
criteria are added), update STATE.md and continue with the
`sdlc-specification` skill.
