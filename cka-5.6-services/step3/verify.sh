#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: public-svc is NodePort type
SVC_TYPE=$(kubectl get svc public-svc -n practice -o jsonpath='{.spec.type}' 2>/dev/null)
[ "$SVC_TYPE" = "NodePort" ] && exit 0 || exit 1
