# Set Up Audit Logging Infrastructure

Kubernetes audit logging records API requests for security monitoring. Configure a basic audit policy.

## Task

1. Create an audit policy file at `/etc/kubernetes/audit/audit-policy.yaml` with the following rules:
   - Log all requests to secrets at the `Metadata` level
   - Log all requests to pods at the `Request` level
   - Log everything else at `None` level
2. The file must be a valid Kubernetes audit policy (apiVersion: `audit.k8s.io/v1`, kind: `Policy`).
3. Save the number of rules in your policy to `/root/audit-rule-count.txt`.

## Hint

Refer to the Kubernetes documentation for audit policy format: `audit.k8s.io/v1` API group, kind `Policy`, with a `rules` list.
