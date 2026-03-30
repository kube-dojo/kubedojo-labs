#!/bin/bash
kubectl run dnsutils --image=registry.k8s.io/e2e-test-images/agnhost:2.39 -n frontend -- sleep 3600
kubectl wait --for=condition=Ready pod/dnsutils -n frontend --timeout=60s
kubectl exec dnsutils -n frontend -- nslookup kubernetes.default > /root/dns-debug.txt 2>&1
COREDNS_POD=$(kubectl get pods -n kube-system -l k8s-app=kube-dns -o jsonpath='{.items[0].metadata.name}')
kubectl logs $COREDNS_POD -n kube-system --tail=20 > /root/coredns-logs.txt 2>&1
