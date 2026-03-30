# Combined Ingress and Egress Policy

## Task

1. Create a NetworkPolicy named `db-policy` in `netpol-lab` that:
   - Applies to pods with `app=db`
   - Allows ingress only from pods with `app=api` on port 80
   - Denies all egress (database should not initiate outbound connections)
2. Verify the policy:
   ```
   kubectl describe networkpolicy db-policy -n netpol-lab
   ```
3. Save the total number of NetworkPolicies in the namespace to `/root/total-policies.txt`.

## Hint

Include both `Ingress` and `Egress` in `policyTypes`. An empty `egress: []` array denies all egress. See the Kubernetes docs: Declare Network Policy.
