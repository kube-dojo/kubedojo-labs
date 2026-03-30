# Practice Imperative Commands for Speed

Imperative commands let you create resources in seconds instead of writing YAML from scratch. Master these patterns for the exam.

## Task

1. Using a single imperative command, create a pod named `web` with image `nginx:1.25` in the `ckad-practice` namespace.
2. Using a single imperative command, create a deployment named `api` with image `httpd:2.4` and 3 replicas in the `ckad-practice` namespace.
3. Using `--dry-run=client -o yaml`, generate a pod manifest for a pod named `generator` with image `busybox:1.36` that runs `sleep 3600` and save it to `/root/generator.yaml`. Then apply it to the `ckad-practice` namespace.

## Hint

The pattern is `kubectl run <name> --image=<image> -n <ns>` for pods and `kubectl create deployment <name> --image=<image> --replicas=<n> -n <ns>` for deployments. For dry-run: add `--dry-run=client -o yaml > file.yaml`.
