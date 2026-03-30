## Fix NodePort Access

The `public-svc` service is supposed to be externally accessible but is currently a ClusterIP service.

### Task

1. Change `public-svc` from ClusterIP to NodePort
2. Verify external access via the node port

```bash
# Current type is ClusterIP — not externally accessible
kubectl get svc public-svc -n practice

# Change to NodePort
kubectl patch svc public-svc -n practice -p '{"spec":{"type":"NodePort"}}'

# Verify the change
kubectl get svc public-svc -n practice

# Test external access
NODE_PORT=$(kubectl get svc public-svc -n practice -o jsonpath='{.spec.ports[0].nodePort}')
curl -s http://localhost:$NODE_PORT | head -5
```

<details>
<summary>Hint: Service type change</summary>

```bash
# Simple patch
kubectl patch svc public-svc -n practice -p '{"spec":{"type":"NodePort"}}'

# Or use kubectl edit
kubectl edit svc public-svc -n practice
```
</details>
