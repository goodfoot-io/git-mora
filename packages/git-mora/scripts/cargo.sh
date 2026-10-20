#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
mode="${1:?usage: cargo.sh build|check <cargo arguments...>}"
shift
case "$mode" in
  build|check) ;;
  *) echo "ERROR: expected build or check target directory" >&2; exit 1 ;;
esac

# Lock the independent Mora target root and provision its linker wrapper.
# Separate directories keep check metadata out of codegen fingerprints.
exec bash scripts/with-target-lock.sh shared \
  env CARGO_TARGET_DIR="${GIT_MORA_CARGO_TARGET_ROOT:-/var/cache/git-mora/cargo-target}/git-mora/$mode" \
  cargo "$@"
