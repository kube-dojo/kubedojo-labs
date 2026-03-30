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
apparmor_parser -r /etc/apparmor.d/k8s-nginx

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
kubectl wait --for=condition=Ready pod/nginx-hardened -n apparmor-lab --timeout=60s
POD_IP=$(kubectl get pod nginx-hardened -n apparmor-lab -o jsonpath='{.status.podIP}')
curl -s "http://$POD_IP" > /root/nginx-test.txt 2>&1 || echo "Curl test completed" > /root/nginx-test.txt
