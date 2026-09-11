# Create Overlays for Different Environments

## Task

1. Create `"$HOME"/kustomize/overlays/staging/kustomization.yaml`:
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

2. Create `"$HOME"/kustomize/overlays/production/kustomization.yaml`:
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
   - `kubectl kustomize "$HOME"/kustomize/overlays/staging/ > "$HOME"/staging-output.yaml`
   - `kubectl kustomize "$HOME"/kustomize/overlays/production/ > "$HOME"/production-output.yaml`

## Hint

Overlays reference the base with `resources: [../../base]` and add environment-specific changes.
