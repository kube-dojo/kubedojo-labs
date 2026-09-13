#!/bin/bash
# Setup script — runs before user starts (pre-break things!)

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

# Create host directories
mkdir -p /mnt/data/fix-storage
echo "Fixed data" > /mnt/data/fix-storage/data.txt

# Problem 1: PVC with wrong storageClassName (no matching SC exists)
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: broken-pvc-class
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: nonexistent-class
EOF

# Problem 2: PV with RWO but PVC requests RWX
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: access-mode-pv
spec:
  capacity:
    storage: 2Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: access-test
  hostPath:
    path: /mnt/data/fix-storage
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: broken-pvc-access
  namespace: practice
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
  storageClassName: access-test
EOF

# Problem 3: Pod referencing wrong PVC name
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mount-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: mount-test
  hostPath:
    path: /mnt/data/fix-storage
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: correct-pvc
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: mount-test
---
apiVersion: v1
kind: Pod
metadata:
  name: broken-mount-pod
  namespace: practice
spec:
  containers:
  - name: app
    image: nginx:1.25
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: wrong-pvc-name
EOF

# Problem 4: PVC requesting more storage than available PV
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: small-pv
spec:
  capacity:
    storage: 500Mi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: capacity-test
  hostPath:
    path: /mnt/data/fix-storage
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: broken-pvc-capacity
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: capacity-test
EOF

echo "Kubernetes cluster ready. Several broken storage resources have been created."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
