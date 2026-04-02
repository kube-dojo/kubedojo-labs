#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: web-svc targetPort is 80
TARGET_PORT=$(kubectl get svc web-svc -n practice -o jsonpath='{.spec.ports[0].targetPort}' 2>/dev/null)
[ "$TARGET_PORT" = "80" ] && exit 0 || exit 1
