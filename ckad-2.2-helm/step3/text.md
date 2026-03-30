# Upgrade and Rollback Releases

## Task

1. Upgrade the `web-app` release to use 2 replicas:
   ```
   helm upgrade web-app bitnami/nginx -n helm-lab --set replicaCount=2
   ```
2. Check the release history: `helm history web-app -n helm-lab`.
3. Roll back to revision 1: `helm rollback web-app 1 -n helm-lab`.
4. Save the revision number after rollback to `/root/helm-revision.txt`:
   ```
   helm list -n helm-lab -o json | ...
   ```

## Hint

After a rollback, the revision number increments (becomes 3 if you had 2 revisions). Use `helm list -n helm-lab` to check.
