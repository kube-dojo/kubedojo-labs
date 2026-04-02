# Generate YAML from Docs

One of the most powerful exam techniques is generating YAML from the command line instead of writing it from scratch.

**Key patterns:**
```bash
# Generate pod YAML
kubectl run nginx --image=nginx --dry-run=client -o yaml

# Generate deployment YAML
kubectl create deployment nginx --image=nginx --replicas=2 --dry-run=client -o yaml

# Generate service YAML
kubectl expose deployment nginx --port=80 --dry-run=client -o yaml
```

The `--dry-run=client -o yaml` flags tell kubectl to generate the YAML without actually creating the resource.

## Task

Generate a Deployment YAML for nginx with 2 replicas and save it to `/root/nginx-deploy.yaml`.

The YAML must contain:
- `replicas: 2`
- Image `nginx`

<details>
<summary>Hint</summary>

```bash
kubectl create deployment nginx --image=nginx --replicas=2 --dry-run=client -o yaml > /root/nginx-deploy.yaml
```
</details>