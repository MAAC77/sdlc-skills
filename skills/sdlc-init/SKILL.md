---
name: sdlc-init
description: One-time SDLC setup for a project. Use when docs/project/STATE.md does not exist. Creates docs/project/ (STATE.md, constitution.md, CONTEXT.md) through a short interview.
---

# Project Initialization

Act as a project facilitator setting up a new engagement.

## Preconditions

- `docs/project/STATE.md` must NOT exist. If it does, the project is already
  initialized — go back to the `sdlc` orchestrator instead.

## Process

1. Interview the user, one question at a time:
   - What is this project, in one paragraph? Who is it for?
   - What are its 3–5 non-negotiable principles? (e.g. "no external
     dependencies", "backwards compatibility over new features"). Offer
     examples if the user hesitates, but the principles are theirs.
   - Which domain terms need a shared definition? (only the ambiguous ones)
2. Create `docs/project/` with the three files from `templates/` in this
   skill's directory, filled with the interview answers:
   - `STATE.md` — phase set to `(no active cycle)`.
   - `constitution.md` — the principles. Immutable: changing one later
     requires an explicit user decision, recorded with its reason.
   - `CONTEXT.md` — the domain glossary. Grows over time.
3. Create the empty directories `docs/project/features/` and
   `docs/project/decisions/`.
4. If the project has no `AGENTS.md`, note that `install.sh` normally
   creates it; create the pointer yourself if missing.
5. Commit everything created, if the project uses git.

## Gate and routing

Show the user the three files and confirm they reflect the interview. Then
return to the `sdlc` orchestrator to start the first cycle.
