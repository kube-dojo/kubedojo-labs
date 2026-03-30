#!/bin/bash
kubectl run nginx --image=nginx --dry-run=client -o yaml > /root/nginx-pod.yaml
