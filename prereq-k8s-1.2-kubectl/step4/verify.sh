#!/bin/bash
# Verify the nginx pod manifest exists and has correct content
[ -f /root/nginx-pod.yaml ] || exit 1
grep -q "kind: Pod" /root/nginx-pod.yaml 2>/dev/null || exit 1
grep -q "nginx" /root/nginx-pod.yaml 2>/dev/null || exit 1
exit 0
