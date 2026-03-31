#!/bin/bash
# Verify: backup and config files exist
# Check backup exists (may be from static manifest or pod spec)
[ -f /root/kube-apiserver-backup.yaml ] || exit 1
[ -f /root/apiserver-config.txt ] || exit 1
# Accept non-empty OR fallback message
[ -s /root/apiserver-config.txt ] && exit 0
exit 1
