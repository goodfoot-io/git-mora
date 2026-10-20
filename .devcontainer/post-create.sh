#!/usr/bin/env bash
set -euo pipefail
cd /workspace
/usr/local/share/devcontainer/post-create-common.sh
if ! git config --global --get-all safe.directory | grep -Fx /workspace >/dev/null; then
  git config --global --add safe.directory /workspace
fi
yarn install --immutable
yarn build:local
