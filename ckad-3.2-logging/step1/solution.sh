#!/bin/bash
kubectl wait --for=condition=Ready pod/log-generator -n logging-lab --timeout=120s 2>/dev/null || true
sleep 10  # let some logs accumulate
kubectl logs log-generator -n logging-lab -c app --tail=10 > /root/app-logs.txt
kubectl logs log-generator -n logging-lab -c app | wc -l | tr -d ' ' > /root/log-line-count.txt
