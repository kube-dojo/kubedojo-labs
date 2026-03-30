#!/bin/bash
kubectl delete pod fix-me-1 -n exam-practice --grace-period=0 --force 2>/dev/null
kubectl run fix-me-1 --image=nginx -n exam-practice --overrides='{"spec":{"containers":[{"name":"fix-me-1","image":"nginx","securityContext":{"privileged":false,"allowPrivilegeEscalation":false}}]}}'

kubectl delete pod fix-me-2 -n exam-practice --grace-period=0 --force 2>/dev/null
kubectl run fix-me-2 --image=nginx -n exam-practice --overrides='{"spec":{"containers":[{"name":"fix-me-2","image":"nginx","securityContext":{"runAsNonRoot":true,"runAsUser":1000}}]}}'

kubectl wait --for=condition=Ready pod/fix-me-1 -n exam-practice --timeout=30s
kubectl get pod fix-me-1 -n exam-practice -o jsonpath='{.spec.containers[0].securityContext}' > /root/fix1-context.txt
