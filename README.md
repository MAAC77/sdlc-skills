# sdlc-skills

A portable skills template (open `SKILL.md` standard) that encodes a complete
software development lifecycle — requirements → specification → design →
implementation → verification → delivery — based on Pressman's software
engineering framework. Works with any agent harness that reads skills or
plain markdown (Claude Code, opencode, Codex CLI, ...).

## Why

Agent sessions lose context: decisions get buried in old chats, and agents
jump straight to code without eliciting requirements or designing. This
template makes **files, not conversation, the source of truth**:

- Every phase reads the previous phase's artifact and produces its own.
- `docs/project/STATE.md` (~10 lines) is the single entry point: any fresh
  session — any harness, any device — reads it and resumes exactly where the
  last one stopped.
- Explicit **gates**: an artifact needs `status: approved` (only the user
  approves) before the next phase starts.
- Requirements carry greppable IDs (`REQ-001`) traced through design tasks,
  test names, and commits; `check-trace.sh` reports orphans mechanically.

## Install

```sh
./scripts/install.sh /path/to/your/project
```

This copies the skills into the project's `.claude/skills/` (pass a second
argument to change the destination, e.g. `.agents/skills`), puts
`check-trace.sh` in `scripts/sdlc/`, records the template version, and
creates an `AGENTS.md` pointer if the project has none. It never touches
`docs/project/`, so re-running it to upgrade is safe. The project is
self-sufficient after installation — no dependency on this repo.

Then open your agent and ask it to use the `sdlc` skill. The first run
initializes `docs/project/` (STATE.md, constitution.md, CONTEXT.md) through a
short interview.

### Private context (shared/company repos)

If the repository is shared and you don't want your SDLC context committed:

```sh
./scripts/private-context.sh /path/to/your/project
```

This moves `docs/project/` to `~/sdlc-context/<project-name>` (pass a second
argument to change it), gives it its own git repo — so the handoff's commit
step still protects it — symlinks it back into place, and hides the link and
any untracked template files via `.git/info/exclude`. Paths keep working,
and teammates and the shared `.gitignore` are never affected.

## How it works

The `sdlc` orchestrator reads STATE.md and routes to the active phase skill.
When a new cycle (feature/fix) starts, it asks about size and risk and
proposes a scale:

| Scale       | Process |
|-------------|---------|
| **full**    | All 6 phases with gates — multi-file features, risky changes. |
| **reduced** | Mini-spec + brief design in one document → implementation → verification. |
| **direct**  | Failing test → fix → update STATE.md. Trivial fixes. |

Each cycle lives in `docs/project/features/NNN-name/` with its own
`requirements.md`, `design.md`, and `verification.md`. Umbrella skills
(`sdlc-review`, `sdlc-risk`) can be invoked from any phase, and
`sdlc-handoff` closes every session: update STATE.md, commit, push — the
conversation is disposable, the files are not.

## Structure

```
skills/
├── sdlc/                 orchestrator: reads STATE.md, picks scale, routes, enforces gates
├── sdlc-init/            one-time project setup (creates docs/project/)
├── sdlc-requirements/    phase 1 — elicitation interview, draft requirements.md with REQ-IDs
├── sdlc-specification/   phase 2 — EARS acceptance criteria per REQ, clarification pass
├── sdlc-design/          phase 3 — architecture, ADRs, task breakdown (planning lives here)
├── sdlc-implementation/  phase 4 — TDD per task, REQ-IDs in tests and commits
├── sdlc-verification/    phase 5 — traceability matrix criterion → test → result
├── sdlc-delivery/        phase 6 — release notes, retrospective, close the cycle
├── sdlc-handoff/         session-closing ritual (always)
├── sdlc-review/          umbrella — code review against design and constitution
└── sdlc-risk/            umbrella — risk register
scripts/
├── install.sh            vendoring installer (POSIX sh, zero dependencies)
├── check-trace.sh        REQ-ID traceability check, both directions
└── private-context.sh    keep docs/project/ private in a shared repo (symlink + local exclude)
```

## Portability rules

- Skills contain nothing harness-specific: no hooks, no subagents, no
  `allowed-tools`. Plain markdown + POSIX sh only.
- Harnesses without skill support still work: `AGENTS.md` points them at the
  `SKILL.md` files to read directly.
- The real portable layer is `docs/project/` — plain markdown any agent (or
  human) can read and continue from.
