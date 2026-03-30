#!/bin/bash
# Verify: deployment scaled to 5 and endpoint count file exists
REPLICAS=$(kubectl get deployment web -n practice -o jsonpath='{.spec.replicas}' 2>/dev/null)
FILE_EXISTS=$(test -f /root/endpoint-count.txt && cat /root/endpoint-count.txt)
[ "$REPLICAS" = "5" ] && [ -n "$FILE_EXISTS" ] && exit 0 || exit 1
