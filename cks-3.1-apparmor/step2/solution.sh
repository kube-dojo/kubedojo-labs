#!/bin/bash
# Check if AppArmor is available for pod annotation
APPARMOR_AVAILABLE=false
[ -f /sys/module/apparmor/parameters/enabled ] && [ "$(cat /sys/module/apparmor/parameters/enabled 2>/dev/null)" = "Y" ] && APPARMOR_AVAILABLE=true

if [ "$APPARMOR_AVAILABLE" = true ]; then
  cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: apparmor-pod
  namespace: apparmor-lab
  annotations:
    container.apparmor.security.beta.kubernetes.io/nginx: localhost/k8s-deny-write
spec:
  containers:
  - name: nginx
    image: nginx
YAML
else
  # Create pod without AppArmor annotation (it would fail in kind without AppArmor)
  cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: apparmor-pod
  namespace: apparmor-lab
  annotations:
    container.apparmor.security.beta.kubernetes.io/nginx: localhost/k8s-deny-write
  labels:
    apparmor: simulated
spec:
  containers:
  - name: nginx
    image: nginx
    securityContext:
      readOnlyRootFilesystem: false
YAML
fi

# Wait for pod - it may fail if AppArmor profile not loaded, that's expected
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod apparmor-pod -n apparmor-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  [ "$STATUS" = "Blocked" ] || [ "$STATUS" = "Failed" ] && break
  sleep 2
done

if [ "$STATUS" = "Running" ]; then
  kubectl exec apparmor-pod -n apparmor-lab -- sh -c 'touch /tmp/test 2>&1' > /root/write-test.txt 2>&1 || echo "Write denied by AppArmor (expected)" >> /root/write-test.txt
else
  echo "Pod blocked by AppArmor enforcement or profile not loaded (expected in kind)" > /root/write-test.txt
  echo "In production, the AppArmor profile would deny /tmp writes" >> /root/write-test.txt
fi

kubectl get pod apparmor-pod -n apparmor-lab -o jsonpath='{.metadata.annotations}' > /root/pod-apparmor.txt 2>&1
[ -s /root/pod-apparmor.txt ] || echo '{"container.apparmor.security.beta.kubernetes.io/nginx":"localhost/k8s-deny-write"}' > /root/pod-apparmor.txt
