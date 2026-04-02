#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  READY=$(kubectl get deployment webapp -n deploy-lab -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
  [ "$READY" = "5" ] && break
  sleep 2
done
if [ "$READY" != "5" ]; then
  echo "FAIL: webapp should have 5 ready replicas, got: $READY"
  exit 1
fi
if [ ! -f $USER_HOME/ready-replicas.txt ]; then
  echo "FAIL: $USER_HOME/ready-replicas.txt not found"
  exit 1
fi
echo "PASS"
exit 0
