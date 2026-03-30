# Configure kubectl Context

In the CKA exam, you may need to switch between multiple clusters. Understanding kubectl contexts is essential.

Key commands:
- `kubectl config view` — show the full kubeconfig
- `kubectl config current-context` — show active context
- `kubectl config set-context` — create or modify a context
- `kubectl config use-context` — switch to a context

## Task

1. View the current kubeconfig with `kubectl config view`.
2. Note the current cluster name and user.
3. Create a new context called `cka-practice` that points to the same cluster and user as the current context.
4. Switch to the `cka-practice` context.

## Hint

Use `kubectl config set-context cka-practice --cluster=<cluster> --user=<user>` where cluster and user come from `kubectl config view`. Then `kubectl config use-context cka-practice`.
