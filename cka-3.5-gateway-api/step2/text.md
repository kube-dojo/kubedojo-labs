## HTTPRoute for Service Routing

HTTPRoute attaches to a Gateway and defines how HTTP traffic should be routed to backend services.

### Task

Create an HTTPRoute named `app-route` in the `practice` namespace that:

1. Attaches to the `lab-gateway` Gateway as a parent reference
2. Has a hostname match for `app.example.com`
3. Routes all traffic (`/`) to the `app-v1` service on port **80**

```bash
# After creating the HTTPRoute, verify it
kubectl get httproute -n practice
kubectl describe httproute app-route -n practice
```

<details>
<summary>Hint: HTTPRoute YAML</summary>

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: app-route
  namespace: practice
spec:
  parentRefs:
  - name: lab-gateway
  hostnames:
  - app.example.com
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /
    backendRefs:
    - name: app-v1
      port: 80
```
</details>
