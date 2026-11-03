#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get service web-svc >/dev/null 2>&1; then echo "FAIL: Service 'web-svc' not found."; exit 1; fi
SERVICE=$(kubectl get service web-svc -o json) || exit 1
DEPLOYMENT=$(kubectl get deployment web -o json) || exit 1
if python3 -c 'import json, sys
service, deployment = map(json.loads, sys.argv[1:])
selector = service["spec"].get("selector") or {}
labels = deployment["spec"]["template"]["metadata"].get("labels") or {}
sys.exit(not (selector and all(labels.get(k) == v for k, v in selector.items()) and any(p.get("port") == 80 for p in service["spec"].get("ports", []))))' "$SERVICE" "$DEPLOYMENT"; then
  echo "PASS: Service 'web-svc' selects the web deployment on port 80."
  exit 0
fi
echo "FAIL: Service must select the web deployment and expose port 80."
exit 1
