#!/bin/bash
# Verify: health report file exists
[ -f /root/cp-health.txt ] && [ -s /root/cp-health.txt ] && exit 0 || exit 1
