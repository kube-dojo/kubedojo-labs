#!/bin/bash
mkdir -p /root/kustomize/overlays/staging
mkdir -p /root/kustomize/overlays/production

cat > /root/kustomize/overlays/staging/kustomization.yaml << 'YAML'
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

cat > /root/kustomize/overlays/production/kustomization.yaml << 'YAML'
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

kubectl kustomize /root/kustomize/overlays/staging/ > /root/staging-output.yaml
kubectl kustomize /root/kustomize/overlays/production/ > /root/production-output.yaml
