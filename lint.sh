#!/bin/bash
if which swiftlint >/dev/null; then
  swiftlint --fix
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  exit 1
fi
