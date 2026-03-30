#!/bin/bash
# Verify: canary-route exists with two backends and correct weights
ROUTE=$(kubectl get httproute canary-route -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
BACKEND_COUNT=$(kubectl get httproute canary-route -n practice -o jsonpath='{.spec.rules[0].backendRefs[*].name}' 2>/dev/null | wc -w)
WEIGHT1=$(kubectl get httproute canary-route -n practice -o jsonpath='{.spec.rules[0].backendRefs[0].weight}' 2>/dev/null)
WEIGHT2=$(kubectl get httproute canary-route -n practice -o jsonpath='{.spec.rules[0].backendRefs[1].weight}' 2>/dev/null)
[ "$ROUTE" = "canary-route" ] && [ "$BACKEND_COUNT" -eq 2 ] && [ "$WEIGHT1" = "80" ] && [ "$WEIGHT2" = "20" ] && exit 0 || exit 1
