#!/bin/bash
# Setup script — runs before user starts

# Wait for cluster to be ready
kubectl wait --for=condition=Ready node --all --timeout=120s 2>/dev/null


# Set up aliases
_seed_k_bashrc() {
  local home line
  for home in /root /home/ubuntu; do
    [ -d "$home" ] || continue
    touch "$home/.bashrc"
    for line in "$@"; do
      grep -qxF "$line" "$home/.bashrc" 2>/dev/null || echo "$line" >> "$home/.bashrc"
    done
  done
}
_seed_k_bashrc \
  'alias k=kubectl' \
  'source <(kubectl completion bash)' \
  'complete -o default -F __start_kubectl k'
# Create practice namespace
kubectl create namespace practice --dry-run=client -o yaml | kubectl apply -f -

# Create a PV and PVC with data for snapshot exercise
mkdir -p /mnt/data/snapshot-source
echo "Important data to snapshot" > /mnt/data/snapshot-source/data.txt

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: snapshot-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/data/snapshot-source
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: source-pvc
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: manual
EOF

echo "Kubernetes cluster ready."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
