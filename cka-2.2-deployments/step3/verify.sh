#!/bin/bash
IMAGE=$(kubectl get deployment web-deploy -n practice -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
if [ "$IMAGE" = "nginx:1.24" ]; then
  echo "PASS: Rollback to revision 1 (nginx:1.24) verified"
  exit 0
else
  echo "FAIL: Current image is $IMAGE, expected nginx:1.24"
  exit 1
fi