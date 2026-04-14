#!/bin/bash
set -euo pipefail

fail() {
  echo "FAIL: $1"
  exit 1
}

python3 - <<'PY' || exit 1
from pathlib import Path

manifest = Path("/etc/kubernetes/manifests/kube-apiserver.yaml")
text = manifest.read_text()
if "--event-ttl=2h0m0s" not in text:
    raise SystemExit("FAIL: kube-apiserver manifest does not contain --event-ttl=2h0m0s")
PY

apiserver_ready=$(kubectl get pods -n kube-system -l component=kube-apiserver -o jsonpath='{.items[0].status.containerStatuses[0].ready}' 2>/dev/null || true)
[ "${apiserver_ready}" = "true" ] || fail "kube-apiserver pod is not Ready"

apiserver_pid=$(pgrep -f 'kube-apiserver' | head -n 1 || true)
[ -n "${apiserver_pid}" ] || fail "Could not find a running kube-apiserver process"

python3 - "${apiserver_pid}" <<'PY' || exit 1
import sys

pid = sys.argv[1]
cmdline = open(f"/proc/{pid}/cmdline", "rb").read().decode("utf-8", "ignore").split("\x00")
if "--event-ttl=2h0m0s" not in cmdline:
    raise SystemExit("FAIL: running kube-apiserver process does not include --event-ttl=2h0m0s")
PY

echo "PASS: kube-apiserver manifest and running process both include --event-ttl=2h0m0s."
