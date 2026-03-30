#!/bin/bash
kubectl api-versions > /root/api-versions.txt
kubectl api-resources -o wide > /root/api-resources.txt
kubectl api-resources | grep -w deployments > /root/deployment-api.txt
