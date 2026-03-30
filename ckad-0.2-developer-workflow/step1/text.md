# Generate and Customize YAML Manifests

The fastest CKAD workflow is: generate YAML with `--dry-run=client -o yaml`, edit it, then apply.

## Task

1. Generate a pod manifest for a pod named `frontend` with image `nginx:1.25` and save it to `/root/frontend.yaml`. Do NOT apply it yet.
2. Edit `/root/frontend.yaml` to add the label `tier: frontend` under `metadata.labels`.
3. Edit `/root/frontend.yaml` to add a container port `containerPort: 80` under the nginx container.
4. Apply the manifest to the `dev-workflow` namespace.

## Hint

Use `kubectl run frontend --image=nginx:1.25 --dry-run=client -o yaml > /root/frontend.yaml`. Then edit the file with `vim` or `sed` to add labels and ports.
