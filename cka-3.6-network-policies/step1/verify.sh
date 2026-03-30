#!/bin/bash
# Verify: NetworkPolicy exists with correct pod selector and ingress rule
NP=$(kubectl get networkpolicy api-allow-frontend -n backend -o jsonpath='{.metadata.name}' 2>/dev/null)
POD_SEL=$(kubectl get networkpolicy api-allow-frontend -n backend -o jsonpath='{.spec.podSelector.matchLabels.app}' 2>/dev/null)
POLICY_TYPE=$(kubectl get networkpolicy api-allow-frontend -n backend -o jsonpath='{.spec.policyTypes[0]}' 2>/dev/null)
[ "$NP" = "api-allow-frontend" ] && [ "$POD_SEL" = "api" ] && [ "$POLICY_TYPE" = "Ingress" ] && exit 0 || exit 1
