#!/bin/bash
# Verify: api-svc has endpoints
ENDPOINTS=$(kubectl get endpoints api-svc -n practice -o jsonpath='{.subsets[0].addresses[0].ip}' 2>/dev/null)
[ -n "$ENDPOINTS" ] && exit 0 || exit 1
