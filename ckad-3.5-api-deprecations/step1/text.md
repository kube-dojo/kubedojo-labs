# Explore API Versions and Groups

## Task

1. List all API versions available in the cluster:
   ```
   kubectl api-versions
   ```
   Save the output to `/root/api-versions.txt`.

2. List all API resources with their API group and version:
   ```
   kubectl api-resources -o wide
   ```
   Save the output to `/root/api-resources.txt`.

3. Find the preferred API version for Deployments and save it to `/root/deployment-api.txt`. Use:
   ```
   kubectl api-resources | grep -w deployments
   ```

## Hint

`kubectl api-versions` lists all supported API versions. `kubectl api-resources` shows which version each resource uses. See the Kubernetes docs: API Overview.
