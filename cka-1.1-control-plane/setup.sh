#!/bin/bash
set -euo pipefail

kubectl wait --for=condition=Ready node --all --timeout=180s >/dev/null 2>&1

echo 'alias k=kubectl' >> /root/.bashrc
echo 'source <(kubectl completion bash)' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc

if ! command -v etcdctl >/dev/null 2>&1; then
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -qq >/dev/null
  apt-get install -y -qq etcd-client >/dev/null
fi

kubectl create namespace practice --dry-run=client -o yaml | kubectl apply -f - >/dev/null

SCHED_CONF=/etc/kubernetes/scheduler.conf
SCHED_BACKUP=/var/tmp/cka-1.1-scheduler.conf.backup
SCHED_MANIFEST=/etc/kubernetes/manifests/kube-scheduler.yaml
SCHED_MANIFEST_BACKUP=/var/tmp/cka-1.1-kube-scheduler.yaml.backup

if [ ! -f "${SCHED_BACKUP}" ]; then
  cp "${SCHED_CONF}" "${SCHED_BACKUP}"
  chmod 0644 "${SCHED_BACKUP}"
fi

if [ ! -f "${SCHED_MANIFEST_BACKUP}" ]; then
  cp "${SCHED_MANIFEST}" "${SCHED_MANIFEST_BACKUP}"
  chmod 0644 "${SCHED_MANIFEST_BACKUP}"
fi

python3 - "${SCHED_MANIFEST}" <<'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
lines = path.read_text().splitlines()
broken_flag = "    - --kubeconfig=/etc/kubernetes/broken-scheduler.conf"
updated = []
changed = False

for line in lines:
    if line.strip().startswith("- --kubeconfig="):
        updated.append(broken_flag)
        changed = True
    else:
        updated.append(line)

if not changed:
    raise SystemExit("Could not find kube-scheduler --kubeconfig flag")

path.write_text("\n".join(updated) + "\n")
PY

cat > /etc/kubernetes/broken-scheduler.conf <<'EOF'
apiVersion: v1
kind: Config
clusters: []
contexts: []
current-context: broken
users: []
EOF

kubectl delete pod scheduler-smoke -n practice --ignore-not-found >/dev/null 2>&1 || true
kubectl run scheduler-smoke \
  --image=registry.k8s.io/pause:3.9 \
  --restart=Never \
  -n practice >/dev/null 2>&1 || true

echo "Cluster ready. Scheduler misconfiguration seeded for Step 4."

if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  cp "${SCHED_BACKUP}" /home/ubuntu/cka-1.1-scheduler.conf.backup 2>/dev/null || true
  cp "${SCHED_MANIFEST_BACKUP}" /home/ubuntu/cka-1.1-kube-scheduler.yaml.backup 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
