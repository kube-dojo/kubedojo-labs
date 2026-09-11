#!/bin/bash
kubectl top pods -n practice > "$HOME"/resource-usage.txt 2>&1 || \
  echo "Metrics not yet available — this is expected in some lab environments" > "$HOME"/resource-usage.txt
kubectl top nodes >> "$HOME"/resource-usage.txt 2>&1 || true
