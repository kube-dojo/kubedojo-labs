## Ingress Network Policies

Ingress NetworkPolicies control which pods can send traffic to the selected pods.

### Task

Create a NetworkPolicy named `api-allow-frontend` in the `backend` namespace that:

1. Applies to pods with label `app=api`
2. Allows **ingress** traffic only from pods with label `role=frontend`
3. Only allows traffic on port **80**

```bash
# Before applying the policy, test connectivity
kubectl run test --image=busybox:1.36 --rm -it --restart=Never -n frontend -- wget -qO- --timeout=3 api.backend.svc.cluster.local

# After applying, verify the policy
kubectl get networkpolicy -n backend
kubectl describe networkpolicy api-allow-frontend -n backend
```

<details>
<summary>Hint: Ingress NetworkPolicy YAML</summary>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-allow-frontend
  namespace: backend
spec:
  podSelector:
    matchLabels:
      app: api
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: frontend
      namespaceSelector:
        matchLabels:
          purpose: frontend
    ports:
    - protocol: TCP
      port: 80
```
</details>
