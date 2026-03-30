#!/bin/bash
TYPE=$(kubectl get svc web-clusterip -n svc-lab -o jsonpath='{.spec.type}' 2>/dev/null)
if [ "$TYPE" != "ClusterIP" ]; then
  echo "FAIL: web-clusterip should be ClusterIP type, got: $TYPE"
  exit 1
fi
if [ ! -f /root/cluster-ip.txt ]; then
  echo "FAIL: /root/cluster-ip.txt not found"
  exit 1
fi
if [ ! -f /root/svc-type.txt ]; then
  echo "FAIL: /root/svc-type.txt not found"
  exit 1
fi
echo "PASS"
exit 0
