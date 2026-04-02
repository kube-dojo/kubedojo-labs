#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod broken-app -n images-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && break
  sleep 2
done
if [ "$STATUS" != "Running" ]; then
  echo "FAIL: broken-app should be Running, got: $STATUS"
  exit 1
fi

IMG=$(kubectl get pod broken-app -n images-lab -o jsonpath='{.spec.containers[0].image}' 2>/dev/null)
if [[ "$IMG" == *"nonexistent"* ]]; then
  echo "FAIL: broken-app still has the broken image"
  exit 1
fi

echo "PASS: broken-app fixed and running"
exit 0
