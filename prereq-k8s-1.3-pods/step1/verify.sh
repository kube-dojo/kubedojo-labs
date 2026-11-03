#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get pod web >/dev/null 2>&1; then echo "FAIL: Pod 'web' not found."; exit 1; fi
IMAGE=$(kubectl get pod web -o jsonpath='{.spec.containers[0].image}') || exit 2
if [ "$IMAGE" = "nginx:1.25" ]; then echo "PASS: Pod 'web' uses nginx:1.25!"; exit 0; fi
echo "FAIL: Pod 'web' uses $IMAGE, expected nginx:1.25."
exit 1
