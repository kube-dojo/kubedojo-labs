#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  READY=$(kubectl get deployment broken-deploy -n deploy-lab -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
  [ "$READY" = "3" ] && break
  sleep 2
done
if [ "$READY" != "3" ]; then
  echo "FAIL: broken-deploy should have 3 ready replicas"
  exit 1
fi
if [ ! -f $USER_HOME/fixed-replicas.txt ]; then
  echo "FAIL: $USER_HOME/fixed-replicas.txt not found"
  exit 1
fi
echo "PASS"
exit 0
