## Namespace Isolation

You can use `namespaceSelector` to allow traffic only from specific namespaces, enabling multi-tenant isolation.

### Task

Create a NetworkPolicy named `allow-monitoring` in the `backend` namespace that:

1. Applies to **all** pods (empty podSelector)
2. Allows ingress traffic from pods in the `monitoring` namespace (use label `purpose=monitoring`)
3. Allows traffic on port **80**

This policy, combined with the default deny, ensures only monitoring and explicitly allowed frontend pods can reach backend services.

```bash
# Verify the policy
kubectl describe networkpolicy allow-monitoring -n backend

# Check all policies in the namespace
kubectl get networkpolicy -n backend
```

<details>
<summary>Hint: Namespace selector policy</summary>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-monitoring
  namespace: backend
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          purpose: monitoring
    ports:
    - protocol: TCP
      port: 80
```
</details>
