## LoadBalancer Services

LoadBalancer services provision an external load balancer (typically in cloud environments). On bare-metal clusters, the external IP stays in `<pending>` state unless a LoadBalancer implementation like MetalLB is installed.

### Task

1. Create a LoadBalancer service named `web-lb` in the `practice` namespace that selects pods with label `app=web,tier=frontend` on port **80**
2. Observe the `<pending>` external IP (expected without a cloud provider)
3. Convert the service to a NodePort type by editing it

```bash
# After creating the LoadBalancer service, check its status
kubectl get svc web-lb -n practice
# Notice EXTERNAL-IP is <pending>
```

Edit the service to change its type from `LoadBalancer` to `NodePort`:

```bash
kubectl edit svc web-lb -n practice
# Change spec.type from LoadBalancer to NodePort
```

Verify the service type changed:

```bash
kubectl get svc web-lb -n practice
```

<details>
<summary>Hint: LoadBalancer to NodePort</summary>

```bash
# Create as LoadBalancer first
kubectl expose pod web-frontend -n practice --name=web-lb --port=80 --type=LoadBalancer

# Then patch to NodePort
kubectl patch svc web-lb -n practice -p '{"spec":{"type":"NodePort"}}'
```
</details>
