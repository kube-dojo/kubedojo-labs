#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s

_seed_k_bashrc() {
  local home line
  for home in /root /home/ubuntu; do
    [ -d "$home" ] || continue
    touch "$home/.bashrc"
    for line in "$@"; do
      grep -qxF "$line" "$home/.bashrc" 2>/dev/null || echo "$line" >> "$home/.bashrc"
    done
  done
}
_seed_k_bashrc \
  'alias k=kubectl'
kubectl create namespace investigation

# Deploy a "compromised" pod
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: suspicious-pod
  namespace: investigation
  labels:
    app: suspicious
spec:
  containers:
  - name: app
    image: nginx
    command: ["/bin/sh", "-c"]
    args:
    - |
      # Simulate compromise indicators
      echo "malicious-process" > /tmp/malware.sh
      chmod +x /tmp/malware.sh
      echo "* * * * * /tmp/malware.sh" > /tmp/crontab
      echo "stolen-data" > /tmp/exfil.txt
      nginx -g 'daemon off;'
YAML
kubectl wait --for=condition=Ready pod/suspicious-pod -n investigation --timeout=60s 2>/dev/null || true
echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
