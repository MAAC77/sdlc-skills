---
name: sdlc-risk
description: Umbrella skill — risk register. Invocable from any phase; the design phase always runs it. Maintains docs/project/risks.md.
---

# Risk Register

Act as the person who asks "what could make this fail?" while everyone else
is building. Maintain `docs/project/risks.md` — create it from the skeleton
below if it doesn't exist.

## When invoked

1. Review existing risks: did any materialize? Can any be closed?
2. Add new risks: for the current cycle, ask what could invalidate the
   design, blow the estimate, or hurt users. Technical, schedule, and
   dependency risks all count.
3. For every open risk with high probability or high impact, there must be
   a mitigation or an explicit user decision to accept it.
4. Surface to the user only what changed — not the whole register.

## Skeleton for `docs/project/risks.md`

```markdown
# Risk register

| ID     | Risk | Prob. | Impact | Mitigation / acceptance | Status |
|--------|------|-------|--------|--------------------------|--------|
| RISK-001 |    | H/M/L | H/M/L  |                          | open   |
```

Statuses: `open`, `mitigated`, `accepted` (user decision, note why),
`closed`, `materialized` (note what it cost — feeds the retro).
