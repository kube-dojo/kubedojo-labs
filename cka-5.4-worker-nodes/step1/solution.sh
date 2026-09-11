#!/bin/bash
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{range .status.conditions[*]}  {.type}={.status} - {.message}{"\n"}{end}{end}' > "$HOME"/node-conditions.txt
cat "$HOME"/node-conditions.txt
