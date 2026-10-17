#!/bin/sh
# Author: Guanghui Liang

set -eu

: "${BVHOOK_NEW_VERSION:?Run this hook through bump-my-version bump.}"

# Generate before the release commit so the tag includes its own changelog.
changelog=$(mktemp)
trap 'rm -f "$changelog"' EXIT
git-chglog --next-tag "$BVHOOK_NEW_VERSION" -o "$changelog"
cat "$changelog" > CHANGELOG.md
git add -- CHANGELOG.md
