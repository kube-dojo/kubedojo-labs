## NodePort Services

NodePort services expose an application on a static port on every node's IP address. This allows external traffic to reach the service via `<NodeIP>:<NodePort>`.

### Task

Create a NodePort service named `frontend-nodeport` in the `practice` namespace that:

1. Selects pods with label `app=web,tier=frontend`
2. Exposes port **80** targeting port **80** on the pods
3. Uses NodePort type with a specific node port of **30080**

```bash
# Check available pods
kubectl get pods -n practice -l tier=frontend
```

After creating the service, verify external accessibility:

```bash
# Get the node IP
NODE_IP=$(kubectl get node -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
echo "Access at: http://$NODE_IP:30080"

# Test connectivity
curl -s http://$NODE_IP:30080 | head -5
```

<details>
<summary>Hint: NodePort YAML</summary>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-nodeport
  namespace: practice
spec:
  type: NodePort
  selector:
    app: web
    tier: frontend
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
```
</details>
