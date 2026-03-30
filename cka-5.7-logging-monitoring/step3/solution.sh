#!/bin/bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml 2>/dev/null
kubectl patch deployment metrics-server -n kube-system --type='json' -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]' 2>/dev/null
kubectl wait --for=condition=Ready pod -l k8s-app=metrics-server -n kube-system --timeout=120s 2>/dev/null
sleep 30
echo "=== Node Resource Usage ===" > /root/resource-usage.txt
kubectl top nodes >> /root/resource-usage.txt 2>&1
echo "" >> /root/resource-usage.txt
echo "=== Pod Resource Usage (practice) ===" >> /root/resource-usage.txt
kubectl top pods -n practice >> /root/resource-usage.txt 2>&1
echo "" >> /root/resource-usage.txt
echo "=== Top Memory Consumers ===" >> /root/resource-usage.txt
kubectl top pods --all-namespaces --sort-by=memory >> /root/resource-usage.txt 2>&1
cat /root/resource-usage.txt
