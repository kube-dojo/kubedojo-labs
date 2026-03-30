# Control Image Pull Policies

Kubernetes supports three image pull policies: `Always`, `IfNotPresent`, and `Never`. The default depends on the tag used.

## Task

1. Create a pod named `always-pull` in the `images-lab` namespace with image `nginx:1.25` and `imagePullPolicy: Always`.
2. Create a pod named `ifnotpresent-pull` in the `images-lab` namespace with image `nginx:1.25` and `imagePullPolicy: IfNotPresent`.
3. Save the imagePullPolicy of the `always-pull` pod to `/root/pull-policy.txt`.

## Hint

Generate YAML with `kubectl run always-pull --image=nginx:1.25 --dry-run=client -o yaml`, then add `imagePullPolicy: Always` under the container spec.
