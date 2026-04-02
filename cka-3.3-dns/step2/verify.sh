#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: dns-results.txt exists and ExternalName service created
FILE_OK=$(test -f $USER_HOME/dns-results.txt && echo "yes")
SVC_TYPE=$(kubectl get svc cross-ns-test -n frontend -o jsonpath='{.spec.type}' 2>/dev/null)
EXT_NAME=$(kubectl get svc cross-ns-test -n frontend -o jsonpath='{.spec.externalName}' 2>/dev/null)
[ "$FILE_OK" = "yes" ] && [ "$SVC_TYPE" = "ExternalName" ] && [ "$EXT_NAME" = "api.backend.svc.cluster.local" ] && exit 0 || exit 1
