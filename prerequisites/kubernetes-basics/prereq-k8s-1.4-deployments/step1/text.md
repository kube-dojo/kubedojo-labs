## Step 1: Create a Deployment

A Deployment tells Kubernetes: "I want N copies of this container running at all times." If a pod dies, the Deployment replaces it automatically.

### Create a basic deployment

```bash
kubectl create deployment my-app --image=nginx:1.24
```

Check what was created:

```bash
kubectl get deployments
kubectl get replicasets
kubectl get pods
```

Notice the naming chain: `my-app` (Deployment) creates `my-app-xxxxx` (ReplicaSet) which creates `my-app-xxxxx-yyyyy` (Pod).

### Create with replicas

```bash
kubectl create deployment my-api --image=busybox --replicas=2 -- sleep 3600
```

```bash
kubectl get pods
```

You should see 2 pods for `my-api`.

### Clean up the examples

```bash
kubectl delete deployment my-app my-api
```

### Your task

Create a deployment named `webapp` with the `nginx:1.25` image and **3 replicas**.

<details>
<summary>Hint</summary>

```bash
kubectl create deployment webapp --image=nginx:1.25 --replicas=3
```

Verify:

```bash
kubectl get deployment webapp
```

You should see `3/3` in the READY column.
</details>
