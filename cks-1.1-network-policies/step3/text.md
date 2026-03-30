# Restrict Egress Traffic to Specific CIDRs

Limiting egress traffic prevents compromised pods from communicating with external C2 servers.

## Task

1. Create a NetworkPolicy named `api-egress-restrict` in the `backend` namespace that:
   - Applies to pods with label `app=api`
   - Allows egress only to:
     - Pods with label `app=db` in the same namespace (TCP port 80)
     - DNS (UDP port 53) to the cluster DNS CIDR
   - Denies all other egress
2. Save the cluster DNS service IP to `/root/dns-ip.txt`.

## Hint

Get the DNS service IP with `kubectl get svc kube-dns -n kube-system -o jsonpath='{.spec.clusterIP}'`. Use `ipBlock` for CIDR-based rules.
