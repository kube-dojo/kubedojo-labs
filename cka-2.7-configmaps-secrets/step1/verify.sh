#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: ConfigMap has APP_ENV and LOG_LEVEL keys
APP_ENV=$(kubectl get configmap app-config -n practice -o jsonpath='{.data.APP_ENV}' 2>/dev/null)
LOG_LEVEL=$(kubectl get configmap app-config -n practice -o jsonpath='{.data.LOG_LEVEL}' 2>/dev/null)

[ "$APP_ENV" = "production" ] && [ "$LOG_LEVEL" = "info" ] && exit 0
exit 1
