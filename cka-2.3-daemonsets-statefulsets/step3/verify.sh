#!/bin/bash
SVC=$(kubectl get svc sts-svc -n practice -o json 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "FAIL: Service sts-svc not found"
  exit 1
fi

CIP=$(echo "$SVC" | jq -r '.spec.clusterIP')
if [ "$CIP" = "None" ]; then
  # Also check selector
  SELECTOR=$(echo "$SVC" | jq -r '.spec.selector.app')
  if [ "$SELECTOR" = "web-sts" ]; then
    echo "PASS: Headless service verified with correct selector"
    exit 0
  else
    echo "FAIL: Selector is '$SELECTOR', expected 'web-sts'"
    exit 1
  fi
else
  echo "FAIL: Service is not headless. clusterIP is '$CIP', expected 'None'"
  exit 1
fi