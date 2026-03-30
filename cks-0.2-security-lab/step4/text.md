# Create Security Baseline Documentation

Document the current security posture of the cluster as a baseline for future comparisons.

## Task

1. List all ClusterRoles that contain "admin" in their name and save to `/root/admin-roles.txt`.
2. List all ServiceAccounts across all namespaces and save to `/root/service-accounts.txt`.
3. Check if PodSecurityAdmission is enabled by examining the API server flags. Save "enabled" or "disabled" to `/root/psa-status.txt`.
4. Create `/root/security-baseline.txt` with a summary containing:
   - Number of namespaces
   - Number of ClusterRoles
   - Number of ServiceAccounts

## Hint

Use `kubectl get clusterroles`, `kubectl get sa -A`, and inspect the API server manifest for PodSecurity admission plugin.
