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

<details>
<summary>Hint</summary>

```yaml
# overlays/prod/kustomization.yaml
resources:
  - ../../base
namePrefix: prod-
patches:
  - path: replica-patch.yaml
```
</details>