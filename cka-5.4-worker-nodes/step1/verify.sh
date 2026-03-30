#!/bin/bash
# Verify: node-conditions.txt exists with content
[ -f /root/node-conditions.txt ] && [ -s /root/node-conditions.txt ] && exit 0 || exit 1
