#!/bin/bash
# Compatibility entry point; selection and exit propagation live in the manifest driver.
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
exec python3 "$REPO_ROOT/scripts/ci/run-scenarios.py" --backend kubernetes-kubeadm-1node "$@"
