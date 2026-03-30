#!/bin/bash
# Verify: resource report exists with capacity info
[ -f /root/resource-report.txt ] && grep -q "Capacity" /root/resource-report.txt && exit 0 || exit 1
