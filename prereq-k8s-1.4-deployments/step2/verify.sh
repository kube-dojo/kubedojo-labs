#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify deployment "webapp" has 5 ready replicas
# Wait up to 60s for all replicas to become ready
for i in $(seq 1 30); do
  READY=$(kubectl get deployment webapp -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
  if [ "$READY" = "5" ]; then
    exit 0
  fi
  sleep 2
done
exit 1
