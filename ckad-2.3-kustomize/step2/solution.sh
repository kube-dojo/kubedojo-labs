#!/bin/bash
mkdir -p "$HOME"/kustomize/overlays/staging
mkdir -p "$HOME"/kustomize/overlays/production

cat > "$HOME"/kustomize/overlays/staging/kustomization.yaml << 'YAML'
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
YAML

cat > "$HOME"/kustomize/overlays/production/kustomization.yaml << 'YAML'
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
YAML

kubectl kustomize "$HOME"/kustomize/overlays/staging/ > "$HOME"/staging-output.yaml
kubectl kustomize "$HOME"/kustomize/overlays/production/ > "$HOME"/production-output.yaml
