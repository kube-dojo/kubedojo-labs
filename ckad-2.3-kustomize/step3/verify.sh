#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  SR=$(kubectl get deployment staging-myapp -n staging -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
  [ "$SR" = "2" ] && break
  sleep 2
done
if [ "$SR" != "2" ]; then
  echo "FAIL: staging-myapp should have 2 ready replicas"
  exit 1
fi

for i in $(seq 1 30); do
  PR=$(kubectl get deployment prod-myapp -n production -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
  [ "$PR" = "5" ] && break
  sleep 2
done
if [ "$PR" != "5" ]; then
  echo "FAIL: prod-myapp should have 5 ready replicas"
  exit 1
fi

if [ ! -f $USER_HOME/staging-deploy-name.txt ]; then
  echo "FAIL: $USER_HOME/staging-deploy-name.txt not found"
  exit 1
fi
echo "PASS"
exit 0
