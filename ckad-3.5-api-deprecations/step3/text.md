# Migrate Resources to Current API Versions

## Task

1. Export the `legacy-app` deployment to `/root/migrated-manifest.yaml`:
   ```
   kubectl get deployment legacy-app -n api-lab -o yaml > /root/migrated-manifest.yaml
   ```
2. Clean up the exported YAML by removing unnecessary fields (resourceVersion, uid, creationTimestamp, status, managedFields). You can do this manually or with:
   ```
   kubectl get deployment legacy-app -n api-lab -o yaml | kubectl neat > /root/clean-manifest.yaml
   ```
   If `kubectl neat` is not available, simply ensure the apiVersion is `apps/v1`.
3. Verify the manifest is valid by doing a dry-run apply:
   ```
   kubectl apply -f /root/migrated-manifest.yaml --dry-run=server
   ```
4. Save "apps/v1" to `/root/final-api-version.txt` to confirm the correct API version.

## Hint

When migrating manifests, the key change is the `apiVersion` field. `apps/v1` is the stable version for Deployments. Server-side dry-run validates without applying. See the Kubernetes docs: Deprecated API Migration Guide.
