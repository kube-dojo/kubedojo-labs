## Egress Network Policies

Egress NetworkPolicies control which destinations pods can send traffic to.

### Task

Create a NetworkPolicy named `db-egress-restrict` in the `backend` namespace that:

1. Applies to pods with label `app=db`
2. Allows **egress** traffic only to the DNS service (port **53** TCP and UDP in `kube-system`)
3. Blocks all other outbound traffic

```bash
# Verify the policy
kubectl get networkpolicy db-egress-restrict -n backend
kubectl describe networkpolicy db-egress-restrict -n backend
```

<details>
<summary>Hint: Egress NetworkPolicy YAML</summary>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-egress-restrict
  namespace: backend
spec:
  podSelector:
    matchLabels:
      app: db
  policyTypes:
  - Egress
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          kubernetes.io/metadata.name: kube-system
    ports:
    - protocol: TCP
      port: 53
    - protocol: UDP
      port: 53
```

This policy allows DNS resolution but blocks all other outbound traffic from the `db` pods.
</details>
