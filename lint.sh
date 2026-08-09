#!/bin/bash
set -euo pipefail

if ! command -v swiftlint >/dev/null; then
  brew install swiftlint
fi

swiftlint lint --strict --no-cache
