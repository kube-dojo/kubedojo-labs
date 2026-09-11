#!/bin/bash
kubectl get events -n practice --sort-by='.lastTimestamp' -o wide > "$HOME"/events.txt
echo "---" >> "$HOME"/events.txt
echo "=== Warning Events ===" >> "$HOME"/events.txt
kubectl get events -n practice --field-selector=type=Warning >> "$HOME"/events.txt 2>&1
cat "$HOME"/events.txt | head -20
