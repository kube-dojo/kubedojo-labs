#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod vol-pod -n cm-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ "$S" != "Running" ]; then
  echo "FAIL: vol-pod not Running"
  exit 1
fi
CONTENT=$(kubectl exec vol-pod -n cm-lab -- cat /etc/config/app.properties 2>/dev/null)
if [[ "$CONTENT" != *"database.host"* ]]; then
  echo "FAIL: Mounted config should contain database.host"
  exit 1
fi
if [ ! -f $USER_HOME/mounted-config.txt ]; then
  echo "FAIL: $USER_HOME/mounted-config.txt not found"
  exit 1
fi
echo "PASS"
exit 0
