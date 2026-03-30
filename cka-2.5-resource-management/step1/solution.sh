#!/bin/bash
kubectl create namespace quota-test 2>/dev/null || true
kubectl create quota ns-quota -n quota-test \
  --hard=pods=2,requests.cpu=500m,requests.memory=512Mi 2>/dev/null || true
