#!/bin/sh
# check-trace.sh — REQ-ID traceability check, both directions.
#
#   scripts/sdlc/check-trace.sh <feature-dir> <test-dir> [test-dir...]
#
# Direction 1: acceptance-criterion IDs (REQ-NNN-ACn) declared in
#              <feature-dir>/requirements.md that no test file references.
# Direction 2: REQ-NNN IDs referenced in test files that don't exist in
#              requirements.md.
# Exit 0 = clean, 1 = findings, 2 = usage error.

set -eu

FEATURE="${1:-}"
[ -n "$FEATURE" ] && [ $# -ge 2 ] || {
    echo "usage: $0 <feature-dir> <test-dir> [test-dir...]" >&2; exit 2; }
shift
REQS="$FEATURE/requirements.md"
[ -f "$REQS" ] || { echo "error: $REQS not found" >&2; exit 2; }

TMP="${TMPDIR:-/tmp}/check-trace.$$"
mkdir -p "$TMP"
trap 'rm -rf "$TMP"' EXIT

# IDs declared in requirements.md
grep -oE 'REQ-[0-9]+-AC[0-9]+' "$REQS" | sort -u > "$TMP/declared_acs"
grep -oE '(REQ|NFR)-[0-9]+' "$REQS" | sort -u > "$TMP/declared_reqs"

# IDs referenced anywhere under the test dirs (case-insensitive: test names
# are often lowercase, e.g. test_req_001_ac1)
grep -rioE '(req|nfr)[-_][0-9]+([-_]ac[0-9]+)?' "$@" 2>/dev/null \
    | sed 's/^.*://' \
    | tr 'a-z_' 'A-Z-' | sort -u > "$TMP/referenced" || true
grep -E '\-AC[0-9]+$' "$TMP/referenced" > "$TMP/referenced_acs" || true
sed -E 's/-AC[0-9]+$//' "$TMP/referenced" | sort -u > "$TMP/referenced_reqs"

STATUS=0

# Direction 1: declared criteria never referenced by a test
UNCOVERED="$(comm -23 "$TMP/declared_acs" "$TMP/referenced_acs")"
if [ -n "$UNCOVERED" ]; then
    STATUS=1
    echo "UNCOVERED — criteria in $REQS with no referencing test:"
    echo "$UNCOVERED" | sed 's/^/  /'
fi

# Direction 2: requirements referenced by tests but not declared
PHANTOM="$(comm -13 "$TMP/declared_reqs" "$TMP/referenced_reqs")"
if [ -n "$PHANTOM" ]; then
    STATUS=1
    echo "PHANTOM — IDs referenced in tests but absent from $REQS:"
    echo "$PHANTOM" | sed 's/^/  /'
fi

[ "$STATUS" -eq 0 ] && echo "trace clean: every criterion has a test, every referenced ID exists"
exit "$STATUS"
