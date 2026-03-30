#!/bin/bash
# Verify: deployment exists with topologySpreadConstraints
DEPLOY=$(kubectl get deployment spread-deploy -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
TOPO=$(kubectl get deployment spread-deploy -n practice -o jsonpath='{.spec.template.spec.topologySpreadConstraints[0].topologyKey}' 2>/dev/null)

[ "$DEPLOY" = "spread-deploy" ] && [ "$TOPO" = "kubernetes.io/hostname" ] && exit 0
exit 1
