#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod secret-vol-pod -n secrets-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
CONTENT=$(kubectl exec secret-vol-pod -n secrets-lab -- cat /etc/secrets/username 2>/dev/null)
if [ "$CONTENT" != "admin" ]; then
  echo "FAIL: /etc/secrets/username should contain admin"
  exit 1
fi
if [ ! -f /root/mounted-username.txt ]; then
  echo "FAIL: /root/mounted-username.txt not found"
  exit 1
fi
echo "PASS"
exit 0
