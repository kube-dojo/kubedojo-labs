#!/bin/bash
kubectl set image deployment/webapp nginx=nginx:1.26
kubectl rollout status deployment/webapp --timeout=120s
