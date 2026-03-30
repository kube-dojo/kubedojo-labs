## Path-based Routing

Path-based routing sends requests to different backends based on the URL path, all under the same host.

### Task

Create an Ingress resource named `path-routing` in the `practice` namespace that routes under `paths.example.com`:

1. `/v1` (Prefix) routes to `app-v1` service on port **80**
2. `/v2` (Prefix) routes to `app-v2` service on port **80**
3. `/blog` (Prefix) routes to `blog` service on port **80**

```bash
# Verify path-based routing
kubectl describe ingress path-routing -n practice

# Test each path
INGRESS_PORT=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')
curl -s -H "Host: paths.example.com" http://localhost:$INGRESS_PORT/v1
curl -s -H "Host: paths.example.com" http://localhost:$INGRESS_PORT/v2
```

<details>
<summary>Hint: Path-based Ingress YAML</summary>

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: path-routing
  namespace: practice
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: paths.example.com
    http:
      paths:
      - path: /v1
        pathType: Prefix
        backend:
          service:
            name: app-v1
            port:
              number: 80
      - path: /v2
        pathType: Prefix
        backend:
          service:
            name: app-v2
            port:
              number: 80
      - path: /blog
        pathType: Prefix
        backend:
          service:
            name: blog
            port:
              number: 80
```
</details>
