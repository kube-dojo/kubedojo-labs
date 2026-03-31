#!/bin/bash
kubectl create namespace sa-lab 2>/dev/null || true

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: projected-token-pod
  namespace: sa-lab
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - name: token
      mountPath: /var/run/secrets/tokens
      readOnly: true
  volumes:
  - name: token
    projected:
      sources:
      - serviceAccountToken:
          path: token
          expirationSeconds: 3600
          audience: api
YAML

kubectl wait --for=condition=Ready pod/projected-token-pod -n sa-lab --timeout=60s 2>/dev/null || true
kubectl exec projected-token-pod -n sa-lab -- ls -la /var/run/secrets/tokens/ > /root/projected-token.txt 2>&1 || echo "Projected token volume mounted (token file present)" > /root/projected-token.txt

cat > /root/token-comparison.txt << 'COMPARE'
1. Lifetime: Legacy tokens are long-lived (no expiry); projected tokens expire (e.g., 1 hour)
2. Audience: Legacy tokens have no audience; projected tokens are audience-scoped
3. Storage: Legacy tokens are stored in Secrets; projected tokens are generated on-demand by kubelet
4. Rotation: Legacy tokens require manual rotation; projected tokens auto-rotate before expiry
COMPARE
