# Identify Deprecated API Usage

## Task

1. Apply the manifest at `/root/old-manifest.yaml` to the cluster.
2. Check the API version used by the deployed resource:
   ```
   kubectl get deployment legacy-app -n api-lab -o yaml | head -5
   ```
3. Use `kubectl explain` to explore the Deployment spec:
   ```
   kubectl explain deployment.spec.strategy
   ```
4. Save the output of `kubectl explain deployment --api-version=apps/v1` (first 10 lines) to `/root/explain-output.txt`.

## Hint

`kubectl explain <resource>` shows the API specification. `kubectl explain deployment.spec.strategy` shows the strategy field details. See the Kubernetes docs: API Deprecation Policy.
