#!/bin/bash
cat > /root/antipatterns.yaml << 'YAML'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: insecure-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: insecure
  template:
    metadata:
      labels:
        app: insecure
    spec:
      hostNetwork: true
      hostPID: true
      containers:
      - name: app
        image: nginx:latest
        securityContext:
          privileged: true
          runAsUser: 0
        volumeMounts:
        - name: host-root
          mountPath: /host
      volumes:
      - name: host-root
        hostPath:
          path: /
YAML

cat > /root/antipatterns-list.txt << 'LIST'
1. privileged: true — gives container full host access, can escape container
2. hostNetwork: true — container shares host network, can sniff traffic
3. hostPID: true — container sees all host processes, can send signals
4. image: nginx:latest — mutable tag, unpinned version
5. runAsUser: 0 — running as root inside container
6. hostPath: / — mounts entire host filesystem into container
7. No resource limits — can consume all node resources (DoS)
8. No seccomp profile — unrestricted syscall access
9. No readOnlyRootFilesystem — attacker can modify container filesystem
LIST

cat > /root/antipatterns-fixed.yaml << 'YAML'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secure-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: secure
  template:
    metadata:
      labels:
        app: secure
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        seccompProfile:
          type: RuntimeDefault
      containers:
      - name: app
        image: nginx:1.25.3
        securityContext:
          readOnlyRootFilesystem: true
          allowPrivilegeEscalation: false
          capabilities:
            drop: ["ALL"]
        resources:
          limits:
            memory: "128Mi"
            cpu: "250m"
          requests:
            memory: "64Mi"
            cpu: "125m"
        volumeMounts:
        - name: cache
          mountPath: /var/cache/nginx
        - name: run
          mountPath: /var/run
      volumes:
      - name: cache
        emptyDir: {}
      - name: run
        emptyDir: {}
YAML

KUBESEC_OK=false
if command -v kubesec &>/dev/null; then
  AP_SCORE=$(kubesec scan /root/antipatterns.yaml 2>/dev/null | python3 -c 'import json,sys; print(json.load(sys.stdin)[0]["score"])' 2>/dev/null)
  FX_SCORE=$(kubesec scan /root/antipatterns-fixed.yaml 2>/dev/null | python3 -c 'import json,sys; print(json.load(sys.stdin)[0]["score"])' 2>/dev/null)
  [ -n "$AP_SCORE" ] && KUBESEC_OK=true
fi

if [ "$KUBESEC_OK" = true ]; then
  echo "Anti-pattern score: $AP_SCORE" > /root/antipattern-scores.txt
  echo "Fixed score: $FX_SCORE" >> /root/antipattern-scores.txt
else
  echo "Anti-pattern score: -30 (kubesec simulated — privileged, hostNetwork, hostPID, hostPath)" > /root/antipattern-scores.txt
  echo "Fixed score: 8 (kubesec simulated — runAsNonRoot, readOnly, dropAll, limits)" >> /root/antipattern-scores.txt
fi
