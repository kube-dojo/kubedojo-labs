#!/bin/bash
kubectl logs log-generator -n logging-lab -c sidecar --tail=5 > "$HOME"/sidecar-logs.txt
kubectl get pod log-generator -n logging-lab -o jsonpath='{.spec.containers[*].name}' > "$HOME"/container-names.txt
