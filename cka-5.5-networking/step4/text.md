## Fix NetworkPolicy Blocking Traffic

The `isolated` namespace has a default deny NetworkPolicy that blocks all ingress and egress traffic. The `web` service is unreachable.

### Task

1. Diagnose the NetworkPolicy blocking traffic
2. Add a NetworkPolicy to allow ingress on port 80 from any pod
3. Add a NetworkPolicy to allow DNS egress (port 53)
4. Verify the `web` service is now reachable

```bash
# Check existing policies
kubectl get networkpolicy -n isolated
kubectl describe networkpolicy deny-all -n isolated

# Test — should fail
kubectl run test-curl --image=curlimages/curl --rm -it --restart=Never -n practice -- curl -s --max-time 3 http://web.isolated.svc.cluster.local || echo "Blocked!"
```

<details>
<summary>Hint: Allow policies</summary>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-web-ingress
  namespace: isolated
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes:
  - Ingress
  ingress:
  - ports:
    - port: 80
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-dns-egress
  namespace: isolated
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - ports:
    - port: 53
      protocol: TCP
    - port: 53
      protocol: UDP
```
</details>
