#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Check pod web
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod web -n ckad-practice -o jsonpath='{.status.phase}' 2>/dev/null)
  if [ "$STATUS" = "Running" ]; then
    break
  fi
  sleep 2
done
if [ "$STATUS" != "Running" ]; then
  echo "FAIL: Pod 'web' not running in ckad-practice"
  exit 1
fi

# Check deployment api
REPLICAS=$(kubectl get deployment api -n ckad-practice -o jsonpath='{.spec.replicas}' 2>/dev/null)
if [ "$REPLICAS" != "3" ]; then
  echo "FAIL: Deployment 'api' should have 3 replicas, got: $REPLICAS"
  exit 1
fi

# Check generator pod
if [ ! -f $USER_HOME/generator.yaml ]; then
  echo "FAIL: $USER_HOME/generator.yaml does not exist"
  exit 1
fi
GEN_STATUS=$(kubectl get pod generator -n ckad-practice -o jsonpath='{.status.phase}' 2>/dev/null)
if [ "$GEN_STATUS" != "Running" ]; then
  echo "FAIL: Pod 'generator' not running in ckad-practice"
  exit 1
fi

echo "PASS: All imperative resources created"
exit 0
