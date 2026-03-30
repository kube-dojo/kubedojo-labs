#!/bin/bash
# Verify: deployment exists with RollingUpdate strategy, maxSurge=1, maxUnavailable=0
STRATEGY=$(kubectl get deployment web-deploy -n practice -o jsonpath='{.spec.strategy.type}' 2>/dev/null)
MAX_SURGE=$(kubectl get deployment web-deploy -n practice -o jsonpath='{.spec.strategy.rollingUpdate.maxSurge}' 2>/dev/null)
MAX_UNAVAIL=$(kubectl get deployment web-deploy -n practice -o jsonpath='{.spec.strategy.rollingUpdate.maxUnavailable}' 2>/dev/null)

[ "$STRATEGY" = "RollingUpdate" ] && [ "$MAX_SURGE" = "1" ] && [ "$MAX_UNAVAIL" = "0" ] && exit 0
exit 1
