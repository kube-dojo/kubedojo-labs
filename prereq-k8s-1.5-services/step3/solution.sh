#!/bin/bash
kubectl get svc web-nodeport 2>/dev/null || kubectl expose deployment web --name=web-nodeport --port=80 --type=NodePort
