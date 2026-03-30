#!/bin/bash
kubectl patch svc backend-svc -n practice -p '{"spec":{"selector":{"app":"backend"}}}'
sleep 3
kubectl get endpoints backend-svc -n practice
