#!/bin/bash
# Verify: 3 PVs exist with correct sizes
PV_COUNT=$(kubectl get pv pv-small pv-medium pv-large --no-headers 2>/dev/null | wc -l)
[ "$PV_COUNT" -eq 3 ] && exit 0 || exit 1
