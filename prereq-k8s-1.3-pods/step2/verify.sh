#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Task: pod 'secure-pod' with image 'nginx:1.25' and labels 'app=secure'
if ! kubectl get pod secure-pod -n default >/dev/null 2>&1; then echo "FAIL: Pod 'secure-pod' not found in default."; exit 1; fi
LABELS=$(kubectl get pod secure-pod -n default -o jsonpath='{.metadata.labels.app}') || exit 2
IMAGE=$(kubectl get pod secure-pod -n default -o jsonpath='{.spec.containers[0].image}') || exit 2
if [ "$LABELS" = "secure" ] && [ "$IMAGE" = "nginx:1.25" ]; then
  echo "PASS: Pod 'secure-pod' verified with correct image and labels!"
  exit 0
fi
echo "FAIL: Pod 'secure-pod' has wrong image ($IMAGE) or labels ($LABELS)."
exit 1
