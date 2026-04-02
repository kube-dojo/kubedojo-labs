#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod web-init -n multi-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  sleep 2
done
if [ "$STATUS" != "Running" ]; then
  echo "FAIL: web-init not Running, got: $STATUS"
  exit 1
fi

INIT_NAME=$(kubectl get pod web-init -n multi-lab -o jsonpath='{.spec.initContainers[0].name}' 2>/dev/null)
if [ "$INIT_NAME" != "init-config" ]; then
  echo "FAIL: Init container should be named init-config, got: $INIT_NAME"
  exit 1
fi

# Verify the file was written
CONTENT=$(kubectl exec web-init -n multi-lab -c web -- cat /usr/share/nginx/html/status.txt 2>/dev/null)
if [[ "$CONTENT" != *"Initialized"* ]]; then
  echo "FAIL: /usr/share/nginx/html/status.txt should contain 'Initialized'"
  exit 1
fi

echo "PASS"
exit 0
