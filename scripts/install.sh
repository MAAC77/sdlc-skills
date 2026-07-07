#!/bin/sh
# install.sh — vendor the sdlc-skills template into a project.
#
#   ./scripts/install.sh <target-project> [skills-dest]
#
# skills-dest defaults to .claude/skills (opencode reads it too); pass
# .agents/skills or another directory if your harness prefers it.
# Idempotent: re-run to upgrade. Never touches the project's docs/project/.

set -eu

TARGET="${1:-}"
DEST="${2:-.claude/skills}"

if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
    echo "usage: $0 <target-project-dir> [skills-dest]" >&2
    exit 1
fi

REPO="$(cd "$(dirname "$0")/.." && pwd)"
VERSION="$(cat "$REPO/VERSION" 2>/dev/null || echo unknown)"

# Skills
mkdir -p "$TARGET/$DEST"
for skill in "$REPO"/skills/*/; do
    name="$(basename "$skill")"
    rm -rf "$TARGET/$DEST/$name"
    cp -R "$skill" "$TARGET/$DEST/$name"
done

# Trace script
mkdir -p "$TARGET/scripts/sdlc"
cp "$REPO/scripts/check-trace.sh" "$TARGET/scripts/sdlc/check-trace.sh"
chmod +x "$TARGET/scripts/sdlc/check-trace.sh"

# Version marker (lets a future upgrade know what's installed)
echo "$VERSION" > "$TARGET/$DEST/.sdlc-template-version"

# Root pointer for harnesses — only if the project has none
if [ ! -f "$TARGET/AGENTS.md" ]; then
    cat > "$TARGET/AGENTS.md" <<EOF
# Project process

This project follows the sdlc-skills process (v$VERSION).

- Before any task, read \`docs/project/STATE.md\` — it says what phase the
  project is in and what the next step is.
- The process guides live in \`$DEST/sdlc*/SKILL.md\`. Start with the
  orchestrator: \`$DEST/sdlc/SKILL.md\`. If your harness supports skills,
  invoke \`sdlc\`; otherwise read that file and follow it.
- Before ending any session, follow \`$DEST/sdlc-handoff/SKILL.md\`.
EOF
    echo "created $TARGET/AGENTS.md"
else
    echo "note: $TARGET/AGENTS.md already exists — not touched." \
         "Ensure it points to docs/project/STATE.md and $DEST/sdlc/SKILL.md"
fi

echo "installed sdlc-skills v$VERSION into $TARGET ($DEST)"
echo "next: open your agent in the project and ask it to use the 'sdlc' skill"
