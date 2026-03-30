#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done
echo 'alias k=kubectl' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace debug-lab

# Crashing pod
kubectl run crasher --image=busybox:1.36 -n debug-lab -- sh -c "echo starting; exit 1"

# Pod with excessive resource request
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pending-pod
  namespace: debug-lab
spec:
  containers:
  - name: app
    image: nginx:1.25
    resources:
      requests:
        cpu: "100"
        memory: "1000Gi"
YAML

echo "Cluster is ready!"
