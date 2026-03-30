## Traffic Splitting

The Gateway API supports weighted traffic splitting natively through multiple `backendRefs` with `weight` fields. This is essential for canary deployments.

### Task

Create an HTTPRoute named `canary-route` in the `practice` namespace that:

1. Attaches to the `lab-gateway` Gateway
2. Has a hostname match for `canary.example.com`
3. Splits traffic: **80%** to `app-v1` and **20%** to `app-v2` (both on port **80**)

```bash
# Verify the traffic split configuration
kubectl get httproute canary-route -n practice -o yaml
```

<details>
<summary>Hint: Traffic splitting YAML</summary>

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: canary-route
  namespace: practice
spec:
  parentRefs:
  - name: lab-gateway
  hostnames:
  - canary.example.com
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /
    backendRefs:
    - name: app-v1
      port: 80
      weight: 80
    - name: app-v2
      port: 80
      weight: 20
```

The `weight` field determines the proportion of traffic each backend receives. Weights are relative (80+20=100 means 80% and 20%).
</details>
