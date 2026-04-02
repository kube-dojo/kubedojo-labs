#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: both ExternalName services exist
EXT1=$(kubectl get svc external-api -n practice -o jsonpath='{.spec.externalName}' 2>/dev/null)
EXT2=$(kubectl get svc external-db -n practice -o jsonpath='{.spec.externalName}' 2>/dev/null)
[ "$EXT1" = "api.example.com" ] && [ "$EXT2" = "db.example.com" ] && exit 0 || exit 1
