---
name: sdlc-handoff
description: Session-closing ritual. Use before ending ANY session, when the user says they're stopping, or when context is about to run out. Lands everything of value in files - STATE.md, commit, push. The conversation is disposable.
---

# Handoff

The conversation is about to be discarded. Anything of value that lives only
in it will be lost — your job is to make sure nothing does.

## Steps

1. **Update `docs/project/STATE.md`**, all five lines:
   - Active cycle and phase — as they actually are now.
   - Last progress — what happened this session, with the commit hash.
   - Next step — precise enough for a cold session to act on it without
     asking anything. "Continue implementation" fails this test;
     "implement task 4 of design.md (REQ-004); its test exists and fails"
     passes it.
   - Open questions — anything blocking, and which REQ it blocks.
2. **Check artifact statuses.** Every artifact touched this session has the
   frontmatter status it deserves — nothing left `approved` that the session
   invalidated, nothing left `stale` that was actually resolved.
3. **Commit and push** everything (if the project uses git and has a
   remote). Message: `handoff: <one line of what this session did>`.
4. **Reply to the user with exactly three lines**: done / next / blocked-on.

## The test

Would a fresh session — different harness, different device, zero
conversation history — resume correctly from STATE.md alone? If not,
STATE.md is not done. This is the whole point of the process.
