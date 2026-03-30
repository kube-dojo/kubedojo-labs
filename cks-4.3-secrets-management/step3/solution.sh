#!/bin/bash
kubectl create role secret-reader --verb=get --resource=secrets -n secrets-lab
kubectl create serviceaccount app-sa -n secrets-lab
kubectl create rolebinding secret-reader-binding --role=secret-reader --serviceaccount=secrets-lab:app-sa -n secrets-lab

{
  echo "Can get secrets: $(kubectl auth can-i get secrets -n secrets-lab --as=system:serviceaccount:secrets-lab:app-sa 2>&1)"
  echo "Can list secrets: $(kubectl auth can-i list secrets -n secrets-lab --as=system:serviceaccount:secrets-lab:app-sa 2>&1)"
  echo "Can create secrets: $(kubectl auth can-i create secrets -n secrets-lab --as=system:serviceaccount:secrets-lab:app-sa 2>&1)"
} > /root/secret-rbac-test.txt

cat > /root/secrets-best-practices.txt << 'BEST'
1. Enable encryption at rest for secrets in etcd
2. Use RBAC to restrict get/list/watch on secrets to only necessary ServiceAccounts
3. Avoid storing secrets in environment variables — use volume mounts instead
4. Rotate secrets regularly and use short-lived credentials where possible
5. Consider external secret management (HashiCorp Vault, AWS Secrets Manager)
6. Never commit secrets to version control — use sealed secrets or external refs
7. Enable audit logging for secret access to detect unauthorized reads
BEST
