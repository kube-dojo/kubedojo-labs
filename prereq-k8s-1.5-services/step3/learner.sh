#!/bin/bash
# expect-exit: 0
kubectl expose deployment web --name=web-nodeport --port=80 --type=NodePort

# expect-exit: 0
kubectl get svc web-nodeport

# expect-exit: 0
NODE_PORT=$(kubectl get svc web-nodeport -o jsonpath='{.spec.ports[0].nodePort}')

# expect-exit: 0
curl -s --connect-timeout 3 --max-time 10 --retry 5 --retry-delay 2 --retry-connrefused "localhost:$NODE_PORT"
