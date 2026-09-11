#!/bin/bash
echo "deploy" > "$HOME"/deploy-short.txt
echo "Short name for deployments:"
cat "$HOME"/deploy-short.txt
echo ""
echo "Full api-resources entry:"
kubectl api-resources | grep deployments
