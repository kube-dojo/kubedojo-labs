#!/bin/bash
echo "deploy" > /root/deploy-short.txt
echo "Short name for deployments:"
cat /root/deploy-short.txt
echo ""
echo "Full api-resources entry:"
kubectl api-resources | grep deployments
