#!/bin/bash
set -euo pipefail

MANIFEST=/etc/kubernetes/manifests/kube-apiserver.yaml
BACKUP=/var/tmp/kube-apiserver.before-step3.yaml

cp "${MANIFEST}" "${BACKUP}"

python3 - "${MANIFEST}" <<'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
lines = path.read_text().splitlines()
target = "    - --event-ttl=2h0m0s"

if any("--event-ttl=" in line for line in lines):
    updated = [target if "--event-ttl=" in line else line for line in lines]
else:
    updated = []
    inserted = False
    for line in lines:
        updated.append(line)
        if not inserted and line.strip() == "- kube-apiserver":
            updated.append(target)
            inserted = True
    if not inserted:
        raise SystemExit("Could not find kube-apiserver command list")

path.write_text("\n".join(updated) + "\n")
PY

echo "Updated manifest. Confirm with:"
echo "  kubectl get pods -n kube-system -l component=kube-apiserver"
echo "  pgrep -af kube-apiserver"
