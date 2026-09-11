#!/bin/bash
kubectl get clusterroles | grep admin > "$HOME"/admin-roles.txt
kubectl get sa -A > "$HOME"/service-accounts.txt

MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
PSA_FOUND=false
if [ -f "$MANIFEST" ]; then
  grep -q "PodSecurity" "$MANIFEST" && PSA_FOUND=true
else
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep -q "PodSecurity" /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null && PSA_FOUND=true
  fi
fi

if [ "$PSA_FOUND" = true ]; then
  echo "enabled" > "$HOME"/psa-status.txt
else
  echo "disabled" > "$HOME"/psa-status.txt
fi

NS_COUNT=$(kubectl get ns --no-headers | wc -l)
CR_COUNT=$(kubectl get clusterroles --no-headers | wc -l)
SA_COUNT=$(kubectl get sa -A --no-headers | wc -l)
cat > "$HOME"/security-baseline.txt << BASELINE
Namespaces: $NS_COUNT
ClusterRoles: $CR_COUNT
ServiceAccounts: $SA_COUNT
BASELINE
