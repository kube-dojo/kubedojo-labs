# Create and Scale Deployments

## Task

1. Create a deployment named `webapp` in `deploy-lab` with image `nginx:1.24` and 2 replicas.
2. Verify all pods are running.
3. Scale the deployment to 5 replicas.
4. Save the number of ready replicas to `/root/ready-replicas.txt`.

## Hint

Use `kubectl create deployment webapp --image=nginx:1.24 --replicas=2 -n deploy-lab` then `kubectl scale deployment webapp --replicas=5 -n deploy-lab`.
