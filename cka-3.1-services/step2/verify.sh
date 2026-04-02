#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: NodePort service exists on port 30080
SVC_TYPE=$(kubectl get svc frontend-nodeport -n practice -o jsonpath='{.spec.type}' 2>/dev/null)
NODE_PORT=$(kubectl get svc frontend-nodeport -n practice -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null)
[ "$SVC_TYPE" = "NodePort" ] && [ "$NODE_PORT" = "30080" ] && exit 0 || exit 1
