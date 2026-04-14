#!/bin/bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path

path = Path("/var/tmp/cka-1.1-kubectl-trace.log")
if not path.exists():
    raise SystemExit("FAIL: /var/tmp/cka-1.1-kubectl-trace.log does not exist")

text = path.read_text(errors="ignore")
required = [
    "/api/v1/namespaces/kube-system/pods",
    "Response Status:",
    "/registry/pods/kube-system/",
]
missing = [item for item in required if item not in text]
if missing:
    raise SystemExit(f"FAIL: missing expected trace markers: {', '.join(missing)}")

print("PASS: kubectl verbose trace captured the request path and response status.")
PY
