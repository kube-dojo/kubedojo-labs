#!/bin/bash
kubectl api-versions > "$HOME"/api-versions.txt
kubectl api-resources -o wide > "$HOME"/api-resources.txt
kubectl api-resources | grep -w deployments > "$HOME"/deployment-api.txt
