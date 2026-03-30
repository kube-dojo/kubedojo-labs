#!/bin/bash
kubectl run network-test --image=nginx:1.25 -n practice
kubectl wait --for=condition=Ready pod/network-test -n practice --timeout=60s
kubectl get pod network-test -n practice -o jsonpath='{.status.podIP}' > /root/pod-ip.txt
echo "Pod IP: $(cat /root/pod-ip.txt)"
echo "Node CIDR: $(kubectl get node -o jsonpath='{.items[0].spec.podCIDR}')"
