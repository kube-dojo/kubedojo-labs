## Host-based Routing Rules

Host-based routing directs traffic to different services based on the HTTP `Host` header.

### Task

Create an Ingress resource named `host-routing` in the `practice` namespace that:

1. Routes `app.example.com` to the `app-v1` service on port **80**
2. Routes `blog.example.com` to the `blog` service on port **80**
3. Uses the `nginx` IngressClass

```bash
# After creating the Ingress, verify it
kubectl get ingress host-routing -n practice
kubectl describe ingress host-routing -n practice
```

Test the routing (using the NodePort of the ingress controller):

```bash
INGRESS_PORT=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')
curl -s -H "Host: app.example.com" http://localhost:$INGRESS_PORT | head -5
curl -s -H "Host: blog.example.com" http://localhost:$INGRESS_PORT | head -5
```

<details>
<summary>Hint: Host-based Ingress YAML</summary>

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: host-routing
  namespace: practice
spec:
  ingressClassName: nginx
  rules:
  - host: app.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: app-v1
            port:
              number: 80
  - host: blog.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: blog
            port:
              number: 80
```
</details>
