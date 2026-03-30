## Node Labels and nodeSelector

The simplest way to constrain pods to specific nodes is using labels and `nodeSelector`.

### Task

1. Label the node with `disk=ssd`:
   ```bash
   NODE_NAME=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
   kubectl label node $NODE_NAME disk=ssd
   ```

2. Create a pod named `ssd-pod` in the `practice` namespace with:
   - Image: `nginx:1.25`
   - nodeSelector: `disk: ssd`

3. Verify the pod is scheduled on the labeled node:
   ```bash
   kubectl get pod ssd-pod -n practice -o wide
   ```

<details>
<summary>Hint: nodeSelector in pod spec</summary>

```yaml
spec:
  nodeSelector:
    disk: ssd
  containers:
  - name: nginx
    image: nginx:1.25
```

Refer to: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector
</details>
