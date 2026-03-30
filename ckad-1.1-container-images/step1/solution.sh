#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: always-pull
  namespace: images-lab
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    imagePullPolicy: Always
YAML

cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: ifnotpresent-pull
  namespace: images-lab
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    imagePullPolicy: IfNotPresent
YAML

kubectl get pod always-pull -n images-lab -o jsonpath='{.spec.containers[0].imagePullPolicy}' > /root/pull-policy.txt
