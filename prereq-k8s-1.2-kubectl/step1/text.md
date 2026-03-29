## Step 1: Get Resources

`kubectl get` is the most common command. It lists resources of any type.

### List pods in the default namespace

```bash
kubectl get pods
```

Nothing yet — the default namespace is empty. But the system pods are in `kube-system`:

```bash
kubectl get pods -n kube-system
```

### List pods across ALL namespaces

```bash
kubectl get pods -A
```

The `-A` flag (short for `--all-namespaces`) shows everything in the cluster.

### List services

```bash
kubectl get svc
```

You should see the `kubernetes` service — this is the API server's internal endpoint.

### List multiple resource types at once

```bash
kubectl get pods,svc,nodes
```

### Your task

List all pods in the `kube-system` namespace and save the output to:

```
/root/kube-system-pods.txt
```

Use the default `kubectl get pods` output (no special formatting needed).

<details>
<summary>Hint</summary>

```bash
kubectl get pods -n kube-system > /root/kube-system-pods.txt
```
</details>
