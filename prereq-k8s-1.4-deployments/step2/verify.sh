#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# The task asks for five desired replicas. Read the scale field directly.
REPLICAS=$(kubectl get deployment webapp -o jsonpath='{.spec.replicas}') || exit 2
[ "$REPLICAS" = 5 ]
