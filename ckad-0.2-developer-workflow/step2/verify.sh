#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
REPLICAS=$(kubectl get deployment backend -n dev-workflow -o jsonpath='{.spec.replicas}' 2>/dev/null)
if [ "$REPLICAS" != "3" ]; then
  echo "FAIL: backend should have 3 replicas, got: $REPLICAS"
  exit 1
fi

IMAGE=$(kubectl get deployment backend -n dev-workflow -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
if [ "$IMAGE" != "redis:7.2" ]; then
  echo "FAIL: backend image should be redis:7.2, got: $IMAGE"
  exit 1
fi

if [ ! -f $USER_HOME/backend-image.txt ]; then
  echo "FAIL: $USER_HOME/backend-image.txt does not exist"
  exit 1
fi
FILE_IMG=$(cat $USER_HOME/backend-image.txt | tr -d '[:space:]')
if [ "$FILE_IMG" != "redis:7.2" ]; then
  echo "FAIL: File should contain redis:7.2, got: $FILE_IMG"
  exit 1
fi

echo "PASS: Backend deployment iterated correctly"
exit 0
