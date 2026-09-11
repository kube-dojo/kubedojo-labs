#!/bin/bash
echo "=== Capacity ===" > "$HOME"/resource-report.txt
kubectl get node -o jsonpath='{range .items[*]}Capacity: CPU={.status.capacity.cpu} Memory={.status.capacity.memory}{"\n"}Allocatable: CPU={.status.allocatable.cpu} Memory={.status.allocatable.memory}{"\n"}{end}' >> "$HOME"/resource-report.txt
echo "" >> "$HOME"/resource-report.txt
echo "=== Pod Resource Requests ===" >> "$HOME"/resource-report.txt
kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{.metadata.namespace}/{.metadata.name}: CPU={.spec.containers[0].resources.requests.cpu} Memory={.spec.containers[0].resources.requests.memory}{"\n"}{end}' >> "$HOME"/resource-report.txt
echo "" >> "$HOME"/resource-report.txt
echo "=== Node Taints ===" >> "$HOME"/resource-report.txt
kubectl describe node | grep -A5 "Taints:" >> "$HOME"/resource-report.txt
cat "$HOME"/resource-report.txt
