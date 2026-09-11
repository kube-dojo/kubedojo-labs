#!/bin/bash
cat > "$HOME"/daily-backup.yaml << 'EOF'
apiVersion: kubedojo.io/v1
kind: Backup
metadata:
  name: daily-backup
  namespace: default
spec:
  schedule: "0 2 * * *"
  target: "etcd"
  retention: 7
EOF

kubectl apply -f "$HOME"/daily-backup.yaml
echo ""
echo "Backup resources:"
kubectl get backups.kubedojo.io
echo ""
echo "Backup details:"
kubectl describe backup daily-backup
