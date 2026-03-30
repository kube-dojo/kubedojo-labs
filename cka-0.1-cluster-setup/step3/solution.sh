#!/bin/bash
# Get current cluster and user
CLUSTER=$(kubectl config view -o jsonpath='{.clusters[0].name}')
USER=$(kubectl config view -o jsonpath='{.users[0].name}')

# Create and switch to new context
kubectl config set-context cka-practice --cluster="$CLUSTER" --user="$USER"
kubectl config use-context cka-practice

echo "Current context:"
kubectl config current-context
