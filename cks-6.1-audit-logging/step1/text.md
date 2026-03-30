# Create a Comprehensive Audit Policy

Design an audit policy that captures security-relevant events without overwhelming log storage.

## Task

1. Create an audit policy at `/etc/kubernetes/audit/policy.yaml` with these rules (in order):
   - Skip logging for requests to `/healthz`, `/readyz`, `/livez` endpoints
   - Log Secret operations at `Metadata` level (avoid logging secret data)
   - Log token creation and authentication at `Metadata` level
   - Log changes to RBAC resources (roles, rolebindings, clusterroles, clusterrolebindings) at `RequestResponse` level
   - Log pod creation/deletion at `Request` level
   - Log all other resources at `Metadata` level
2. Validate the policy has the correct apiVersion (`audit.k8s.io/v1`) and kind (`Policy`).
3. Save a count of rules to `/root/audit-rule-count.txt`.

## Hint

Audit policy rules are evaluated in order — first match wins. Use `level: None` to skip noisy endpoints. Use `nonResourceURLs` for health endpoints.
