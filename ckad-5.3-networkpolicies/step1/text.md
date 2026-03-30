# Create a Default-Deny NetworkPolicy

A default-deny policy blocks all traffic to pods in a namespace unless explicitly allowed.

## Task

1. Create a NetworkPolicy named `default-deny-ingress` in `netpol-lab` that denies all ingress traffic:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: NetworkPolicy
   metadata:
     name: default-deny-ingress
     namespace: netpol-lab
   spec:
     podSelector: {}
     policyTypes:
     - Ingress
   ```
2. Verify by trying to reach `web` from a test pod:
   ```
   kubectl run test-deny --image=busybox:1.36 --rm -it --restart=Never -n netpol-lab -- wget -qO- --timeout=3 web.netpol-lab.svc.cluster.local
   ```
   This should time out.
3. Save the policy name to `/root/deny-policy.txt`.

## Hint

An empty `podSelector: {}` applies to all pods in the namespace. With no `ingress` rules, all ingress traffic is denied. See the Kubernetes docs: Network Policies.
