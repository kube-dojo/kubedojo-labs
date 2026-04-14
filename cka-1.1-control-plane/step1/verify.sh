#!/bin/bash
set -euo pipefail

fail() {
  echo "FAIL: $1"
  exit 1
}

for manifest in kube-apiserver kube-controller-manager kube-scheduler etcd; do
  [ -f "/etc/kubernetes/manifests/${manifest}.yaml" ] || fail "Missing manifest /etc/kubernetes/manifests/${manifest}.yaml"
done

for component in kube-apiserver kube-controller-manager kube-scheduler etcd; do
  pod_name=$(kubectl get pods -n kube-system -l "component=${component}" -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || true)
  [ -n "${pod_name}" ] || fail "No mirror pod found for ${component}"
done

echo "PASS: All four control plane components exist as static pod manifests and mirror pods."
