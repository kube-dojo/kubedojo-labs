#!/bin/bash
kubectl logs multi-log -n practice -c app --since=1h --timestamps > "$HOME"/app-logs.txt
echo "=== Sidecar logs ===" >> "$HOME"/app-logs.txt
kubectl logs multi-log -n practice -c sidecar --since=1h --timestamps >> "$HOME"/app-logs.txt
cat "$HOME"/app-logs.txt | head -10
