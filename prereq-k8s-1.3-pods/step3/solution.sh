#!/bin/bash
kubectl get pod web -o jsonpath='{.status.podIP}' > /root/web-pod-ip.txt
