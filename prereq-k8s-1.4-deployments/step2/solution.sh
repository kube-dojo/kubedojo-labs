#!/bin/bash
kubectl scale deployment webapp --replicas=5
kubectl rollout status deployment/webapp --timeout=120s
