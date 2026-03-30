#!/bin/bash
kubectl create namespace exam-sim
kubectl run task1 --image=redis:7 -n exam-sim
kubectl create deployment task2 --image=nginx:1.25 --replicas=2 -n exam-sim
kubectl create configmap task3 --from-literal=ENV=production -n exam-sim
kubectl rollout status deployment/task2 -n exam-sim --timeout=60s
kubectl expose deployment task2 --name=task4 --port=80 -n exam-sim
kubectl get svc task4 -n exam-sim -o jsonpath='{.spec.clusterIP}' > /root/task4-ip.txt
