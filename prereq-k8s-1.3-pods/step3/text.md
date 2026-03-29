## Step 3: Inspect a Running Pod

Knowing how to inspect pods is essential for debugging.

### Describe a pod

```bash
kubectl describe pod web
```

Key sections to look at:

| Section | What it tells you |
|---------|-------------------|
| **Status** | Running, Pending, Failed, etc. |
| **IP** | The pod's cluster-internal IP address |
| **Containers** | Image, state, restart count |
| **Events** | What happened — scheduling, pulling, starting |

### View logs

```bash
kubectl logs web
```

For the nginx pod, you'll see access logs (probably empty since no one has connected yet).

### Get pod IP quickly

```bash
kubectl get pod web -o wide
```

Or extract just the IP:

```bash
kubectl get pod web -o jsonpath='{.status.podIP}'
```

### Your task

Get the IP address of the `web` pod and save it to:

```
/root/web-pod-ip.txt
```

<details>
<summary>Hint</summary>

```bash
kubectl get pod web -o jsonpath='{.status.podIP}' > /root/web-pod-ip.txt
```
</details>
