#!/bin/bash
# Verify the pod count file exists and contains a number >= 4
[ -f /root/cp-pod-count.txt ] || exit 1
COUNT=$(cat /root/cp-pod-count.txt | tr -d '[:space:]')
# Check it's a number
echo "$COUNT" | grep -qE '^[0-9]+$' || exit 1
# Control plane should have at least 4 pods (etcd, apiserver, controller-manager, scheduler)
[ "$COUNT" -ge 4 ] || exit 1
exit 0
