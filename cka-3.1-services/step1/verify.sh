#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: ClusterIP service exists with correct selector
SVC=$(kubectl get svc backend-svc -n practice -o jsonpath='{.spec.type}' 2>/dev/null)
SELECTOR=$(kubectl get svc backend-svc -n practice -o jsonpath='{.spec.selector.app}' 2>/dev/null)
[ "$SVC" = "ClusterIP" ] && [ "$SELECTOR" = "web" ] && exit 0 || exit 1
