#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify deployment image is back to nginx:1.25
# Wait up to 60s for the rollback to complete
for i in $(seq 1 30); do
  IMAGE=$(kubectl get deployment webapp -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
  if [ "$IMAGE" = "nginx:1.25" ]; then
    exit 0
  fi
  sleep 2
done
exit 1
