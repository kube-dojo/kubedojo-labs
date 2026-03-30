#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: seccomp-default
  namespace: seccomp-lab
spec:
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: nginx
    image: nginx
YAML

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: seccomp-unconfined
  namespace: seccomp-lab
spec:
  securityContext:
    seccompProfile:
      type: Unconfined
  containers:
  - name: nginx
    image: nginx
YAML

kubectl wait --for=condition=Ready pod/seccomp-default -n seccomp-lab --timeout=60s
kubectl wait --for=condition=Ready pod/seccomp-unconfined -n seccomp-lab --timeout=60s

kubectl exec seccomp-default -n seccomp-lab -- unshare --user whoami > /root/default-unshare.txt 2>&1 || echo "Blocked by seccomp" >> /root/default-unshare.txt
kubectl exec seccomp-unconfined -n seccomp-lab -- unshare --user whoami > /root/unconfined-unshare.txt 2>&1 || echo "May also fail due to other restrictions" >> /root/unconfined-unshare.txt

cat > /root/seccomp-types.txt << 'TYPES'
RuntimeDefault: Uses the container runtime's default seccomp profile (blocks ~50 dangerous syscalls)
Unconfined: No seccomp filtering — all syscalls allowed (least secure)
Localhost: Uses a custom seccomp profile from the node's filesystem (/var/lib/kubelet/seccomp/)
TYPES
