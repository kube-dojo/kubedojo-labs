# Create a Kustomization

A kustomization consists of:
- **kustomization.yaml** — declares which resources to include and what transformations to apply
- **Resource files** — standard Kubernetes YAML manifests

Directory structure:
```
base/
  kustomization.yaml
  deployment.yaml
  service.yaml
```

## Task

Create the following files in `/root/base/`:

1. **deployment.yaml** — a Deployment named `myapp` with 1 replica, using image `nginx:1.27`
2. **service.yaml** — a ClusterIP Service named `myapp` on port 80 targeting port 80
3. **kustomization.yaml** — listing both resources

Verify with `kubectl kustomize /root/base/` which should produce valid combined YAML.

<details>
<summary>Hint</summary>

```yaml
# base/kustomization.yaml
resources:
  - deployment.yaml
  - service.yaml
```
</details>