#!/bin/bash
# Verify: CNI config backup exists
[ -f /root/cni-config-backup.json ] && [ -s /root/cni-config-backup.json ] && exit 0 || exit 1
