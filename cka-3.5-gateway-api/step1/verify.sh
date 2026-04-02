#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: GatewayClass and Gateway exist
GC=$(kubectl get gatewayclass lab-gateway-class -o jsonpath='{.metadata.name}' 2>/dev/null)
GW=$(kubectl get gateway lab-gateway -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
[ "$GC" = "lab-gateway-class" ] && [ "$GW" = "lab-gateway" ] && exit 0 || exit 1
