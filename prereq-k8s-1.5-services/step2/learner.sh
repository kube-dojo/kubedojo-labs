#!/bin/bash
# expect-exit: 0
kubectl get svc web-svc -o jsonpath='{.spec.clusterIP}'

# expect-exit: 0
CLUSTER_IP=$(kubectl get svc web-svc -o jsonpath='{.spec.clusterIP}')

# expect-exit: 0
curl -s --connect-timeout 3 --max-time 10 --retry 5 --retry-delay 2 --retry-connrefused "$CLUSTER_IP"

# expect-exit: 0
curl -s --connect-timeout 3 --max-time 10 --retry 5 --retry-delay 2 --retry-connrefused "$CLUSTER_IP" > "$HOME"/curl-output.txt
