## Step 4: Delete Pods

Clean up is important. Let's remove pods we no longer need.

### Delete a pod by name

```bash
kubectl delete pod nginx
```

This sends a graceful termination signal. The pod gets 30 seconds (by default) to shut down before being killed.

### Delete with a shorter grace period

```bash
kubectl delete pod redis --grace-period=5
```

### Verify deletion

```bash
kubectl get pods
```

The deleted pod should no longer appear.

### Your task

Delete the `api` pod and make sure it's fully removed.

<details>
<summary>Hint</summary>

```bash
kubectl delete pod api
```

Verify it's gone:

```bash
kubectl get pod api
```

This should return an error like `Error from server (NotFound): pods "api" not found` — that means it worked.
</details>
