#!/bin/bash
kubectl logs log-generator -n logging-lab -c app --tail=10 > /root/app-logs.txt
kubectl logs log-generator -n logging-lab -c app | wc -l | tr -d ' ' > /root/log-line-count.txt
