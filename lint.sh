#!/bin/bash
if which swiftlint >/dev/null; then
  swiftlint --fix
else
  brew install swiftlint
  swiftlint --fix
fi
