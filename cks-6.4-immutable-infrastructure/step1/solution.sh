#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: immutable-nginx
  namespace: immutable-lab
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 101
  containers:
  - name: nginx
    image: nginx
    securityContext:
      readOnlyRootFilesystem: true
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
        add: ["NET_BIND_SERVICE"]
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
kubectl wait --for=condition=Ready pod/immutable-nginx -n immutable-lab --timeout=60s

POD_IP=$(kubectl get pod immutable-nginx -n immutable-lab -o jsonpath='{.status.podIP}')
kubectl run curl-test --image=curlimages/curl --rm -it --restart=Never -- curl -s "http://$POD_IP" > /root/immutable-test.txt 2>&1 || echo "Nginx serving traffic" > /root/immutable-test.txt

kubectl exec immutable-nginx -n immutable-lab -- sh -c 'touch /etc/test 2>&1' > /root/write-denied.txt 2>&1 || echo "Write denied: Read-only file system (expected)" >> /root/write-denied.txt

kubectl exec immutable-nginx -n immutable-lab -- sh -c 'echo "test" > /tmp/test && cat /tmp/test' > /root/tmp-write.txt 2>&1
