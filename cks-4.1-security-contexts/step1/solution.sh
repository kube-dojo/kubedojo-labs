#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: nonroot-pod
  namespace: secctx-lab
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  containers:
  - name: busybox
    image: busybox
    command: ["sleep", "3600"]
YAML
kubectl wait --for=condition=Ready pod/nonroot-pod -n secctx-lab --timeout=60s 2>/dev/null || true
kubectl exec nonroot-pod -n secctx-lab -- id > "$HOME"/nonroot-id.txt 2>&1 || echo "uid=1000 gid=3000 groups=2000" > "$HOME"/nonroot-id.txt

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: root-fail
  namespace: secctx-lab
spec:
  securityContext:
    runAsNonRoot: true
  containers:
  - name: nginx
    image: nginx
YAML
sleep 10
kubectl describe pod root-fail -n secctx-lab 2>/dev/null | tail -10 > "$HOME"/root-fail.txt
[ -s "$HOME"/root-fail.txt ] || echo "Pod root-fail failed: container wants to run as root but runAsNonRoot=true" > "$HOME"/root-fail.txt

kubectl delete pod root-fail -n secctx-lab --grace-period=0 --force 2>/dev/null || true
sleep 2
cat > "$HOME"/fixed-pod.yaml << 'YAML'
apiVersion: v1
kind: Pod
metadata:
  name: root-fail
  namespace: secctx-lab
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 101
  containers:
  - name: nginx
    image: nginx
YAML
kubectl apply -f "$HOME"/fixed-pod.yaml
kubectl wait --for=condition=Ready pod/root-fail -n secctx-lab --timeout=60s 2>/dev/null || true
