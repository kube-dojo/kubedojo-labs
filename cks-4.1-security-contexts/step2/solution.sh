#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: readonly-pod
  namespace: secctx-lab
spec:
  containers:
  - name: nginx
    image: nginx
    securityContext:
      readOnlyRootFilesystem: true
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
kubectl wait --for=condition=Ready pod/readonly-pod -n secctx-lab --timeout=60s
POD_IP=$(kubectl get pod readonly-pod -n secctx-lab -o jsonpath='{.status.podIP}')
echo "Pod IP: $POD_IP" > /root/readonly-test.txt
kubectl exec readonly-pod -n secctx-lab -- curl -s localhost >> /root/readonly-test.txt 2>&1 || echo "curl not available" >> /root/readonly-test.txt
kubectl exec readonly-pod -n secctx-lab -- sh -c 'touch /etc/test 2>&1' > /root/readonly-write-test.txt 2>&1 || echo "Write denied (expected)" >> /root/readonly-write-test.txt
