#!/bin/bash
helm install web bitnami/nginx --wait --timeout 5m
echo ""
echo "Release list:"
helm list
