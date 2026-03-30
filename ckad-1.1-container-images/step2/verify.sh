#!/bin/bash
for i in $(seq 1 30); do
  IMG=$(kubectl get deployment pinned-app -n images-lab -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
  [ "$IMG" = "httpd:2.4.59" ] && break
  sleep 2
done
if [ "$IMG" != "httpd:2.4.59" ]; then
  echo "FAIL: pinned-app image should be httpd:2.4.59, got: $IMG"
  exit 1
fi

if [ ! -f /root/rollout-history.txt ]; then
  echo "FAIL: /root/rollout-history.txt does not exist"
  exit 1
fi
if ! grep -q "pinned-app" /root/rollout-history.txt 2>/dev/null; then
  # May just have revision numbers
  if ! grep -q "REVISION" /root/rollout-history.txt 2>/dev/null; then
    echo "FAIL: rollout-history.txt doesn't look like rollout history output"
    exit 1
  fi
fi

echo "PASS"
exit 0
