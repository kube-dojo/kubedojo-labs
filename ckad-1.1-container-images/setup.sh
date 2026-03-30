#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done
echo 'alias k=kubectl' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
source /root/.bashrc

kubectl create namespace images-lab

# Pre-create a broken pod for step 3
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: broken-app
  namespace: images-lab
spec:
  containers:
  - name: app
    image: nginx:9.99.99-nonexistent
    imagePullPolicy: Always
YAML

echo "Cluster is ready!"
