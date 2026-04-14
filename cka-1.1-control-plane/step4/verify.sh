#!/bin/bash
set -euo pipefail

fail() {
  echo "FAIL: $1"
  exit 1
}

python3 - <<'PY' || exit 1
from pathlib import Path

text = Path("/etc/kubernetes/manifests/kube-scheduler.yaml").read_text()
if "--kubeconfig=/etc/kubernetes/scheduler.conf" not in text:
    raise SystemExit("FAIL: kube-scheduler manifest does not reference /etc/kubernetes/scheduler.conf")
if "/etc/kubernetes/broken-scheduler.conf" in text:
    raise SystemExit("FAIL: kube-scheduler manifest still references the broken kubeconfig")
PY

scheduler_pod=$(kubectl get pods -n kube-system -l component=kube-scheduler -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || true)
[ -n "${scheduler_pod}" ] || fail "No kube-scheduler pod found"

smoke_phase=$(kubectl get pod scheduler-smoke -n practice -o jsonpath='{.status.phase}' 2>/dev/null || true)
[ "${smoke_phase}" = "Running" ] || fail "scheduler-smoke is not Running"

smoke_node=$(kubectl get pod scheduler-smoke -n practice -o jsonpath='{.spec.nodeName}' 2>/dev/null || true)
[ -n "${smoke_node}" ] || fail "scheduler-smoke does not have a node assignment"

echo "PASS: Scheduler configuration is restored and scheduler-smoke is scheduled."
