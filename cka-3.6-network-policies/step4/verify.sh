#!/bin/bash
# Verify: allow-monitoring policy exists with namespaceSelector
NP=$(kubectl get networkpolicy allow-monitoring -n backend -o jsonpath='{.metadata.name}' 2>/dev/null)
NS_SEL=$(kubectl get networkpolicy allow-monitoring -n backend -o jsonpath='{.spec.ingress[0].from[0].namespaceSelector.matchLabels.purpose}' 2>/dev/null)
[ "$NP" = "allow-monitoring" ] && [ "$NS_SEL" = "monitoring" ] && exit 0 || exit 1
