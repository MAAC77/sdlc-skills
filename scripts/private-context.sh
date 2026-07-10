#!/bin/sh
# private-context.sh — keep docs/project/ out of a shared repository.
#
#   ./scripts/private-context.sh <target-project> [context-dir]
#
# For repositories you don't control (company/team repos): moves the
# project's SDLC context to a private directory outside the repo
# (default: ~/sdlc-context/<project-name>), gives it its own git repo so
# handoff commits still work, symlinks docs/project back to it, and hides
# the link plus any untracked template files via .git/info/exclude — the
# shared .gitignore is never touched. Idempotent: safe to re-run.

set -eu

TARGET="${1:-}"

if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
    echo "usage: $0 <target-project-dir> [context-dir]" >&2
    exit 1
fi
TARGET="$(cd "$TARGET" && pwd)"
LINK="$TARGET/docs/project"

# Resolve the private dir to an absolute path (the symlink must not break
# when invoked from elsewhere)
CONTEXT_ARG="${2:-$HOME/sdlc-context/$(basename "$TARGET")}"
mkdir -p "$CONTEXT_ARG"
CONTEXT="$(cd "$CONTEXT_ARG" && pwd)"

# Refuse to hide files the shared repo already tracks
if [ -d "$TARGET/.git" ] \
   && git -C "$TARGET" ls-files --error-unmatch docs/project >/dev/null 2>&1; then
    echo "error: docs/project is tracked by the shared repo —" \
         "untrack it deliberately before making it private" >&2
    exit 1
fi

# Migrate an existing real docs/project into the private dir
if [ -d "$LINK" ] && [ ! -L "$LINK" ]; then
    if [ -n "$(ls -A "$CONTEXT" 2>/dev/null)" ]; then
        echo "error: both $LINK and $CONTEXT have content — merge manually" >&2
        exit 1
    fi
    rmdir "$CONTEXT"
    mv "$LINK" "$CONTEXT"
    echo "moved existing docs/project to $CONTEXT"
fi

# The private dir is its own repo: the handoff's commit step lands here
if [ ! -d "$CONTEXT/.git" ] && command -v git >/dev/null 2>&1; then
    git -C "$CONTEXT" init -q
    echo "initialized git repo in $CONTEXT (add a private remote for backup)"
fi

# Symlink docs/project -> private dir
mkdir -p "$TARGET/docs"
if [ -L "$LINK" ]; then
    current="$(readlink "$LINK")"
    if [ "$current" != "$CONTEXT" ]; then
        echo "error: $LINK already links to $current — remove it first" >&2
        exit 1
    fi
elif [ -e "$LINK" ]; then
    echo "error: $LINK exists and is not a directory or symlink" >&2
    exit 1
else
    ln -s "$CONTEXT" "$LINK"
    echo "linked docs/project -> $CONTEXT"
fi

# Hide the link and untracked template files in this clone only.
# .git/info/exclude is local: teammates and the shared .gitignore never
# see these entries. Tracked paths are left alone (exclude ignores them).
if [ -d "$TARGET/.git" ]; then
    EXCLUDE="$TARGET/.git/info/exclude"
    mkdir -p "$TARGET/.git/info"
    for path in docs/project .claude/ scripts/sdlc/ AGENTS.md; do
        if git -C "$TARGET" ls-files --error-unmatch "$path" >/dev/null 2>&1; then
            continue
        fi
        if ! grep -qxF "$path" "$EXCLUDE" 2>/dev/null; then
            echo "$path" >> "$EXCLUDE"
            echo "excluded $path (this clone only)"
        fi
    done
else
    echo "note: $TARGET is not a git repository — nothing to exclude"
fi

echo "private context ready: $LINK -> $CONTEXT"