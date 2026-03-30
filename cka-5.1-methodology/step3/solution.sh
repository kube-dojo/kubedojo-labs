#!/bin/bash
kubectl rollout undo deployment/webapp -n practice
kubectl rollout status deployment/webapp -n practice --timeout=60s
kubectl get pods -n practice -l app=webapp
