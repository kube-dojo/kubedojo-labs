#!/bin/bash
# Verify file exists and contains coredns (a key kube-system pod)
# Wait up to 60s for kube-system pods (including coredns) to be running
[ -f /root/kube-system-pods.txt ] || exit 1
if grep -q "coredns" /root/kube-system-pods.txt 2>/dev/null; then
  exit 0
fi
# If the file was saved before coredns started, wait and re-check
for i in $(seq 1 30); do
  if kubectl get pods -n kube-system --no-headers 2>/dev/null | grep -q "coredns"; then
    # coredns is running but not in the saved file — user needs to re-save
    # Still pass if the file has other kube-system content
    grep -q "coredns" /root/kube-system-pods.txt 2>/dev/null && exit 0
    exit 1
  fi
  sleep 2
done
exit 1
