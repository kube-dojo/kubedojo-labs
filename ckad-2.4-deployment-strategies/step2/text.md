# Implement Recreate Strategy

Recreate kills all existing pods before creating new ones. Use this when your app cannot run two versions simultaneously.

## Task

1. Create a deployment named `recreate-app` in `strategy-lab` with:
   - Image: `httpd:2.4.58`
   - Replicas: 3
   - Strategy: `Recreate`
2. Update the image to `httpd:2.4.59`.
3. Save the strategy type to `/root/recreate-strategy.txt`.

## Hint

Set `spec.strategy.type: Recreate` — no rolling update parameters needed since all pods are replaced at once. See the Kubernetes docs: Deployments > Strategy.
