#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: deployment scaled to 5 and endpoint count file exists
REPLICAS=$(kubectl get deployment web -n practice -o jsonpath='{.spec.replicas}' 2>/dev/null)
FILE_EXISTS=$(test -f $USER_HOME/endpoint-count.txt && cat $USER_HOME/endpoint-count.txt)
[ "$REPLICAS" = "5" ] && [ -n "$FILE_EXISTS" ] && exit 0 || exit 1
