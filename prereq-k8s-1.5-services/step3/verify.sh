#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify service web-nodeport exists and is NodePort type
# Wait up to 60s for the service to be created
for i in $(seq 1 30); do
  if kubectl get svc web-nodeport > /dev/null 2>&1; then
    SERVICE=$(kubectl get svc web-nodeport -o json 2>/dev/null) || exit 1
    DEPLOYMENT=$(kubectl get deployment web -o json 2>/dev/null) || exit 1
    if python3 -c 'import json, sys
service, deployment = map(json.loads, sys.argv[1:])
selector = service["spec"].get("selector") or {}
labels = deployment["spec"]["template"]["metadata"].get("labels") or {}
sys.exit(not (service["spec"].get("type") == "NodePort" and selector and all(labels.get(k) == v for k, v in selector.items()) and any(p.get("port") == 80 for p in service["spec"].get("ports", []))))' "$SERVICE" "$DEPLOYMENT"; then
      exit 0
    fi
  fi
  sleep 2
done
exit 1
