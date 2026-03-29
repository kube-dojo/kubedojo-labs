#!/bin/bash
# Verify SSH key pair exists
[ -f /root/.ssh/lab_key ] || exit 1
[ -f /root/.ssh/lab_key.pub ] || exit 1
exit 0
