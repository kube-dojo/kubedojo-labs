#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
STATUS=$(kubectl get pod broken-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
IMAGE=$(kubectl get pod broken-pod -n practice -o jsonpath='{.spec.containers[0].image}' 2>/dev/null)

if [ "$STATUS" = "Running" ] && [ "$IMAGE" = "nginx:1.25" ]; then
  echo "PASS: broken-pod is fixed and running"
  exit 0
else
  echo "FAIL: broken-pod status: $STATUS, image: $IMAGE. Expected Running with nginx:1.25"
  exit 1
fi