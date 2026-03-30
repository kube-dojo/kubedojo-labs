#!/bin/bash
# Verify: resource-usage.txt exists with content
[ -f /root/resource-usage.txt ] && [ -s /root/resource-usage.txt ] && exit 0 || exit 1
