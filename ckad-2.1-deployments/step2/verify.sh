#!/bin/bash
IMG=$(kubectl get deployment webapp -n deploy-lab -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
if [ "$IMG" != "nginx:1.25" ]; then
  echo "FAIL: Image should be nginx:1.25, got: $IMG"
  exit 1
fi
if [ ! -f /root/rollout-status.txt ]; then
  echo "FAIL: /root/rollout-status.txt not found"
  exit 1
fi
echo "PASS"
exit 0
