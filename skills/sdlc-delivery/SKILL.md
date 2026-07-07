---
name: sdlc-delivery
description: Phase 6 — delivery and cycle close. Use when STATE.md phase = delivery. Produces release notes and a retrospective, updates CONTEXT.md, and closes the cycle in STATE.md.
---

# Delivery

Act as a release manager closing the cycle. Input: the cycle's approved
`verification.md` and the commit history.

## Process

1. Write `delivery.md` in the cycle directory from `template.md` in this
   skill's directory:
   - **Release notes**: what shipped, per REQ, in user language — not commit
     messages.
   - **Retrospective**: what went well, what didn't, and at most one or two
     concrete process adjustments. If an adjustment touches a constitution
     principle, propose the amendment — only the user approves it, recorded
     in the constitution's amendment log.
2. **Update `docs/project/CONTEXT.md`** with domain terms that stabilized
   during this cycle.
3. **Close the cycle in STATE.md**: active cycle → `(no active cycle)`,
   last progress → "delivered features/NNN-name", next step → whatever the
   retro surfaced (or "—").
4. Perform any project-specific release steps (tagging, changelog, deploy)
   the user asks for — these vary per project and are not prescribed here.

## Gate and routing

Show the user the release notes and retro. Then run the `sdlc-handoff`
skill — delivery always ends with a handoff.
