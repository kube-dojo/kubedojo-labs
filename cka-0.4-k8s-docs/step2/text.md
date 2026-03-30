# kubectl api-resources

`kubectl api-resources` lists all resource types available in your cluster. This is invaluable for:

- Finding the short name for a resource (e.g., `deploy` for `deployments`)
- Discovering which API group a resource belongs to
- Checking if a resource is namespaced or cluster-wide

**Examples:**
```bash
kubectl api-resources                    # All resources
kubectl api-resources --namespaced=true  # Only namespaced
kubectl api-resources | grep deploy      # Search for deployments
```

## Task

Find the short name for `deployments` and save it to `/root/deploy-short.txt`.

## Hint

Run `kubectl api-resources | grep deployments` and look at the SHORTNAMES column. The short name for deployments is commonly used in day-to-day kubectl work.
