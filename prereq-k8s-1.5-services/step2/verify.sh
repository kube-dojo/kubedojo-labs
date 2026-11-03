#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/curl-output.txt"
[ -f "$FILE" ] || exit 1
CLUSTER_IP=$(kubectl get svc web-svc -o jsonpath='{.spec.clusterIP}') || exit 2
RESPONSE=$(curl -fsS --connect-timeout 3 --max-time 10 "$CLUSTER_IP") || exit 2
[ -n "$RESPONSE" ] && [ "$(cat "$FILE")" = "$RESPONSE" ]
