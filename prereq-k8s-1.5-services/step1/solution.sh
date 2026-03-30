#!/bin/bash
kubectl get svc web-svc 2>/dev/null || kubectl expose deployment web --name=web-svc --port=80
sleep 3
