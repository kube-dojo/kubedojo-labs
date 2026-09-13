#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done

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
  'alias k=kubectl' \
  'complete -o default -F __start_kubectl k'
kubectl create namespace cm-lab

# Create a config file for step 1 (each learner home).
_APP_PROPS=$(mktemp)
cat > "$_APP_PROPS" << 'PROPS'
database.host=db.example.com
database.port=5432
app.name=myapp
PROPS
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  cp "$_APP_PROPS" "$home/app.properties"
done
rm -f "$_APP_PROPS"

echo "Cluster is ready!"


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
