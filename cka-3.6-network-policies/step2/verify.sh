#!/bin/bash
# Verify: egress policy exists for db pods
NP=$(kubectl get networkpolicy db-egress-restrict -n backend -o jsonpath='{.metadata.name}' 2>/dev/null)
POD_SEL=$(kubectl get networkpolicy db-egress-restrict -n backend -o jsonpath='{.spec.podSelector.matchLabels.app}' 2>/dev/null)
POLICY_TYPE=$(kubectl get networkpolicy db-egress-restrict -n backend -o jsonpath='{.spec.policyTypes[0]}' 2>/dev/null)
[ "$NP" = "db-egress-restrict" ] && [ "$POD_SEL" = "db" ] && [ "$POLICY_TYPE" = "Egress" ] && exit 0 || exit 1
