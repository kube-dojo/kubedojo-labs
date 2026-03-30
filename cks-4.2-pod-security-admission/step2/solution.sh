#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: restricted-ok
  namespace: psa-restricted
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: busybox
    image: busybox
    command: ["sleep", "3600"]
    securityContext:
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
YAML
kubectl wait --for=condition=Ready pod/restricted-ok -n psa-restricted --timeout=60s
kubectl get pod restricted-ok -n psa-restricted -o wide > /root/restricted-ok.txt

kubectl run restricted-fail --image=nginx -n psa-restricted > /root/restricted-fail.txt 2>&1 || true

cat > /root/restricted-requirements.txt << 'REQS'
Pod Security Standards — Restricted Level Requirements:
1. runAsNonRoot must be true (or runAsUser > 0)
2. seccompProfile must be RuntimeDefault or Localhost
3. allowPrivilegeEscalation must be false
4. capabilities must drop ALL (may add NET_BIND_SERVICE only)
5. No privileged containers
6. No hostNetwork, hostPID, or hostIPC
7. No hostPath volumes
8. No hostPorts
REQS
