# Create a Default Deny-All Ingress Policy

The first step in network security is to deny all traffic by default, then allow only what is needed.

## Task

1. Create a NetworkPolicy named `deny-all-ingress` in the `backend` namespace that denies all ingress traffic to all pods.
2. Create a NetworkPolicy named `deny-all-egress` in the `backend` namespace that denies all egress traffic from all pods.
3. Verify that traffic from `frontend/web` to `backend/api` is blocked by running a test and saving the result to `/root/netpol-test-1.txt` (should show connection refused or timeout).

## Hint

A deny-all ingress policy uses `podSelector: {}` with `policyTypes: ["Ingress"]` and no `ingress` rules. Same pattern for egress.
