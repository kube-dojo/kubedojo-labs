#!/bin/bash
kubectl run search-app --image=busybox:1.36 -n logging-lab -- sh -c 'while true; do echo "INFO: all good"; echo "ERROR: something failed"; echo "WARN: check this"; sleep 3; done'
kubectl wait --for=condition=Ready pod/search-app -n logging-lab --timeout=60s
sleep 6
kubectl logs search-app -n logging-lab | grep ERROR > /root/error-logs.txt
kubectl logs search-app -n logging-lab | grep -c ERROR > /root/error-count.txt
