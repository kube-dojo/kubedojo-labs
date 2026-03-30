#!/bin/bash
# Upgrade to 3 replicas
helm upgrade web bitnami/nginx --set replicaCount=3

# Rollback to revision 1
helm rollback web 1

# Show history
echo "Release history:"
helm history web
