# Configure Egress Policies

## Task

1. Create a NetworkPolicy named `api-egress` in `netpol-lab` that:
   - Applies to pods with `app=api`
   - Allows egress only to pods with `app=db` on port 80
   - Allows egress to DNS (port 53 UDP) for name resolution
2. Save the egress policy YAML to `/root/api-egress.yaml`.

## Hint

Egress policies use `spec.egress` with `to` selectors. Always allow DNS (port 53 UDP) or pods cannot resolve service names. See the Kubernetes docs: Egress network policies.
