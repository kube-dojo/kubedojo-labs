#!/bin/bash
cat > /root/hardened-pod.yaml << 'YAML'
apiVersion: v1
kind: Pod
metadata:
  name: hardened-complete
  namespace: kernel-lab
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: nginx
    image: nginx
    securityContext:
      readOnlyRootFilesystem: true
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
    volumeMounts:
    - name: cache
      mountPath: /var/cache/nginx
    - name: run
      mountPath: /var/run
    - name: tmp
      mountPath: /tmp
  volumes:
  - name: cache
    emptyDir: {}
  - name: run
    emptyDir: {}
  - name: tmp
    emptyDir: {}
YAML
kubectl apply -f /root/hardened-pod.yaml
kubectl wait --for=condition=Ready pod/hardened-complete -n kernel-lab --timeout=60s 2>&1 || true

cat > /root/hardening-checklist.txt << 'CHECKLIST'
1. runAsNonRoot: true — prevents running as root
2. runAsUser: 1000 — explicit non-root user
3. readOnlyRootFilesystem: true — prevents filesystem writes
4. allowPrivilegeEscalation: false — blocks setuid/setgid
5. capabilities.drop: ALL — removes all Linux capabilities
6. seccompProfile: RuntimeDefault — restricts dangerous syscalls
7. emptyDir volumes — provides limited writable space for required paths only
CHECKLIST
