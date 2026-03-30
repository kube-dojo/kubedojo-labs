#!/bin/bash
# Verify: both StorageClasses exist
SC1=$(kubectl get sc fast-local -o jsonpath='{.metadata.name}' 2>/dev/null)
SC2=$(kubectl get sc standard-local -o jsonpath='{.metadata.name}' 2>/dev/null)
[ "$SC1" = "fast-local" ] && [ "$SC2" = "standard-local" ] && exit 0 || exit 1
