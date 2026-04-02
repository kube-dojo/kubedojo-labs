#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/frontend.yaml ]; then
  echo "FAIL: $USER_HOME/frontend.yaml does not exist"
  exit 1
fi

for i in $(seq 1 30); do
  STATUS=$(kubectl get pod frontend -n dev-workflow -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  sleep 2
done
if [ "$STATUS" != "Running" ]; then
  echo "FAIL: Pod frontend not running in dev-workflow"
  exit 1
fi

LABEL=$(kubectl get pod frontend -n dev-workflow -o jsonpath='{.metadata.labels.tier}' 2>/dev/null)
if [ "$LABEL" != "frontend" ]; then
  echo "FAIL: Pod frontend missing label tier=frontend"
  exit 1
fi

PORT=$(kubectl get pod frontend -n dev-workflow -o jsonpath='{.spec.containers[0].ports[0].containerPort}' 2>/dev/null)
if [ "$PORT" != "80" ]; then
  echo "FAIL: Container port should be 80, got: $PORT"
  exit 1
fi

echo "PASS: Frontend pod created with correct labels and ports"
exit 0
