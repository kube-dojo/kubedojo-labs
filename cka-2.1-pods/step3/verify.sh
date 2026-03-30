#!/bin/bash
# Verify: pod has correct resource requests and limits
CPU_REQ=$(kubectl get pod resource-pod -n practice -o jsonpath='{.spec.containers[0].resources.requests.cpu}' 2>/dev/null)
MEM_REQ=$(kubectl get pod resource-pod -n practice -o jsonpath='{.spec.containers[0].resources.requests.memory}' 2>/dev/null)
CPU_LIM=$(kubectl get pod resource-pod -n practice -o jsonpath='{.spec.containers[0].resources.limits.cpu}' 2>/dev/null)
MEM_LIM=$(kubectl get pod resource-pod -n practice -o jsonpath='{.spec.containers[0].resources.limits.memory}' 2>/dev/null)

[ "$CPU_REQ" = "100m" ] && [ "$MEM_REQ" = "64Mi" ] && [ "$CPU_LIM" = "200m" ] && [ "$MEM_LIM" = "128Mi" ] && exit 0
exit 1
