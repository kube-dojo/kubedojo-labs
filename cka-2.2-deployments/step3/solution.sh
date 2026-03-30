#!/bin/bash
kubectl rollout undo deployment/web-deploy -n practice --to-revision=1
kubectl rollout status deployment/web-deploy -n practice --timeout=120s
