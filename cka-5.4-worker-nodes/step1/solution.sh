#!/bin/bash
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{range .status.conditions[*]}  {.type}={.status} - {.message}{"\n"}{end}{end}' > /root/node-conditions.txt
cat /root/node-conditions.txt
