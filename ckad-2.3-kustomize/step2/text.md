# Create Overlays for Different Environments

## Task

1. Create `/root/kustomize/overlays/staging/kustomization.yaml`:
   ```yaml
   resources:
   - ../../base
   namespace: staging
   namePrefix: staging-
   patches:
   - target:
       kind: Deployment
       name: myapp
     patch: |
       - op: replace
         path: /spec/replicas
         value: 2
   ```

2. Create `/root/kustomize/overlays/production/kustomization.yaml`:
   ```yaml
   resources:
   - ../../base
   namespace: production
   namePrefix: prod-
   patches:
   - target:
       kind: Deployment
       name: myapp
     patch: |
       - op: replace
         path: /spec/replicas
         value: 5
   ```

3. Build both overlays and save outputs:
   - `kubectl kustomize /root/kustomize/overlays/staging/ > /root/staging-output.yaml`
   - `kubectl kustomize /root/kustomize/overlays/production/ > /root/production-output.yaml`

## Hint

Overlays reference the base with `resources: [../../base]` and add environment-specific changes.
