#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  READY=$(kubectl get deployment webapp -n dev-workflow -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
  [ "$READY" = "4" ] && break
  sleep 2
done

REPLICAS=$(kubectl get deployment webapp -n dev-workflow -o jsonpath='{.spec.replicas}' 2>/dev/null)
if [ "$REPLICAS" != "4" ]; then
  echo "FAIL: webapp should have 4 replicas, got: $REPLICAS"
  exit 1
fi

IMAGE=$(kubectl get deployment webapp -n dev-workflow -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
if [ "$IMAGE" != "nginx:1.25" ]; then
  echo "FAIL: webapp image should be nginx:1.25, got: $IMAGE"
  exit 1
fi

echo "PASS: Declarative update applied"
exit 0
