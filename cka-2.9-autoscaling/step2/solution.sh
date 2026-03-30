#!/bin/bash
kubectl scale deployment scale-app -n practice --replicas=4
kubectl rollout status deployment/scale-app -n practice --timeout=120s
