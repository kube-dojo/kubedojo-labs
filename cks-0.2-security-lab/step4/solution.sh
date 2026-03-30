#!/bin/bash
kubectl get clusterroles | grep admin > /root/admin-roles.txt
kubectl get sa -A > /root/service-accounts.txt
if grep -q "PodSecurity" /etc/kubernetes/manifests/kube-apiserver.yaml; then
  echo "enabled" > /root/psa-status.txt
else
  echo "disabled" > /root/psa-status.txt
fi
NS_COUNT=$(kubectl get ns --no-headers | wc -l)
CR_COUNT=$(kubectl get clusterroles --no-headers | wc -l)
SA_COUNT=$(kubectl get sa -A --no-headers | wc -l)
cat > /root/security-baseline.txt << BASELINE
Namespaces: $NS_COUNT
ClusterRoles: $CR_COUNT
ServiceAccounts: $SA_COUNT
BASELINE
