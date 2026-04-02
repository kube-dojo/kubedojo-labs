#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get deployment webapp >/dev/null 2>&1; then echo "FAIL: Deployment 'webapp' not found."; exit 1; fi
REPLICAS=$(kubectl get deployment webapp -o jsonpath='{.spec.replicas}')
if [ "$REPLICAS" -eq 3 ]; then echo "PASS: Deployment 'webapp' found with 3 replicas!"; exit 0; fi
echo "FAIL: Deployment has $REPLICAS replicas, expected 3."
exit 1
