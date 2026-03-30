# Add Overlays

Overlays customize the base without modifying it. Common transformations include:

- `namePrefix` — add a prefix to all resource names
- `commonLabels` — add labels to all resources
- `patches` — modify specific fields (like replica count)

Directory structure:
```
overlays/
  prod/
    kustomization.yaml
    replica-patch.yaml
```

## Task

Create a production overlay in `/root/overlays/prod/` that:

1. References the base at `../../base`
2. Adds `namePrefix: prod-`
3. Patches the deployment to use `replicas: 3`

Verify with `kubectl kustomize /root/overlays/prod/` — the output should show `prod-myapp` with 3 replicas.

## Hint

The overlay kustomization.yaml should reference the base with `resources: [../../base]`, add `namePrefix: prod-`, and include a patch. For the replica patch, create a file like:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 3
```
And reference it in kustomization.yaml under `patches: [{path: replica-patch.yaml}]`.
