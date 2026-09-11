#!/bin/bash
COUNT=$(kubectl get crd --no-headers 2>/dev/null | wc -l | tr -d ' ')
echo "$COUNT" > "$HOME"/crd-count.txt
echo "CRD count: $COUNT"
kubectl get crd 2>/dev/null || echo "No CRDs found"
