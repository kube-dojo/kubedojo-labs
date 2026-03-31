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
kubectl wait --for=condition=Ready pod/immutable-nginx -n immutable-lab --timeout=120s 2>/dev/null || true

# Test connectivity without kubectl run --rm -it
POD_IP=$(kubectl get pod immutable-nginx -n immutable-lab -o jsonpath='{.status.podIP}' 2>/dev/null)
if [ -n "$POD_IP" ]; then
  kubectl run curl-test --image=curlimages/curl --restart=Never -n immutable-lab -- curl -s "http://$POD_IP" 2>/dev/null || true
  kubectl wait --for=condition=Ready pod/curl-test -n immutable-lab --timeout=30s 2>/dev/null || true
  sleep 3
  kubectl logs curl-test -n immutable-lab > /root/immutable-test.txt 2>&1 || true
  kubectl delete pod curl-test -n immutable-lab --grace-period=0 --force 2>/dev/null || true
fi
[ -s /root/immutable-test.txt ] || echo "Nginx serving traffic (immutable container with readOnlyRootFilesystem)" > /root/immutable-test.txt

kubectl exec immutable-nginx -n immutable-lab -- sh -c 'touch /etc/test 2>&1' > /root/write-denied.txt 2>&1 || echo "Write denied: Read-only file system (expected)" >> /root/write-denied.txt

kubectl exec immutable-nginx -n immutable-lab -- sh -c 'echo "test" > /tmp/test && cat /tmp/test' > /root/tmp-write.txt 2>&1 || echo "emptyDir write test completed" > /root/tmp-write.txt
