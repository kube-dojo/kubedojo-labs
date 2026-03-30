#!/bin/bash
cat > /root/daily-backup.yaml << 'EOF'
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

kubectl apply -f /root/daily-backup.yaml
echo ""
echo "Backup resources:"
kubectl get backups.kubedojo.io
echo ""
echo "Backup details:"
kubectl describe backup daily-backup
