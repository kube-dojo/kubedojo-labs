#!/bin/bash
# Verify: etcd backup file exists
[ -f /root/etcd-backup.db ] && [ -s /root/etcd-backup.db ] && exit 0 || exit 1
