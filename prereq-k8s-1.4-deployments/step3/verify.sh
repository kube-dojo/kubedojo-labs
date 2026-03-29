#!/bin/bash
# Verify deployment image is nginx:1.26
IMAGE=$(kubectl get deployment webapp -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null)
[ "$IMAGE" = "nginx:1.26" ] || exit 1
exit 0
