#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Task: pod 'secure-pod' with image 'nginx:1.25' and labels 'app=secure'
if ! kubectl get pod secure-pod >/dev/null 2>&1; then echo "FAIL: Pod 'secure-pod' not found."; exit 1; fi
LABELS=$(kubectl get pod secure-pod -o jsonpath='{.metadata.labels.app}')
IMAGE=$(kubectl get pod secure-pod -o jsonpath='{.spec.containers[0].image}')
if [ "$LABELS" = "secure" ] && [[ "$IMAGE" == *"nginx:1.25"* ]]; then
  echo "PASS: Pod 'secure-pod' verified with correct image and labels!"
  exit 0
fi
echo "FAIL: Pod 'secure-pod' has wrong image ($IMAGE) or labels ($LABELS)."
exit 1
