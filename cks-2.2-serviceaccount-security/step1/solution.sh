#!/bin/bash
kubectl create namespace sa-lab 2>/dev/null || true

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: no-api-access
  namespace: sa-lab
automountServiceAccountToken: false
YAML

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: secure-app
  namespace: sa-lab
spec:
  serviceAccountName: no-api-access
  containers:
  - name: nginx
    image: nginx
YAML

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: needs-api
  namespace: sa-lab
spec:
  automountServiceAccountToken: false
  containers:
  - name: nginx
    image: nginx
YAML

kubectl wait --for=condition=Ready pod/secure-app -n sa-lab --timeout=60s 2>/dev/null || true
kubectl wait --for=condition=Ready pod/needs-api -n sa-lab --timeout=60s 2>/dev/null || true

kubectl exec secure-app -n sa-lab -- ls /var/run/secrets/kubernetes.io/serviceaccount/token > /root/token-check.txt 2>&1 || echo "No token mounted (expected)" > /root/token-check.txt
