# Apply Kustomization

Once you are satisfied with the kustomize output, apply it to the cluster.

**Key commands:**
```bash
kubectl kustomize <dir>              # Preview output
kubectl apply -k <dir>               # Apply to cluster
kubectl delete -k <dir>              # Delete resources
```

## Task

Apply the production overlay to the cluster using `kubectl apply -k /root/overlays/prod/`.

Verify that a deployment named `prod-myapp` exists in the cluster.

## Hint

Run `kubectl apply -k /root/overlays/prod/` and then `kubectl get deployment prod-myapp`.
