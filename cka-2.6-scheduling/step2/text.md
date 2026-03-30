## Taints and Tolerations

Taints are applied to nodes to repel pods. Tolerations are applied to pods to allow scheduling on tainted nodes.

### Task

1. Taint the node with `env=prod:NoSchedule`:
   ```bash
   NODE_NAME=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
   kubectl taint node $NODE_NAME env=prod:NoSchedule
   ```

2. Try creating a pod **without** a toleration (it will stay Pending):
   ```bash
   kubectl run no-tolerate --image=nginx:1.25 -n practice
   kubectl get pod no-tolerate -n practice  # Should be Pending
   ```

3. Create a pod named `tolerant-pod` in the `practice` namespace **with** a matching toleration:
   - Image: `nginx:1.25`
   - Toleration for `env=prod:NoSchedule`

4. Clean up: remove the taint so other steps work:
   ```bash
   kubectl taint node $NODE_NAME env=prod:NoSchedule-
   kubectl delete pod no-tolerate -n practice --ignore-not-found
   ```

<details>
<summary>Hint: Toleration spec</summary>

```yaml
spec:
  tolerations:
  - key: "env"
    operator: "Equal"
    value: "prod"
    effect: "NoSchedule"
  containers:
  - name: nginx
    image: nginx:1.25
```

Refer to: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/
</details>
