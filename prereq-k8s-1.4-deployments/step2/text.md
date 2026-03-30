## Step 2: Scale a Deployment

Scaling adjusts the number of pod replicas. Kubernetes handles creating or terminating pods to match.

### Scale up

```bash
kubectl scale deployment webapp --replicas=4
```

Watch the new pod appear:

```bash
kubectl get pods -l app=webapp
```

The `-l app=webapp` flag filters pods by label — showing only pods belonging to the `webapp` deployment.

### Scale down

```bash
kubectl scale deployment webapp --replicas=2
```

Kubernetes terminates the extra pods gracefully.

### Check the deployment status

```bash
kubectl get deployment webapp
```

The READY column shows `current/desired` replicas.

### Your task

Scale the `webapp` deployment to **5 replicas**.

<details>
<summary>Hint</summary>

```bash
kubectl scale deployment webapp --replicas=5
kubectl rollout status deployment/webapp --timeout=60s
```

Verify:

```bash
kubectl get deployment webapp
```

Wait until READY shows `5/5`.
</details>
