#!/bin/bash
# Verify: both default deny policies exist
DENY_IN=$(kubectl get networkpolicy default-deny-ingress -n backend -o jsonpath='{.metadata.name}' 2>/dev/null)
DENY_EG=$(kubectl get networkpolicy default-deny-egress -n backend -o jsonpath='{.metadata.name}' 2>/dev/null)
[ "$DENY_IN" = "default-deny-ingress" ] && [ "$DENY_EG" = "default-deny-egress" ] && exit 0 || exit 1
