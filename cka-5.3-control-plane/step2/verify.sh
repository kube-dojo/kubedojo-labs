#!/bin/bash
# Verify: backup and config files exist
[ -f /root/kube-apiserver-backup.yaml ] && [ -f /root/apiserver-config.txt ] && [ -s /root/apiserver-config.txt ] && exit 0 || exit 1
