## Step 3: Create a NodePort Service

A **NodePort** service opens a port on every node in the cluster, making the service reachable from outside.

### Service types overview

| Type | Reachable from | Use case |
|------|---------------|----------|
| **ClusterIP** | Inside the cluster only | Inter-service communication |
| **NodePort** | Outside via `<NodeIP>:<NodePort>` | Development, testing |
| **LoadBalancer** | External load balancer (cloud) | Production on cloud providers |

### Create a NodePort service

```bash
kubectl expose deployment web --name=web-nodeport --port=80 --type=NodePort
```

### Check the assigned port

```bash
kubectl get svc web-nodeport
```

The PORT column shows something like `80:31234/TCP`. The number after the colon (30000-32767 range) is the NodePort — the port opened on the node.

### Test it

```bash
NODE_PORT=$(kubectl get svc web-nodeport -o jsonpath='{.spec.ports[0].nodePort}')
curl -s localhost:$NODE_PORT
```

### Your task

Create a NodePort service named `web-nodeport` that exposes the `web` deployment on port 80.

<details>
<summary>Hint</summary>

```bash
kubectl expose deployment web --name=web-nodeport --port=80 --type=NodePort
```

Verify:

```bash
kubectl get svc web-nodeport
```

The TYPE column should show `NodePort`.
</details>
