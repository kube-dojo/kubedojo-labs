#!/bin/bash
kubectl patch svc public-svc -n practice -p '{"spec":{"type":"NodePort"}}'
sleep 3
kubectl get svc public-svc -n practice
NODE_PORT=$(kubectl get svc public-svc -n practice -o jsonpath='{.spec.ports[0].nodePort}')
curl -s http://localhost:$NODE_PORT | head -5
