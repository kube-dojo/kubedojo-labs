#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: pod has environment variables from ConfigMap
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod env-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  if [ "$STATUS" = "Running" ]; then
    APP_ENV=$(kubectl exec env-pod -n practice -- sh -c 'echo $APP_ENV' 2>/dev/null)
    LOG_LEVEL=$(kubectl exec env-pod -n practice -- sh -c 'echo $LOG_LEVEL' 2>/dev/null)
    [ "$APP_ENV" = "production" ] && [ "$LOG_LEVEL" = "info" ] && exit 0
  fi
  sleep 2
done
exit 1
