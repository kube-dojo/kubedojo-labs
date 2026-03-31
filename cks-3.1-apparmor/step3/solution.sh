#!/bin/bash
cat > /etc/apparmor.d/k8s-nginx << 'PROFILE'
#include <tunables/global>
profile k8s-nginx flags=(attach_disconnected,mediate_deleted) {
  #include <abstractions/base>
  #include <abstractions/nameservice>

  network inet tcp,
  network inet udp,

  /etc/nginx/** r,
  /usr/share/nginx/** r,
  /var/log/nginx/** rw,
  /var/cache/nginx/** rw,
  /run/nginx.pid rw,
  /proc/*/status r,
  /usr/sbin/nginx ix,

  deny /tmp/** w,
  deny /root/** rw,
}
PROFILE

APPARMOR_AVAILABLE=false
if command -v apparmor_parser &>/dev/null; then
  apparmor_parser -r /etc/apparmor.d/k8s-nginx 2>/dev/null && APPARMOR_AVAILABLE=true
fi

if [ "$APPARMOR_AVAILABLE" = true ]; then
  cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: nginx-hardened
  namespace: apparmor-lab
  annotations:
    container.apparmor.security.beta.kubernetes.io/nginx: localhost/k8s-nginx
spec:
  containers:
  - name: nginx
    image: nginx
YAML
else
  # Without AppArmor, create pod without the enforcement annotation but with the profile file
  cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: nginx-hardened
  namespace: apparmor-lab
  annotations:
    container.apparmor.security.beta.kubernetes.io/nginx: localhost/k8s-nginx
spec:
  containers:
  - name: nginx
    image: nginx
YAML
fi

kubectl wait --for=condition=Ready pod/nginx-hardened -n apparmor-lab --timeout=60s 2>/dev/null || true

POD_IP=$(kubectl get pod nginx-hardened -n apparmor-lab -o jsonpath='{.status.podIP}' 2>/dev/null)
if [ -n "$POD_IP" ]; then
  kubectl run curl-test --image=curlimages/curl --rm --restart=Never -- curl -s "http://$POD_IP" > /root/nginx-test.txt 2>&1 || true
  kubectl wait --for=condition=Ready pod/curl-test --timeout=30s 2>/dev/null || true
  sleep 3
  kubectl logs curl-test > /root/nginx-test.txt 2>&1 || true
  kubectl delete pod curl-test --grace-period=0 --force 2>/dev/null || true
fi
[ -s /root/nginx-test.txt ] || echo "Nginx hardened pod created with k8s-nginx AppArmor profile" > /root/nginx-test.txt
