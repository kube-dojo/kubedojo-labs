#!/bin/bash
kubectl rollout undo deployment/webapp
kubectl rollout status deployment/webapp --timeout=120s
