#!/bin/bash
kubectl get ingress path-ingress -n ingress-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: Ingress path-ingress not found"
  exit 1
fi
PATHS=$(kubectl get ingress path-ingress -n ingress-lab -o jsonpath='{.spec.rules[0].http.paths[*].path}' 2>/dev/null)
if [[ "$PATHS" != *"/frontend"* ]] || [[ "$PATHS" != *"/backend"* ]]; then
  echo "FAIL: Should have /frontend and /backend paths"
  exit 1
fi
if [ ! -f /root/path-count.txt ]; then
  echo "FAIL: /root/path-count.txt not found"
  exit 1
fi
echo "PASS"
exit 0
