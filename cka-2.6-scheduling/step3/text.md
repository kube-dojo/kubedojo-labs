## Node Affinity

Node affinity is a more expressive alternative to nodeSelector. It supports `In`, `NotIn`, `Exists`, `DoesNotExist`, `Gt`, `Lt` operators.

### Task

1. Ensure the node has the `disk=ssd` label from step 1:
   ```bash
   NODE_NAME=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
   kubectl label node $NODE_NAME disk=ssd --overwrite
   ```

2. Create a pod named `affinity-pod` in the `practice` namespace with:
   - Image: `nginx:1.25`
   - `requiredDuringSchedulingIgnoredDuringExecution` node affinity matching `disk In [ssd]`

3. Verify the pod is Running:
   ```bash
   kubectl get pod affinity-pod -n practice -o wide
   ```

<details>
<summary>Hint: Node affinity spec</summary>

```yaml
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disk
            operator: In
            values:
            - ssd
  containers:
  - name: nginx
    image: nginx:1.25
```

Refer to: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity
</details>
