#!/bin/bash
kubectl run dns-test --image=busybox:1.36 --rm -it --restart=Never -n frontend -- nslookup api.backend.svc.cluster.local > /root/dns-results.txt 2>&1 || true
kubectl create service externalname cross-ns-test --external-name=api.backend.svc.cluster.local -n frontend
