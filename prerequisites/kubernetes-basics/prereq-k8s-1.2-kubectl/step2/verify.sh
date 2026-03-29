#!/bin/bash
# Verify kubelet version file exists and contains a version string
[ -f /root/kubelet-version.txt ] || exit 1
VERSION=$(cat /root/kubelet-version.txt | tr -d '[:space:]')
[ -z "$VERSION" ] && exit 1
# Should match a pattern like v1.XX.X
echo "$VERSION" | grep -qE '^v1\.' || exit 1
exit 0
