---
name: sdlc
description: Orchestrator for the SDLC process. Use at the start of every session, when starting a new feature/fix/change, or when unsure what phase the project is in. Reads docs/project/STATE.md and routes to the skill for the active phase.
---

# SDLC Orchestrator

You are the process router. You do not do phase work yourself — you decide
which phase skill applies and hand over to it.

## On every invocation

1. Read `docs/project/STATE.md`.
   - If it does not exist, the project is not initialized → use the
     `sdlc-init` skill and stop here.
2. Read only the artifact of the active phase (its path is in STATE.md).
   Do not reload every artifact — STATE.md exists so you don't have to.
3. Route using the table below. If your harness cannot invoke skills
   directly, read the target `SKILL.md` file and follow it.

## Starting a new cycle (feature, fix, or change)

1. Ask the user two things: expected **size** (one line / one file /
   multiple files) and **risk** (does it touch data, security, or public
   interfaces?).
2. Propose a scale; the user confirms:

   | Scale       | Process |
   |-------------|---------|
   | **full**    | All 6 phases with gates. Multi-file features, risky changes, unfamiliar domains. |
   | **reduced** | Mini-spec (requirements + EARS criteria in one short document) → brief design section in the same document → implementation → verification. Small, well-understood features. |
   | **direct**  | Failing test → fix → update STATE.md on close. Trivial, low-risk fixes. |

3. Create `docs/project/features/NNN-short-name/` (next available number)
   and record the cycle and its scale in STATE.md.

## Routing

| Phase in STATE.md | Skill                |
|-------------------|----------------------|
| requirements      | sdlc-requirements    |
| specification     | sdlc-specification   |
| design            | sdlc-design          |
| implementation    | sdlc-implementation  |
| verification      | sdlc-verification    |
| delivery          | sdlc-delivery        |

## Gates (non-negotiable)

A phase artifact must carry `status: approved` in its frontmatter before the
next phase starts. **Only the user approves.** If the user asks for work
beyond the gate, show what is pending approval and ask for explicit approval
or a scale change — do not silently skip the gate.

## Umbrella skills

`sdlc-review` (code review) and `sdlc-risk` (risk register) may be invoked
from any phase. `sdlc-handoff` MUST run before ending any session.
