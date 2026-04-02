#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: web-lb service exists and is now NodePort
SVC_TYPE=$(kubectl get svc web-lb -n practice -o jsonpath='{.spec.type}' 2>/dev/null)
[ "$SVC_TYPE" = "NodePort" ] && exit 0 || exit 1
