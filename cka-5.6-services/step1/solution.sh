#!/bin/bash
kubectl patch svc api-svc -n practice -p '{"spec":{"selector":{"app":"api","version":"v2"}}}'
sleep 3
kubectl get endpoints api-svc -n practice
