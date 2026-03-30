#!/bin/bash
# Verify: HPA exists with correct settings
HPA=$(kubectl get hpa scale-app -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
MIN=$(kubectl get hpa scale-app -n practice -o jsonpath='{.spec.minReplicas}' 2>/dev/null)
MAX=$(kubectl get hpa scale-app -n practice -o jsonpath='{.spec.maxReplicas}' 2>/dev/null)

[ "$HPA" = "scale-app" ] && [ "$MIN" = "1" ] && [ "$MAX" = "5" ] && exit 0
exit 1
