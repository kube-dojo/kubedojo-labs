#!/bin/bash
kubectl apply -f /root/old-manifest.yaml
kubectl explain deployment --api-version=apps/v1 2>/dev/null | head -10 > /root/explain-output.txt
