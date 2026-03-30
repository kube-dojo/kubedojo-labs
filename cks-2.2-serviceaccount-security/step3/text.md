# Restrict ServiceAccount Permissions and Audit

Audit all ServiceAccounts and their effective permissions across the cluster.

## Task

1. List all ServiceAccounts in all namespaces and save to `/root/all-service-accounts.txt`.
2. For each ServiceAccount in `sa-lab`, check if it can list secrets and save results to `/root/sa-permissions.txt`.
3. Find any ServiceAccount tokens stored as Secrets (type `kubernetes.io/service-account-token`) and save to `/root/legacy-tokens.txt`.
4. Create `/root/sa-hardening.txt` with 4 ServiceAccount security best practices.

## Hint

Use `kubectl get secrets -A --field-selector type=kubernetes.io/service-account-token` to find legacy tokens.
