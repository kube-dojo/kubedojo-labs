# Apply Kustomize Overlays to the Cluster

## Task

1. Apply the staging overlay: `kubectl apply -k /root/kustomize/overlays/staging/`
2. Apply the production overlay: `kubectl apply -k /root/kustomize/overlays/production/`
3. Verify staging has 2 replicas and production has 5 replicas.
4. Save the staging deployment name to `/root/staging-deploy-name.txt`:
   ```
   kubectl get deployments -n staging -o jsonpath='{.items[0].metadata.name}'
   ```

## Hint

Use `kubectl apply -k <dir>` to apply a kustomization directory directly.
