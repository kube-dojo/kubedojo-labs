# Implement Blue-Green Deployment

Blue-green deployments run two versions simultaneously and switch traffic by updating the service selector.

## Task

1. Create deployment `blue-app` in `strategy-lab` with image `nginx:1.24`, 3 replicas, labels `app: myapp, version: blue`.
2. Create a service `myapp-svc` in `strategy-lab` that selects `app: myapp, version: blue` on port 80.
3. Create deployment `green-app` in `strategy-lab` with image `nginx:1.25`, 3 replicas, labels `app: myapp, version: green`.
4. Switch traffic to green by patching the service selector to `version: green`:
   ```
   kubectl patch svc myapp-svc -n strategy-lab -p '{"spec":{"selector":{"version":"green"}}}'
   ```
5. Save the current service selector version to `/root/active-version.txt`.

## Hint

The key to blue-green is that both deployments are running, but the service only points to one. See the Kubernetes docs for Service selectors.
