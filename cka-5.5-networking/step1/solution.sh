#!/bin/bash
kubectl delete pod dns-broken -n practice --force --grace-period=0 2>/dev/null
sleep 2
kubectl run dns-broken --image=busybox:1.36 -n practice -- sleep 3600
kubectl wait --for=condition=Ready pod/dns-broken -n practice --timeout=60s
kubectl exec dns-broken -n practice -- nslookup kubernetes.default
