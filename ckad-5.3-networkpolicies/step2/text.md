# Allow Specific Ingress Traffic

Now allow the `web` pod to receive traffic only from pods with label `tier=frontend`.

## Task

1. Create a NetworkPolicy named `allow-web-ingress` in `netpol-lab` that:
   - Applies to pods with `app=web`
   - Allows ingress from pods with `tier=frontend` on port 80
2. Delete the `default-deny-ingress` policy first to start clean, then create both:
   - Default deny (recreate it)
   - The new allow policy
3. Save the number of NetworkPolicies to `/root/netpol-count.txt`.

## Hint

Use `podSelector` to match the target pod and `ingress.from.podSelector` to match allowed sources. See the Kubernetes docs: Network Policy recipes.
