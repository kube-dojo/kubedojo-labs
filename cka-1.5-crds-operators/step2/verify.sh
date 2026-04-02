#!/bin/bash
if ! kubectl get crd backups.kubedojo.io >/dev/null 2>&1; then
  echo "FAIL: CRD backups.kubedojo.io not found"
  exit 1
fi

# Check schema properties
SCHEMA=$(kubectl get crd backups.kubedojo.io -o jsonpath='{.spec.versions[0].schema.openAPIV3Schema.properties.spec.properties}')
if echo "$SCHEMA" | grep -q "schedule" && echo "$SCHEMA" | grep -q "target" && echo "$SCHEMA" | grep -q "retention"; then
  echo "PASS: CRD backups.kubedojo.io exists with correct schema"
  exit 0
else
  echo "FAIL: CRD found but schema properties are incorrect or missing"
  exit 1
fi