#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: HTTPRoute exists with correct parent ref and hostname
ROUTE=$(kubectl get httproute app-route -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
PARENT=$(kubectl get httproute app-route -n practice -o jsonpath='{.spec.parentRefs[0].name}' 2>/dev/null)
HOST=$(kubectl get httproute app-route -n practice -o jsonpath='{.spec.hostnames[0]}' 2>/dev/null)
[ "$ROUTE" = "app-route" ] && [ "$PARENT" = "lab-gateway" ] && [ "$HOST" = "app.example.com" ] && exit 0 || exit 1
