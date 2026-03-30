#!/bin/bash
# Verify: broken-app is fixed and running, diagnosis file exists
POD_STATUS=$(kubectl get pod broken-app -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
FILE_EXISTS=$(test -f /root/diagnosis.txt && echo "yes")
[ "$POD_STATUS" = "Running" ] && [ "$FILE_EXISTS" = "yes" ] && exit 0 || exit 1
