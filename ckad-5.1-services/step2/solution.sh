#!/bin/bash
kubectl expose deployment web --name=web-nodeport --port=80 --target-port=80 --type=NodePort -n svc-lab
kubectl get svc web-nodeport -n svc-lab -o jsonpath='{.spec.ports[0].nodePort}' > /root/node-port.txt
NP=$(cat /root/node-port.txt)
curl -s localhost:$NP > /dev/null
