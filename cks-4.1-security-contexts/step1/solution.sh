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
kubectl wait --for=condition=Ready pod/nonroot-pod -n secctx-lab --timeout=60s
kubectl exec nonroot-pod -n secctx-lab -- id > /root/nonroot-id.txt

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
sleep 5
kubectl describe pod root-fail -n secctx-lab | tail -10 > /root/root-fail.txt

kubectl delete pod root-fail -n secctx-lab --grace-period=0 --force 2>/dev/null
cat > /root/fixed-pod.yaml << 'YAML'
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
kubectl apply -f /root/fixed-pod.yaml
