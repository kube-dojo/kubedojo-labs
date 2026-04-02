#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: Secret exists and pod can read it
SECRET=$(kubectl get secret db-creds -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
[ "$SECRET" != "db-creds" ] && exit 1

for i in $(seq 1 30); do
  STATUS=$(kubectl get pod secret-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  if [ "$STATUS" = "Running" ]; then
    USER=$(kubectl exec secret-pod -n practice -- cat /etc/secrets/username 2>/dev/null)
    [ "$USER" = "admin" ] && exit 0
  fi
  sleep 2
done
exit 1
