#!/bin/bash
cat > /root/backup-crd.yaml << 'EOF'
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: backups.kubedojo.io
spec:
  group: kubedojo.io
  names:
    plural: backups
    singular: backup
    kind: Backup
    shortNames:
    - bk
  scope: Namespaced
  versions:
  - name: v1
    served: true
    storage: true
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              schedule:
                type: string
              target:
                type: string
              retention:
                type: integer
EOF

kubectl apply -f /root/backup-crd.yaml
kubectl wait --for=condition=Established crd/backups.kubedojo.io --timeout=60s 2>/dev/null || true
echo ""
echo "CRD created:"
kubectl get crd backups.kubedojo.io
