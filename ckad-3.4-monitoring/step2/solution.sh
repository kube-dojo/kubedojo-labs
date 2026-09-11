#!/bin/bash
kubectl get events -n monitoring-lab --sort-by='.lastTimestamp' > "$HOME"/events.txt
kubectl get events -A --field-selector type=Warning > "$HOME"/warning-events.txt 2>/dev/null || echo "No warning events" > "$HOME"/warning-events.txt
