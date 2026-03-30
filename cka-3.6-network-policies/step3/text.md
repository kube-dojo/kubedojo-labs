## Default Deny Policies

A default deny policy blocks all traffic to (or from) pods in a namespace unless explicitly allowed by another NetworkPolicy.

### Task

Create two default deny policies in the `backend` namespace:

1. A NetworkPolicy named `default-deny-ingress` that denies all ingress traffic to all pods
2. A NetworkPolicy named `default-deny-egress` that denies all egress traffic from all pods

```bash
# Verify both policies
kubectl get networkpolicy -n backend

# Note: The api-allow-frontend policy from step 1 still allows
# frontend pods to reach the api pod, because policies are additive
```

<details>
<summary>Hint: Default deny YAML</summary>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
  namespace: backend
spec:
  podSelector: {}
  policyTypes:
  - Ingress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-egress
  namespace: backend
spec:
  podSelector: {}
  policyTypes:
  - Egress
```

An empty `podSelector: {}` selects all pods in the namespace. Having `policyTypes` but no `ingress`/`egress` rules means deny all.
</details>
