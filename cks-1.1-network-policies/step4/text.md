# Combine Ingress and Egress Policies for a Multi-Tier App

Create a complete network security posture for a three-tier application.

## Task

1. Create a NetworkPolicy named `db-policy` in the `backend` namespace that:
   - Applies to pods with label `app=db`
   - Allows ingress only from pods with label `app=api` on TCP port 80
   - Denies all egress
2. Save a summary of all NetworkPolicies in the `backend` namespace to `/root/netpol-summary.txt`.
3. Create `/root/traffic-matrix.txt` documenting the allowed traffic flows:
   - One line per allowed flow in format: `source -> destination : port`

## Hint

Use `kubectl get networkpolicy -n backend -o wide` for the summary. The traffic matrix should reflect: frontend/web -> backend/api:80 and backend/api -> backend/db:80.
