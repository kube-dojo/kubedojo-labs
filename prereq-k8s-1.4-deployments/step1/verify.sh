#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get deployment webapp >/dev/null 2>&1; then echo "FAIL: Deployment 'webapp' not found."; exit 1; fi
REPLICAS=$(kubectl get deployment webapp -o jsonpath='{.spec.replicas}') || exit 2
IMAGE=$(kubectl get deployment webapp -o jsonpath='{.spec.template.spec.containers[0].image}') || exit 2
if [ "$REPLICAS" = 3 ] && [ "$IMAGE" = 'nginx:1.25' ]; then echo "PASS: Deployment 'webapp' has 3 replicas using nginx:1.25!"; exit 0; fi
echo "FAIL: Deployment has $REPLICAS replicas and image $IMAGE, expected 3 and nginx:1.25."
exit 1
