#!/bin/bash
kubectl expose deployment web --name=web-clusterip --port=80 --target-port=80 -n svc-lab
kubectl get svc web-clusterip -n svc-lab -o jsonpath='{.spec.clusterIP}' > /root/cluster-ip.txt
kubectl get svc web-clusterip -n svc-lab -o jsonpath='{.spec.type}' > /root/svc-type.txt
