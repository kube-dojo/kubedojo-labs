#!/bin/bash
kubectl get sa -A > /root/all-service-accounts.txt

echo "" > /root/sa-permissions.txt
for sa in $(kubectl get sa -n sa-lab -o jsonpath='{.items[*].metadata.name}'); do
  RESULT=$(kubectl auth can-i list secrets -n sa-lab --as=system:serviceaccount:sa-lab:$sa 2>&1)
  echo "$sa: list secrets = $RESULT" >> /root/sa-permissions.txt
done

kubectl get secrets -A --field-selector type=kubernetes.io/service-account-token > /root/legacy-tokens.txt 2>&1 || echo "No legacy tokens found" > /root/legacy-tokens.txt

cat > /root/sa-hardening.txt << 'BEST'
1. Set automountServiceAccountToken: false on ServiceAccounts and pods that do not need API access
2. Use projected tokens with short expiration and audience scoping instead of legacy tokens
3. Never bind cluster-admin to any ServiceAccount — use least-privilege roles
4. Audit ServiceAccount bindings regularly and remove unused accounts
5. Use separate ServiceAccounts per workload — never use the default ServiceAccount
BEST
