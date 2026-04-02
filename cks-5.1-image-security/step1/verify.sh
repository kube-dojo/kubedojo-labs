#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/nginx-digest.txt ] || [ ! -s $USER_HOME/nginx-digest.txt ]; then
  echo "FAIL: $USER_HOME/nginx-digest.txt missing or empty"
  exit 1
fi
if ! kubectl get pod pinned-pod -n image-lab &>/dev/null; then
  echo "FAIL: Pod pinned-pod not found"
  exit 1
fi
IMAGE=$(kubectl get pod pinned-pod -n image-lab -o jsonpath='{.spec.containers[0].image}' 2>/dev/null)
if ! echo "$IMAGE" | grep -q "sha256"; then
  # Check the file fallback
  if [ -f $USER_HOME/pinned-image.txt ] && grep -q "sha256" $USER_HOME/pinned-image.txt; then
    true
  else
    echo "FAIL: Pod should use image digest (sha256)"
    exit 1
  fi
fi
for f in image-tag-risks.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
