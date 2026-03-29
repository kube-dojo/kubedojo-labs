## Step 3: Create Your First Namespace

Namespaces let you organize resources. In real clusters, teams often have their own namespace (e.g., `frontend`, `backend`, `monitoring`).

### See existing namespaces

```bash
kubectl get namespaces
```

### Create a namespace

The imperative way:

```bash
kubectl create namespace demo
```

Verify it exists:

```bash
kubectl get namespace demo
```

You can also list resources in a specific namespace:

```bash
kubectl get pods -n demo
```

Nothing there yet — that's expected. You'll deploy into namespaces in later labs.

### Clean up the demo

```bash
kubectl delete namespace demo
```

### Your task

Create a namespace called `my-first-ns`.

<details>
<summary>Hint</summary>

```bash
kubectl create namespace my-first-ns
```
</details>
