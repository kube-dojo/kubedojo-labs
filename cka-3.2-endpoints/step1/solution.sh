#!/bin/bash
kubectl scale deployment web -n practice --replicas=5
kubectl wait --for=condition=Ready pod -l app=web -n practice --timeout=60s
sleep 3
ENDPOINT_COUNT=$(kubectl get endpointslices -n practice -l kubernetes.io/service-name=web -o jsonpath='{.items[0].endpoints[*].addresses[*]}' | wc -w | tr -d ' ')
echo "$ENDPOINT_COUNT" > /root/endpoint-count.txt
